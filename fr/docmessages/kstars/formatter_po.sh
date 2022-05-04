#/bin/sh

# formate les fichiers po

for i in *.po
do
  msgcat $i > out
  mv out $i
  echo "Mise en forme de $i fait..."
done
