# Council members (Cursor)

Each seat = **persona + Cursor model slug**.

## Create a member

```bash
mkdir -p .cursor-llm-council/members
cp members/member.example.yaml .cursor-llm-council/members/alex.yaml
```

Or: `council roster: create member`

## Fields

| Field | Required | Notes |
|-------|----------|-------|
| `id` | yes | Unique slug |
| `name` | yes | Display name |
| `title` | yes | Council role |
| `model` | yes | Any model your **Cursor** plan supports |
| `persona` | yes | How they argue |
| `chair` | no | One chair per roster |

## Presets

```bash
cp presets/engineering.yaml .cursor-llm-council/roster.yaml
```
