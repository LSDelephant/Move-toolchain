#!/usr/bin/env bash
set -e
# запускає тести через move CLI
if ! command -v move >/dev/null 2>&1; then
echo "move CLI не знайдено. Будь ласка, встановіть Move toolchain: https://github.com/move-language/move"
exit 1
fi
move test
