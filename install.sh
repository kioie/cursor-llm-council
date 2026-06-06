#!/usr/bin/env bash
# Install LLM Council — Cursor skill, Claude Code skill, local council config
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
INSTALL_CURSOR=true
INSTALL_CLAUDE=false
OPEN_AUTOMATION=false

for arg in "$@"; do
  case "$arg" in
    --cursor)   INSTALL_CURSOR=true; INSTALL_CLAUDE=false ;;
    --claude)   INSTALL_CLAUDE=true; INSTALL_CURSOR=false ;;
    --all)      INSTALL_CURSOR=true; INSTALL_CLAUDE=true ;;
    --automation) OPEN_AUTOMATION=true ;;
    -h|--help)
      echo "Usage: ./install.sh [--cursor] [--claude] [--all] [--automation]"
      echo ""
      echo "  --cursor     Install Cursor skill (default)"
      echo "  --claude     Install Claude Code skill"
      echo "  --all        Install both"
      echo "  --automation Cursor: hint for webhook automation setup"
      echo ""
      echo "Seeds .llm-council/ from example if missing."
      exit 0
      ;;
  esac
done

seed_local_config() {
  if [[ ! -d "$ROOT/.llm-council" ]]; then
    cp -r "$ROOT/.llm-council.example" "$ROOT/.llm-council"
    cp "$ROOT/presets/engineering.yaml" "$ROOT/.llm-council/roster.yaml"
    echo "Created .llm-council/ with engineering preset"
  fi
}

if $INSTALL_CURSOR; then
  DEST="${HOME}/.cursor/skills/llm-council"
  mkdir -p "$DEST"
  cp "$ROOT/.cursor/skills/llm-council/SKILL.md" "$ROOT/.cursor/skills/llm-council/roster.yaml" "$DEST/"
  echo "✓ Cursor skill → $DEST"
  echo '  Try: council: Should we migrate auth to passkeys?'
fi

if $INSTALL_CLAUDE; then
  DEST="${HOME}/.claude/skills/llm-council"
  mkdir -p "$DEST"
  cp "$ROOT/.claude/skills/llm-council/SKILL.md" "$DEST/"
  echo "✓ Claude Code skill → $DEST"
  echo '  Try: /llm-council Should we ship feature X?'
fi

seed_local_config

if $OPEN_AUTOMATION; then
  echo ""
  echo "Cursor automation:"
  echo "  1. Cursor → Automations → New"
  echo "  2. Or: 'Open LLM Council automation from automations/llm-council-webhook.workflow.json'"
  echo "  See automations/README.md"
fi

if $INSTALL_CLAUDE && ! $INSTALL_CURSOR; then
  echo ""
  echo "Note: Claude Code uses opus/sonnet/haiku only. See claude/README.md for Cursor vs Claude."
fi
