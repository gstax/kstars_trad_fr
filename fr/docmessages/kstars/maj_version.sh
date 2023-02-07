#!/usr/bin/env bash

# met à jour la version des fichiers
# on met un _ pour ne prendre que l'occurrence du fichier
for i in *.po
do
  sed -i 's/_3.6.1/_3.6.3/g' $i
done


