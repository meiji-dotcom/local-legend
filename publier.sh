#!/bin/bash
# Met en ligne la derniere version du jeu sur GitHub Pages.
# A lancer APRES avoir exporte le jeu depuis Godot (le dossier du projet contient alors index.html, index.wasm, etc.).
# Usage : bash publier.sh
set -e
cd "$(dirname "$0")"
SRC=/Users/jules/Audit/local-legend
rsync -a --delete --exclude '.git' --exclude 'publier.sh' --exclude '.nojekyll' --exclude 'LISEZMOI.txt' \
  --include 'index.html' --include 'index.js' --include 'index.wasm' --include 'index.pck' --include 'index.png' \
  --include 'index.icon.png' --include 'index.apple-touch-icon.png' --include 'index.audio*.js' --include 'city_*.pck' --include 'musique/' --include 'musique/*.mp3' \
  --exclude '*' "$SRC/" ./
touch .nojekyll
git add -A
# on remplace le dernier envoi au lieu d'en empiler un nouveau : le depot reste leger (le fichier .wasm pese 38 Mo)
if git rev-parse HEAD >/dev/null 2>&1; then
  git commit --amend -m "Local Legend" --allow-empty
  git push --force origin HEAD:main
else
  git commit -m "Local Legend"
  git push -u origin HEAD:main
fi
echo "Envoye. Le site se met a jour en 1 a 2 minutes."
