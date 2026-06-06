# Council members

A **member** is one seat on the council: name, title, model, and persona.

## Create a member

Copy `member.example.yaml` to your local council folder:

```bash
mkdir -p .llm-council/members
cp members/member.example.yaml .llm-council/members/alex.yaml
```

Edit the file, then add the member id to `.llm-council/roster.yaml`:

```yaml
members:
  - ref: alex          # loads .llm-council/members/alex.yaml
  - ref: architect     # or inline — see presets/
```

Or define inline in `roster.yaml`:

```yaml
members:
  - id: alex
    name: Alex
    title: Platform Lead
    model: gpt-5.3-codex
    persona: Owns the platform roadmap and SLOs.
```

## Fields

| Field | Required | Notes |
|-------|----------|-------|
| `id` | yes | Slug, unique in roster |
| `name` | yes | Display name |
| `title` | yes | Role on the council |
| `model` | yes | **Cursor:** any model slug your plan supports. **Claude Code:** `opus`, `sonnet`, or `haiku` |
| `persona` | yes | How this member thinks and argues |
| `chair` | no | Exactly one member should have `chair: true` |

## Pick a preset

Use a built-in roster from `presets/`:

```bash
cp presets/engineering.yaml .llm-council/roster.yaml
```

Available: `engineering`, `product`, `security`, `minimal`.
