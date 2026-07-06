#!/usr/bin/env bash
set -euo pipefail

# Compile kstars.po et installe le .mo dans le Flatpak KStars (org.kde.kstars)
# pour tester la traduction sans attendre une publication officielle.

cd "$(dirname "$0")"

SRC_PO="kstars.po"
DEST_DIR="$HOME/.var/app/org.kde.kstars/data/locale/fr/LC_MESSAGES"
DEST_MO="$DEST_DIR/kstars.mo"

echo "Validation de $SRC_PO..."
msgfmt --check "$SRC_PO" -o /dev/null

echo "Compilation..."
msgfmt "$SRC_PO" -o kstars.mo --statistics

mkdir -p "$DEST_DIR"
cp kstars.mo "$DEST_MO"
echo "Installé : $DEST_MO"

if flatpak ps 2>/dev/null | grep -q org.kde.kstars; then
    echo "KStars est en cours d'exécution, arrêt..."
    flatpak kill org.kde.kstars
fi

echo "Terminé. Relancez KStars pour voir la nouvelle traduction."
