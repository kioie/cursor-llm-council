# LLM Council

> **Start here.** `@COUNCIL.md` in Cursor chat, or:
>
> ```
> council: <your question>
> ```

## Presets

```
council: …                    # engineering (default)
council @product: …
council @security: …
council @minimal: …           # fastest
```

## Members

```
council roster                 # show current seats
council roster: create member  # add a custom seat
```

Local config: `.llm-council/roster.yaml` (see [members/README.md](members/README.md))

## Modes

```
council quick: …    # opinions only
council deep: …     # two deliberation rounds
```

## Automation

Webhook + PR triggers → [automations/README.md](automations/README.md)

## Claude Code

[claude/COUNCIL.md](claude/COUNCIL.md)
