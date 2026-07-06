#!/usr/bin/env bash
set -euo pipefail

VENTOY_MOUNT="${1:-}"

if [[ -z "$VENTOY_MOUNT" ]]; then
  echo "Usage: ./scripts/update-ventoy.sh /path/to/Ventoy"
  exit 1
fi

if [[ ! -d "$VENTOY_MOUNT" ]]; then
  echo "Ventoy mount path not found: $VENTOY_MOUNT"
  exit 1
fi

rsync -av --exclude='.git' --exclude='*.iso' --exclude='*.exe' --exclude='*.msi' ./ "$VENTOY_MOUNT"/

echo "Ventoy structure/config copied to $VENTOY_MOUNT"
