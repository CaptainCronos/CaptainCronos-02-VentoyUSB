#!/usr/bin/env bash
set -euo pipefail

find ISO Tools -type f -print0 | sort -z | xargs -0 sha256sum > checksums.txt

echo "Created checksums.txt"
