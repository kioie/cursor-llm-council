# LLM Council (Claude Code)

Same council workflow — pick a preset, create members, deliberate, vote, rule.

## Start

```
Convene an LLM Council on: <YOUR QUESTION>

Preset: engineering (or product | security | minimal)
Read presets/<preset>.yaml from the llm-council repo for member personas.
Run each member as a separate analysis, then ballots, then Chair ruling.
Use templates/ruling.md for output format.
```

## Custom members

Create `members/your-name.yaml` (see `members/member.example.yaml`) or pass inline:

```
Members:
- Alex (Design Lead, opus): UX and a11y first
- Sam (Chair, sonnet): binding rulings
Question: Ship dark mode in v2?
```

## Cursor users

Use `@COUNCIL.md` or the **llm-council** skill — parallel subagents are faster. Webhook automation: [automations/README.md](../automations/README.md).
