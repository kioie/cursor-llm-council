---
name: cursor-llm-council
description: >-
  Convene a multi-provider LLM council in Cursor — Task subagents on Claude, GPT,
  Gemini, Composer, and more. Parallel deliberation, ballots, chair ruling.
  Use when the user says "llm council", "council session", "convene the council",
  "/council", or @mentions COUNCIL.md.
---

# Cursor LLM Council

Cursor-only. Multi-provider models via parallel **Task** subagents.

## Quick start

```
council: Should we ship X?
council @product: Launch freemium before GA?
council roster: create member
```

## Step 0 — Resolve roster

1. Webhook / automation payload (`members[]`, `preset`)
2. `.cursor-llm-council/roster.yaml` (project local, gitignored)
3. `presets/engineering.yaml` (default)

Presets: `engineering` | `product` | `security` | `minimal`

**Create member:** write `.cursor-llm-council/members/<id>.yaml`, update roster. Models = any slug the user's Cursor plan supports.

## Step 1 — Intake

Question (required), context (if ambiguous), mode: `quick` | `full` | `deep`.

## Step 2 — Phase 1: Deliberation

One **Task** per member in a **single message**:

- `subagent_type`: `generalPurpose`
- `model`: member's model (multi-provider)
- `readonly`: `true`
- Prompt: [templates/deliberation.md](../../../templates/deliberation.md)

## Step 3 — Phase 2: Ballots (skip in `quick`)

Parallel Tasks → [templates/ballot.md](../../../templates/ballot.md)

## Step 4 — Phase 3: Chair ruling

Chair Task → [templates/ruling.md](../../../templates/ruling.md)

## Automation mode

Parse webhook JSON per [automations/cursor-llm-council-webhook.workflow.json](../../../automations/cursor-llm-council-webhook.workflow.json).

## Don't

- No npm, no extra API keys, no repo edits unless asked.
- Claude Code users → [claude-llm-council](https://github.com/kioie/claude-llm-council) (separate repo).
