# KStars en français

Traduction du fichier de la GUI kstars.po en français. (Et, de fil en aiguille, de la documentation...)

But: une interface professionnelle, francisée et épurée.


## Source

Il se trouve ici : https://fr.l10n.kde.org/apps/pofiles.php#kstars

mais plutôt ici https://l10n.kde.org/stats/gui/trunk-kf5/team/fr/kstars/


ou ci-dessous, mais ne contient pas les tags trunk, donc il faut les ajouter avec le fichier python <name>.

http://websvn.kde.org/*checkout*/trunk/l10n-kf5/fr/messages/kstars/kstars.po

Si on tombe sur un timeout (souvent), utiliser

https://websvn.kde.org/*checkout*/trunk/l10n-support/fr/summit/messages/kstars/kstars.po

### Fichiers po de la documentation
https://websvn.kde.org/trunk/l10n-support/fr/summit/docmessages/kstars/?sortby=date#dirlist

### KDE en français
Un [glossaire de KDE](https://fr.l10n.kde.org/dict/).

#### Doc kstars en anglais
Elle se trouve [ici](https://docs.kde.org/trunk5/en/kstars/kstars/index.html).

## Compilation du fichier

Le fichier source kstars.po est compilé en kstars.mo avec la commande:

<code>msgfmt -o kstars.mo kstars.po</code>

Il faut que le paquet "gettext" (apt install gettext) soit installé.

Reformater le fichier po :

<code>msgcat kstars.po > kstars_cat.po</code>

## Traduction de la documentation

### Différence entre deux versions
<code>diff -u <(msgfmt -o - kstars.po| msgunfmt ) <(msgfmt -o - kstars_3.5.9.po| msgunfmt)</code>

### Extraction chaînes non-traduite
<code>msgattrib --untranslated source.po -o output.po</code><br/>
Il existe une option pour les fuzzy également (--only-fuzzy).

## Vérification des po
Plusieurs outils existent pour vérifier les fichiers.

<code>pology check_rules fichier.po</code><br/>

[Doc pology](https://community.kde.org/KDE_Localization/fr/pology)

<code>i18nspector -l fr fichier.po</code> [doc](https://i18nspector.readthedocs.io/en/stable/)

Comme ce sont des fichiers pris dans la branche trunk, il faut rajouter ce drapeau aux fichiers po. Un script python le fait :

<code>python3 add_trunk.py fichier.po</code>

### Création des docbook

<code>cd /home/steve/sources/l10n-scripty></code> <br/>
<code>./update_xml ../trad_kstars/fr kstars</code><br/>

Si tout se passe bien les *.docbook seront créés dans le répertoire suivant.
Sinon, il faut corriger les erreurs dans les *.po. sans quoi le fichier
index.docbook ne sera pas créé.

Il faut aussi remplacer (dans index.docbook)

<code><! ENTITY % fr "INCLUDE"</code>

par 


<code><! ENTITY % French "INCLUDE"</code>

pour tenir compte du nouveau fichier entities.user.

Les fichiers css ne sont pas trouvés, j'ai donc créé un petit script bash pour corriger les chemins :

<code>./corriger_css.sh</code>

Rem : ça s'est si l'on veut visualier avec un navigateur quelconque. On peut éviter cette étape en utilisant Konqueror.

### Génération des fichers html

<code> cd /home/steve/sources/trad_kstars/fr/docs/kstars/kstars</code><br/>
<code>meinproc5 --check index.docbook</code><br/>

Là aussi, il faut corriger les erreurs en partant du haut mes messages d'erreurs.

### Génération du pdf

Il faut exécuter le script <code>buildpdf.sh</code> dans ce même répertoire.

<code>./buildpdf.sh index.docbook</code><br/>

Cela créera le fichier kstars.pdf.

#### Remarques

* \usepackage[latin1]{inputenc} plutôt que \usepackage[utf8]{inputenc}, ce qui
  pose problème pour certains symboles comme les points de suspension …
  (&hellip;) qui ne sont pas affichés dans le pdf.
* \def\DBKlocale{en}. Le nom des tables, sections etc… sont en anglais. 
* pas de Babel ?


## Bonnes pratiques

* règle pour anti- (voir https://fr.wiktionary.org/wiki/anti-#fr)

* Points cardinaux : attention aux règles (p. ex (https://www.btb.termiumplus.gc.ca/redac-chap?lang=fra&lettr=chapsect3&info0=3.3.2)
* Enlever tous les :
* Pas de guillemets autour de Ekos et INDI 
* En français l'apostrophe est le caractère U+2019 « ’ », et non U+0027 « ' » (qui correspond à celle sur mon clavier, même touche que le ?). Dans vim, on peut les trouver en faisant [\u0027], et on l'entre avec « Ctrl+K '9 ». Dans vim, on peut chercher et remplacer avec:
  <code>:%s/[\u0027]/’/gc</code> (en entrant directement Ctrl+k '9 dans la ligne ex). Mais, car il y a toujours un mais, l'équipe de traduction de KDE a choisi l'inverse, à savoir l'apostrophe simple (U+0027). Donc, c'est <code>:%s/’/'/gc</code> qu'il faut faire.

## Glossaire

* Capture -> Acquisition
* Meridian flip -> Retournement au méridien
* Focusor -> Moteur de mise au point
* Plate solver -> Résolveur
* Autofocus -> Mise au point automatique
* location -> position (en non emplacemnt)
