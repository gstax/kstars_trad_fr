# !/bin/sh

# Chaîne de compilation complète de la doc html

l10n="$HOME/sources/l10n-scripty"
docbook="$HOME/sources/trad_kstars/fr/docs/kstars/kstars"


# création des docbook
cd $l10n
./update_xml ../trad_kstars/fr kstars
echo "1/3 : UPDATE xml DONE"

# remplacement de fr par French
cd $docbook
sed -i 's/<!ENTITY % fr "INCLUDE"/<!ENTITY % French "INCLUDE"/' index.docbook

echo "2/3 : sed DONE"

# création des fichiers html

meinproc5 --check index.docbook

echo "3/3 : Création des fichiers html DONE"

echo "Fin du script"
