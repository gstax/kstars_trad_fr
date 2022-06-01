# KStars en français

Traduction du fichier de la GUI kstars.po en français. (Et, de fil en aiguille, de la documentation...)

But: une interface professionnelle, francisée et épurée.


## Source

Le fichier source se trouve à l'adresse http://websvn.kde.org/*checkout*/trunk/l10n-kf5/fr/messages/kstars/kstars.po


## Compilation du fichier

Le fichier source kstars.po est compilé en kstars.mo avec la commande:

<code>msgfmt -o kstars.mo kstars.po</code>

Il faut que le paquet "gettext" (apt install gettext) soit installé.

Reformater le fichier po :

<code>msgcat kstars.po > kstars_cat.po</code>

## Traduction de la documentation

## Vérification des po
Plusieurs outils existent pour vérifier les fichiers.

<code>pology check_rules fichier.po</code><br/>
<code>i18nspector -l fr fichier.po</code>

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


* Enlever tous les :
* Pas de guillemets autour de Ekos et INDI 

## Glossaire

* Capture -> Acquisition
* Meridian flip -> Retournement au méridien
* Focusor -> Moteur de mise au point
* Plate solver -> Résolveur
* Autofocus -> Mise au point automatique
* location -> position (en non emplacemnt)
