# KStars en français

Traduction du fichier de la GUI kstars.po en français. (Et, de fil en aiguille, de la documentation...)

But: une interface professionnelle, francisée et épurée.


## Source

Il se trouve ici : https://fr.l10n.kde.org/apps/pofiles.php#kstars

Le lien direct est [https://websvn.kde.org/trunk/l10n-support/fr/summit/messages/kstars/kstars.po?view=co](https://websvn.kde.org/trunk/l10n-support/fr/summit/messages/kstars/kstars.po?view=co)

Ce fichier contient les balises trunk5 à garder.

## Site ouebe

Le lien du [fichier po](https://websvn.kde.org/trunk/l10n-support/fr/summit/messages/websites-kstars-kde-org/kstars-kde-org.po?view=log).

### Fichiers po de la documentation

!!! Les fichiers se trouvent maintenant dans le dépôt kstars-documentation !!!


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


#### Remarques

* \usepackage[latin1]{inputenc} plutôt que \usepackage[utf8]{inputenc}, ce qui
  pose problème pour certains symboles comme les points de suspension …
  (&hellip;) qui ne sont pas affichés dans le pdf.
* \def\DBKlocale{en}. Le nom des tables, sections etc… sont en anglais. 
* pas de Babel ?

## Traduction du site ouebe

Il se trouve [ici](https://kstars.kde.org/fr/).

Et le po est [ici](https://websvn.kde.org/trunk/l10n-support/fr/summit/messages/websites-kstars-kde-org/).



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
