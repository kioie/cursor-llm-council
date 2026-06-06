---
name: llm-council
description: >-
  Convene a multi-seat LLM council in Claude Code — parallel subagents on
  opus/sonnet/haiku, ballots, chair ruling. Use when the user says "llm council",
  "council session", "/llm-council", or @claude/COUNCIL.md.
disable-model-invocation: false
---

# LLM Council (Claude Code)

Parallel council deliberation using Claude Code **subagents**. Each seat = persona + Claude model tier.

## Important: Claude models only

Claude Code subagents use **opus**, **sonnet**, or **haiku** (or full Claude model IDs). Cross-provider models (GPT, Gemini, etc.) are a **Cursor** feature. Presets for Claude live in `claude/presets/`.

## Quick start

```
/llm-council Should we ship feature X?
```

Or:

```
council: Migrate to passkeys before GA?
council @security: expose admin API without VPN?
```

## Step 0 — Resolve roster

Priority:

1. User inline overrides (`engineer=sonnet chair=opus`)
2. `.llm-council/roster.yaml` with `preset: engineering` (user's local config)
3. `claude/presets/<preset>.yaml` (default: engineering)

Presets: `engineering` | `product` | `security` | `minimal`

**Create member:** `council roster: create member` → write `.llm-council/members/<id>.yaml`, update roster. Use Claude model aliases in the `model` field.

## Step 1 — Intake

| Field | Rule |
|-------|------|
| Question | Ask once if missing |
| Mode | `quick` / `full` (default) / `deep` |

## Step 2 — Phase 1: Deliberation (parallel)

Spawn **one subagent per seat in parallel** (same turn, multiple Agent invocations). For each member:

- Use the **Agent** tool with a read-only posture (Read, Grep, Glob only — no edits unless user asked)
- Pass `model` from the member's roster entry (`opus` | `sonnet` | `haiku`)
- Prompt from `templates/deliberation.md` filled with name, title, persona, question, context

Announce: `🏛️ {council name} — {N} members deliberating…`

## Step 3 — Phase 2: Ballots (skip if `quick`)

Parallel subagents again. Each receives the **full Phase 1 transcript**. Prompt: `templates/ballot.md`.

## Step 4 — Phase 3: Chair ruling

Chair seat (`chair: true`) synthesizes via `templates/ruling.md`. Prefer `model: opus` for chair.

## Output

```markdown
# 🏛️ Council Ruling
**Council:** …
**Question:** …
**Motion:** Carried X–Y
## Ruling …
## Votes | Member | Model | Vote |
```

Offer save: `council-rulings/YYYY-MM-DD-<slug>.md`.

## Don't

- Don't claim multi-provider models — that's Cursor-only.
- Don't edit code during council unless the question requires it.
- Subagents cannot spawn subagents — orchestrator runs all phases from main session.
