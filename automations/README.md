# Cursor Automations

Cursor-only. Import into **Cursor → Automations**.

## Webhook council

**File:** `cursor-llm-council-webhook.workflow.json`

```json
{
  "question": "Adopt event sourcing for billing?",
  "preset": "engineering",
  "mode": "full"
}
```

Custom `members[]` overrides preset. Local roster: `.cursor-llm-council/roster.yaml`.

## PR comment council

**File:** `cursor-llm-council-pr.workflow.json`

Comment `/council` on a PR → engineering council ruling as PR comment.

## Install hint

```
Open Cursor LLM Council automation from automations/cursor-llm-council-webhook.workflow.json
```
