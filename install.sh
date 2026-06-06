#!/usr/bin/env bash
# Install LLM Council — skill, local council config, optional automation opener
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
DEST="${HOME}/.cursor/skills/llm-council"
OPEN_AUTOMATION=false

for arg in "$@"; do
  case "$arg" in
    --automation) OPEN_AUTOMATION=true ;;
    -h|--help)
      echo "Usage: ./install.sh [--automation]"
      echo "  Installs skill to ~/.cursor/skills/llm-council"
      echo "  Seeds .llm-council/ from example if missing"
      echo "  --automation  hint to open Cursor Automations editor (manual step)"
      exit 0
      ;;
  esac
done

mkdir -p "$DEST"
cp "$ROOT/.cursor/skills/llm-council/SKILL.md" "$ROOT/.cursor/skills/llm-council/roster.yaml" "$DEST/"

if [[ ! -d "$ROOT/.llm-council" ]]; then
  cp -r "$ROOT/.llm-council.example" "$ROOT/.llm-council"
  cp "$ROOT/presets/engineering.yaml" "$ROOT/.llm-council/roster.yaml"
  echo "Created .llm-council/ with engineering preset"
fi

echo "✓ Skill installed → $DEST"
echo ""
echo "Try in Cursor:"
echo '  council: Should we migrate auth to passkeys?'
echo '  council @security: expose admin API without VPN?'
echo '  council roster: create member'
echo ""

if $OPEN_AUTOMATION; then
  echo "To add the webhook automation:"
  echo "  1. Open Cursor → Automations → New"
  echo "  2. Or ask your agent: 'Open LLM Council automation from automations/llm-council-webhook.workflow.json'"
  echo "  3. Save, then copy the webhook URL for POST requests"
  echo ""
  echo "See automations/README.md for the JSON body format."
fi
