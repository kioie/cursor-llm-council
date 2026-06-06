# LLM Council for Claude Code

First-class support for Claude Code — with one important difference from Cursor.

## Cursor vs Claude Code

| | **Cursor** | **Claude Code** |
|---|------------|-----------------|
| **Models per seat** | Any model your plan supports (Claude, GPT, Gemini, Composer, Kimi, …) | **Claude only** — `opus`, `sonnet`, `haiku` |
| **Parallelism** | Task subagents | Agent subagents (parallel in one turn) |
| **Entry point** | `council: …` or `@COUNCIL.md` | `/llm-council` or `council: …` |
| **Skill path** | `.cursor/skills/llm-council/` | `.claude/skills/llm-council/` |
| **Presets** | `presets/` (multi-provider models) | `claude/presets/` (opus/sonnet/haiku) |
| **Automations** | Webhook + PR comment | Not available (use skill in terminal) |
| **Custom members** | `.llm-council/members/*.yaml` | Same — use Claude model aliases |

### What still works the same

- Seat = **persona + model** bundled together
- Presets: engineering, product, security, minimal
- Create your own members: `council roster: create member`
- Phases: deliberate → ballot → ruling (`quick` skips ballots)
- Shared templates in `templates/`

### What you give up on Claude Code

**True multi-provider council** — you can't seat GPT on engineering and Gemini on product in one session. You *can* still get diverse deliberation by pairing **different personas** with **different Claude tiers** (opus for architect, haiku for pragmatist).

## Install

```bash
git clone https://github.com/kioie/llm-council.git
cd llm-council
./install.sh --claude
```

Or use project-local files (already in repo): `.claude/skills/llm-council/`

## Quick start

```bash
cd your-project
claude
```

```
/llm-council Should we adopt SQLite for local-first sync?

council @security: expose admin API without VPN?
council quick: GraphQL or tRPC?
```

## Claude preset model mapping (engineering)

| Seat | Model | Why |
|------|-------|-----|
| Architect | `opus` | Deep systems reasoning |
| Engineer | `sonnet` | Balanced implementation analysis |
| Strategist | `sonnet` | Product trade-offs |
| Pragmatist | `haiku` | Fast, ship-focused |
| Chair | `opus` | Binding ruling synthesis |

Edit `claude/presets/*.yaml` to tune tiers for your plan.

## Custom members (Claude)

```yaml
# .llm-council/members/alex.yaml
id: alex
name: Alex
title: Design Lead
model: sonnet    # opus | sonnet | haiku
persona: UX and accessibility first.
```

## Manual fallback (no subagents)

If subagent delegation is disabled, run `templates/deliberation.md` once per persona in sequence (less independent), then ballots, then chair. Quality drops — enable Agent tool for best results.
