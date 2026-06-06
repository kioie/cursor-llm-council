#!/usr/bin/env bash
# Install Cursor LLM Council skill + seed local config
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
DEST="${HOME}/.cursor/skills/cursor-llm-council"
OPEN_AUTOMATION=false

for arg in "$@"; do
  case "$arg" in
    --automation) OPEN_AUTOMATION=true ;;
    -h|--help)
      echo "Usage: ./install.sh [--automation]"
      echo "  Installs Cursor skill to ~/.cursor/skills/cursor-llm-council"
      echo "  Seeds .cursor-llm-council/ if missing"
      exit 0
      ;;
  esac
done

mkdir -p "$DEST"
cp "$ROOT/.cursor/skills/cursor-llm-council/SKILL.md" \
   "$ROOT/.cursor/skills/cursor-llm-council/roster.yaml" "$DEST/"

if [[ ! -d "$ROOT/.cursor-llm-council" ]]; then
  mkdir -p "$ROOT/.cursor-llm-council"
  cp "$ROOT/.cursor-llm-council.example/roster.yaml" "$ROOT/.cursor-llm-council/"
  cp "$ROOT/presets/engineering.yaml" "$ROOT/.cursor-llm-council/roster.yaml"
  echo "Created .cursor-llm-council/ with engineering preset"
fi

echo "✓ Cursor LLM Council → $DEST"
echo ""
echo '  council: Should we migrate auth to passkeys?'
echo '  council @security: expose admin API without VPN?'
echo '  council roster: create member'
echo ""

if $OPEN_AUTOMATION; then
  echo "Automations: automations/README.md"
  echo "  cursor-llm-council-webhook.workflow.json"
fi
