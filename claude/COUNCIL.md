# LLM Council (Claude Code)

> **Start:** `/llm-council <question>` or paste:
>
> ```
> council: <your question>
> ```

## Presets

```
/llm-council Should we ship X?           # engineering
council @product: Launch freemium?
council @security: Admin API without VPN?
council @minimal: GraphQL or tRPC?        # fastest
```

Presets use **Claude models only** (`opus` / `sonnet` / `haiku`). See [claude/README.md](README.md) for Cursor vs Claude differences.

## Members

```
council roster: create member
```

Local config: `.llm-council/roster.yaml` — use `model: opus|sonnet|haiku` in member files.

## Install

```bash
./install.sh --claude
```

Full docs: [claude/README.md](README.md)
