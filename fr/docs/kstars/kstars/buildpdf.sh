#!/bin/sh -x

export SGML_CATALOG_FILES=/usr/share/sgml/docbook/dtd/xml/4.5/catalog:/usr/share/kf5/kdoctools/customization/catalog.xml:/usr/share/sgml/docbook/dtd/xml/4.5/docbook.dtd
# add -d to command below to keep the /tmp folder, so you can examine the generated tex. …


DBLATEX=$HOME/sources/docs-kde-org/dblatex-cvs-install/bin
KDESTYLE=/usr/share/texmf/tex/latex/kde/kdestyle.sty


$DBLATEX/dblatex -d -b pdftex --style kdestyle \
	-o $(pwd | awk -F/ '{ print $NF }').pdf \
    -P latex.encoding=utf8 \
	-P latex.output.revhistory=0  -P newtbl.use=1 \
	-P imagedata.default.scale=pagebound \
	-P literal.width.ignore=1 \
	-I $KDEDIR/share/doc/HTML/fr/ \
	-X \
        $1

