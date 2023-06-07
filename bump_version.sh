#!/usr/bin/env bash

# Auteur: Steve 

for i in *.po
do
  sed -i 's/3.6.3/3.6.5/g' $i
done

