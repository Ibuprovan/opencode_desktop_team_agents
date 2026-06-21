#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="${HOME}/.config/opencode"
echo "Deploying global opencode config to: ${CONFIG_DIR}"

# 1. Global config
mkdir -p "${CONFIG_DIR}"
cp global/opencode.jsonc "${CONFIG_DIR}/opencode.jsonc"
echo "  ✅ global/opencode.jsonc → ${CONFIG_DIR}/opencode.jsonc"

# 2. Agent prompts
mkdir -p "${CONFIG_DIR}/agents"
for f in global/agents/*.md; do
  cp "$f" "${CONFIG_DIR}/agents/$(basename "$f")"
  echo "  ✅ $f → ${CONFIG_DIR}/agents/$(basename "$f")"
done

# 3. Audit plugin
mkdir -p "${CONFIG_DIR}/plugins"
cp global/plugins/pmo-audit.mjs "${CONFIG_DIR}/plugins/pmo-audit.mjs"
echo "  ✅ global/plugins/pmo-audit.mjs → ${CONFIG_DIR}/plugins/pmo-audit.mjs"

echo ""
echo "Done. Restart opencode for changes to take effect."
