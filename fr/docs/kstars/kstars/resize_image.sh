#/bin/sh

# On retaille les images pour les fichiers html
# La taille idéale est de 1368 x 768 (r=1.77). A voir
# une capture d'écran totale sur le portable donne 1630x1050 (r=1.55)

convert $1 -resize 1368x768 $2
