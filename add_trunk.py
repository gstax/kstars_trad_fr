#!/usr/bin/python3

import sys
import polib

if len(sys.argv) < 2:
    print('Usage : python3 add_trunk.py fichier.po.')
    sys.exit(1)

# load an existing po file
po = polib.pofile(sys.argv[1])

#print(po.percent_translated())

# Then replace in the output all the good strings
for entry in po:
    if not "trunk5" in entry.comment:
        entry.comment = entry.comment + "\n+> trunk5"
        print(entry.comment)

po.save(sys.argv[1])
