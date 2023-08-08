#!/usr/bin/env bash

# Auteur: Steve 

for i in *.po
do
  sed -i 's/3.6.5/3.6.6/g' $i
done

