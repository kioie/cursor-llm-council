# Cursor LLM Council

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

**Multi-provider deliberation for Cursor** — parallel Task subagents on Claude, GPT, Gemini, Composer, and more. Vote. Rule. Ship.

Built for Cursor only. Using Claude Code? See **[claude-llm-council](https://github.com/kioie/claude-llm-council)**.

```
council: Should we ship feature X this sprint?
council @security: Expose the admin API without VPN?
```

No SDK. No API keys beyond Cursor. No `npm install`.

## Quick start

```bash
git clone https://github.com/kioie/cursor-llm-council.git
cd cursor-llm-council
./install.sh
```

In any project:

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
  model: claude-4.6-opus-high-thinking
  persona: >
    Systems thinker. Coupling, ops risk, scalability…
```

At runtime, Cursor spawns **one parallel Task subagent per seat** on that seat's model. Elena on Opus, Marcus on Codex, Priya on Gemini — a true **multi-provider** council.

### Who picks the model?

**You do** — from any model your Cursor plan supports. Presets ship suggested defaults; swap in YAML or inline. On failure, the skill retries once with `composer-2.5-fast`.

### Roster priority

| Priority | Source |
|----------|--------|
| 1 | Webhook / automation JSON (`members[]` or `preset`) |
| 2 | `.cursor-llm-council/roster.yaml` (local, gitignored) |
| 3 | `presets/engineering.yaml` (default) |

### Configure seats

**Presets:**

| Preset | Command | Seats |
|--------|---------|-------|
| Engineering (default) | `council: …` | Architect, Engineer, Strategist, Pragmatist, Chair |
| Product | `council @product: …` | PM, Design, Growth, Eng liaison, Chair |
| Security | `council @security: …` | AppSec, Infra, Privacy, Pragmatist, Chair |
| Minimal | `council @minimal: …` | Builder, Skeptic, User advocate, Chair |

**Inline model swap:**

```
council engineer=gpt-5.2 chair=claude-4.6-opus-high-thinking "GraphQL or tRPC?"
```

**Custom members:**

```bash
mkdir -p .cursor-llm-council/members
cp members/member.example.yaml .cursor-llm-council/members/alex.yaml
```

Or: `council roster: create member` — see [members/README.md](members/README.md).

### Chair

Exactly one `chair: true` seat synthesizes the final ruling (Phase 3).

### Runtime

```
Question → parallel deliberation → ballots → chair ruling
```

`council quick: …` skips ballots.

---

## Modes

| Mode | Command |
|------|---------|
| Quick | `council quick: …` |
| Full | `council: …` |
| Deep | `council deep: …` |

---

## Cursor Automations

Webhook or manual run — no chat required.

```bash
./install.sh --automation
```

Import [automations/cursor-llm-council-webhook.workflow.json](automations/cursor-llm-council-webhook.workflow.json).

```bash
curl -X POST "$WEBHOOK_URL" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"question": "Adopt event sourcing?", "preset": "engineering", "mode": "full"}'
```

**PR review:** comment `/council` — [automations/cursor-llm-council-pr.workflow.json](automations/cursor-llm-council-pr.workflow.json).

Details: [automations/README.md](automations/README.md)

---

## Project layout

```
.cursor/skills/cursor-llm-council/   # Cursor skill
COUNCIL.md                           # @-mention entry point
presets/                             # multi-provider model presets
members/                             # custom seat templates
templates/                           # deliberation, ballot, ruling
automations/                         # Cursor Automation JSON
.cursor-llm-council/                 # your local roster (gitignored)
```

---

## Contributing

PRs welcome — presets, automations, prompt tweaks. See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — [LICENSE](LICENSE)
