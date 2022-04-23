#!/bin/sh

export SGML_CATALOG_FILES=/usr/share/sgml/docbook/sqml-dtd-4.5/catalog:/usr/share/kf5/kdoctools/customization/catalog.xml:/usr/share/sgml/docbook/xml-dtd-4.5/docbook
# add -d to command below to keep the /tmp folder, so you can examine the generated tex.

DBLATEX=$HOME/sources/docs-kde-org/dblatex-cvs-install/bin

$DBLATEX/dblatex -d -b pdftex --style kdestyle \
	-o $(pwd | awk -F/ '{ print $NF }').pdf \
	-P latex.output.revhistory=0  -P newtbl.use=1 \
	-P imagedata.default.scale=pagebound \
	-P literal.width.ignore=1 \
	-I $KDEDIR/share/doc/HTML/fr/ \
	-X \
        $1

