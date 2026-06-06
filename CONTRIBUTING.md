# Contributing

Thanks for helping improve LLM Council.

## Ways to contribute

- **New presets** — add a YAML file under `presets/` with 3–7 members and one chair.
- **Prompt tweaks** — edit `templates/*.md`; keep outputs structured and concise.
- **Automation triggers** — add workflow JSON under `automations/` with README notes.
- **Docs** — clarify install steps, model selection, or Claude Code parity.

## Preset guidelines

Each preset member needs: `id`, `name`, `title`, `model`, `persona`. Exactly one `chair: true`.

Use model slugs common on Cursor plans. Document alternatives in the preset comment if a model is niche.

## Pull requests

1. Fork and branch from `main`.
2. Keep changes focused — one preset or one feature per PR.
3. Test in Cursor: `council @yourpreset: test question?`

## Code of conduct

Be direct, be kind, optimize for low-friction developer tools.
