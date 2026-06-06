# Cursor Automations

Import these into Cursor Automations to run LLM Council without typing in chat.

## 1. Webhook council (recommended)

**File:** `llm-council-webhook.workflow.json`

**Trigger:** HTTP webhook (URL + auth shown after you save in the Automations editor)

**Run manually:** Open Automations → LLM Council → Run

**POST body:**

```json
{
  "question": "Should we adopt SQLite for local-first sync?",
  "context": "Mobile app, 50k DAU, offline-first roadmap",
  "mode": "full",
  "preset": "engineering"
}
```

**Custom members** (overrides preset):

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

### Install via agent

In Cursor chat (Agents window):

```
Open the LLM Council automation from automations/llm-council-webhook.workflow.json
```

Or run `./install.sh --automation` after cloning.

## 2. PR comment council

**File:** `llm-council-pr.workflow.json`

**Trigger:** Comment on a pull request containing `/council`

**Action:** Posts council ruling as a PR comment

**To finish in editor:** Select which GitHub repos this automation watches.

## Presets

| `preset` value | Council |
|----------------|---------|
| `engineering` | Default build/ship balance |
| `product` | PM, design, growth |
| `security` | AppSec, infra, privacy |
| `minimal` | 4 seats, fastest |
