#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f checksums.txt ]]; then
  echo "checksums.txt not found"
  exit 1
fi

sha256sum -c checksums.txt
