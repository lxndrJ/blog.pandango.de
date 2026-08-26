#!/usr/bin/env bash
set -euo pipefail

DATE=$(date +%Y%m%d)
shopt -s nullglob
files=("./_posts/${DATE}_"*.md)
shopt -u nullglob

if [ ${#files[@]} -eq 0 ]; then
  echo "Kein Post für $DATE gefunden"
  exit 1
fi

for f in "${files[@]}"; do
  git add -- "$f"
done

git commit -m "Automatischer Blogpost vom $(date +%Y-%m-%d)"
git pull --rebase --autostash origin HEAD
git push --set-upstream origin HEAD
echo "✅ Post gepusht"
