---
name: llm-council
description: >-
  Convene a multi-model LLM council in Cursor — pick or create council members,
  parallel deliberation, ballots, and a chair ruling. Use when the user says
  "llm council", "council session", "convene the council", "/council",
  "configure council", wants multiple models to debate a decision, or
  @mentions COUNCIL.md.
---

# LLM Council

Zero-dependency deliberation for developers. Parallel Task subagents, user-chosen models, selectable council members.

## Quick start

```
council: Should we ship X?
council @product: Launch freemium before GA?
council roster: create member
```

## Step 0 — Resolve roster (before deliberation)

Load council members in this order:

1. **Webhook / automation payload** — `members[]`, `preset`, or `roster` path if present in trigger body.
2. **`.llm-council/roster.yaml`** in project root (user's local config, gitignored).
3. **Skill default** — `presets/engineering.yaml` from this repo / skill folder.

### Presets (`presets/`)

| Preset | Seats |
|--------|-------|
| `engineering` | Architect, Engineer, Strategist, Pragmatist, Chair |
| `product` | PM, Design, Growth, Eng liaison, Chair |
| `security` | AppSec, Infra, Privacy, Pragmatist, Chair |
| `minimal` | Builder, Skeptic, User advocate, Chair (4) |

User picks via: `council @security: …`, `preset: product` in webhook, or AskQuestion.

### Select or create members

**Select preset** — AskQuestion or accept shorthand:
```
council @minimal: GraphQL or tRPC?
```

**Swap one seat** — inline without editing files:
```
council engineer=gpt-5.2 chair=opus "migrate to passkeys?"
```

**Create member** — when user says `create council member`, `add seat`, or `council roster`:

1. Ask: name, title, persona (one paragraph), model (from models they can use), chair? (yes/no).
2. Write to `.llm-council/members/<id>.yaml` using [members/member.example.yaml](../../../members/member.example.yaml).
3. Append `ref: <id>` to `.llm-council/roster.yaml` (create from [.llm-council.example/roster.yaml](../../../.llm-council.example/roster.yaml) if missing).
4. Confirm roster table before convening.

**Configure roster** — `council roster` shows current seats; offer preset swap or member CRUD.

### Roster resolution rules

- `ref: alex` → load `.llm-council/members/alex.yaml`
- Inline member objects in `roster.yaml` override refs
- `preset: security` in roster.yaml → start from `presets/security.yaml`, then apply overrides
- Exactly one `chair: true`; if none, last member is chair
- 3–7 members; confirm before spawning >5

## Step 1 — Intake

| Field | Rule |
|-------|------|
| Question | Ask once if missing |
| Context | Only if ambiguous |
| Mode | `quick` / `full` (default) / `deep` — infer from phrasing |

## Step 2 — Phase 1: Deliberation (parallel)

One **Task** per member in a **single message**. Each task:

- `subagent_type`: `generalPurpose`
- `model`: member's model
- `readonly`: `true` (unless user asked for implementation)
- Prompt: [templates/deliberation.md](../../../templates/deliberation.md)

Announce: `🏛️ {preset name} — {N} members deliberating…`

## Step 3 — Phase 2: Ballots (skip in `quick`)

Parallel Tasks with full Phase 1 transcript → [templates/ballot.md](../../../templates/ballot.md).

## Step 4 — Phase 3: Ruling

Chair Task → [templates/ruling.md](../../../templates/ruling.md).

## Output

```markdown
# 🏛️ Council Ruling

**Council:** {preset or custom name}
**Question:** …
**Motion:** Carried X–Y

## Ruling
…

## Votes
| Member | Title | Model | Vote |
…

<details><summary>Full deliberations</summary>…</details>
```

Offer save: `council-rulings/YYYY-MM-DD-<slug>.md`.

## Automation mode

When triggered by **LLM Council** Cursor Automation (webhook or manual run), parse JSON body:

```json
{
  "question": "required",
  "context": "optional",
  "mode": "full|quick|deep",
  "preset": "engineering|product|security|minimal",
  "members": [{ "name": "...", "title": "...", "model": "...", "persona": "...", "chair": false }]
}
```

`members` overrides preset. Follow the same phases; post ruling to automation output.

## Don't

- No npm, no CURSOR_API_KEY, no repo edits during council (unless asked).
- Don't invent model slugs — use user's accessible models; fallback `composer-2.5-fast` once on failure.
