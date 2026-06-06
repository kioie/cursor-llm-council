# Cursor LLM Council

> `@COUNCIL.md` in Cursor chat, or:
>
> ```
> council: <your question>
> ```

Multi-provider models (Claude + GPT + Gemini + …). Claude Code → [claude-llm-council](https://github.com/kioie/claude-llm-council).

## Examples

```
council: Should we migrate auth to passkeys before GA?
council @security: expose admin API without VPN?
council quick: GraphQL or tRPC?
council engineer=gpt-5.2 "ship dark mode?"
```

## Presets

`engineering` (default) · `product` · `security` · `minimal`

Roster: `.cursor-llm-council/roster.yaml` — see [members/README.md](members/README.md)

## Automations

[automations/README.md](automations/README.md)
