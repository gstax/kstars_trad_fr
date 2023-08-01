#!/usr/bin/env bash

# Auteur: Johnny J.

export SCRIPTY_I18N_BRANCH=trunk_kf5
export DBLATEX_BASE_DIR=~/docs-kde-org

~/sources/l10n-scripty/update_xml fr kstars

pushd ~/sources/trad_kstars/fr/docs/kstars/kstars/
sed -i "s/% fr/% French/g" index.docbook
meinproc5 --check index.docbook
./buildpdf.sh index.docbook
popd


