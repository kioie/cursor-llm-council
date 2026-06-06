# LLM Council

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

**Multi-model deliberation for developers** — in Cursor chat, Claude Code, or via Cursor Automations.

Five (or fewer) models debate your question in parallel, vote, and produce a binding ruling. No SDK. No API keys. No `npm install`.

```
council: Should we ship feature X this sprint?
council @security: Expose the admin API without VPN?
```

## Quick start (Cursor)

```bash
git clone https://github.com/kioie/llm-council.git
cd llm-council
./install.sh
```

Then in any project:

```
council: Migrate to passkeys before GA?
```

Or `@COUNCIL.md` + your question.

---

## Members & models — how it works

**You do not pick members and models separately in a UI.** Each council **seat** is one record: a persona (how they argue) **and** a model (which LLM plays them), bundled together.

### One seat = persona + model

```yaml
- id: architect
  name: Elena
  title: Systems Architect
  model: claude-4.6-opus-high-thinking   # model for this seat
  persona: >
    Systems thinker. Coupling, ops risk, scalability…
```

At runtime, Cursor spawns **one parallel subagent per seat**, using that seat's `model` and `persona`. Elena always runs on Opus as the architect; Marcus runs on Codex as the engineer — different models, different voices.

### Who picks the model?

**You do** — but only from models your Cursor plan supports. Presets ship with suggested defaults; change them anytime in YAML or inline in chat. If a model fails, the skill retries once with `composer-2.5-fast`.

### How the roster is chosen (priority order)

| Priority | Source | When |
|----------|--------|------|
| 1 | Webhook / automation JSON | `members[]` or `preset` in POST body |
| 2 | `.llm-council/roster.yaml` | Your local config (gitignored, per project) |
| 3 | Built-in preset | `presets/engineering.yaml` if nothing else is set |

### Three ways to configure seats

**A. Use a preset (easiest)** — pick a council *type*; seats and default models are pre-bundled:

```
council: Should we ship X?              # engineering (default)
council @security: Expose admin API?    # security council
council @minimal: GraphQL or tRPC?      # 4 seats, fastest
```

| Preset | Command | Seats |
|--------|---------|-------|
| Engineering (default) | `council: …` | Architect, Engineer, Strategist, Pragmatist, Chair |
| Product | `council @product: …` | PM, Design, Growth, Eng liaison, Chair |
| Security | `council @security: …` | AppSec, Infra, Privacy, Pragmatist, Chair |
| Minimal (fast) | `council @minimal: …` | Builder, Skeptic, User advocate, Chair |

**B. Swap models inline (one session)** — override a seat without editing files:

```
council engineer=gpt-5.2 chair=claude-4.6-opus-high-thinking "GraphQL or tRPC?"
```

**C. Create your own members (permanent)** — define seats in `.llm-council/`:

```bash
mkdir -p .llm-council/members
cp members/member.example.yaml .llm-council/members/alex.yaml
# edit name, title, model, persona — then add ref to .llm-council/roster.yaml
```

Or in chat: `council roster: create member` — the agent asks for name, title, persona, model, and chair yes/no, then writes the files.

See [members/README.md](members/README.md) for the full member schema.

### The Chair

Exactly **one** seat has `chair: true`. That seat:

- Runs the **final synthesis** (Phase 3) after deliberation and voting
- Can use a **different model** than other seats (e.g. a stronger model for the ruling doc)

If no chair is marked, the last seat in the roster becomes chair.

### What happens when you ask a question

```
You provide:  question (+ optional preset / member overrides)
Each seat:    persona + model → parallel subagent
Phase 1:      independent deliberation (all seats in parallel)
Phase 2:      ballots — each seat reviews full transcript, votes support/oppose/abstain
Phase 3:      Chair writes binding ruling + vote tally
```

Skip Phase 2 with `council quick: …` (opinions → short ruling only).

---

## Modes

| Mode | Command | What runs |
|------|---------|-----------|
| Quick | `council quick: …` | Opinions → short ruling |
| Full | `council: …` | Deliberate → vote → ruling |
| Deep | `council deep: …` | Two deliberation rounds → vote → ruling |

---

## Cursor Automation

Run council from a webhook or the Automations UI — no chat required.

```bash
./install.sh --automation
```

Import [automations/llm-council-webhook.workflow.json](automations/llm-council-webhook.workflow.json) in **Cursor → Automations**, or ask your agent to open it.

**POST after save** — `preset` picks the council; `members` overrides it entirely:

```bash
curl -X POST "$WEBHOOK_URL" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "question": "Adopt event sourcing for billing?",
    "preset": "engineering",
    "mode": "full"
  }'
```

**Custom members in webhook** (overrides preset):

```json
{
  "question": "Ship dark mode in v2?",
  "members": [
    {
      "name": "Alex",
      "title": "Design Lead",
      "model": "gemini-3.5-flash",
      "persona": "UX and accessibility first."
    },
    {
      "name": "Sam",
      "title": "Chair",
      "model": "claude-4.6-opus-high-thinking",
      "persona": "Synthesizes binding rulings.",
      "chair": true
    }
  ]
}
```

**PR review** — comment `/council` on a PR using [automations/llm-council-pr.workflow.json](automations/llm-council-pr.workflow.json).

Details: [automations/README.md](automations/README.md)

---

## Claude Code

Same templates and roster format; no parallel Task subagents. See [claude/COUNCIL.md](claude/COUNCIL.md).

---

## Project layout

```
.cursor/skills/llm-council/   # Cursor skill (orchestration)
COUNCIL.md                    # @-mention entry point
presets/                      # engineering, product, security, minimal
members/                      # create-your-own member templates
templates/                    # deliberation, ballot, ruling prompts
automations/                  # Cursor Automation workflow JSON
.llm-council/                 # your local roster (gitignored)
```

---

## Why

| You need | LLM Council gives you |
|----------|------------------------|
| A second opinion | Five, from different models |
| A decision record | Chair ruling + vote tally |
| Low friction | One line in chat, or a webhook POST |

---

## Contributing

PRs welcome — especially new presets and automation triggers. See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — [LICENSE](LICENSE)
