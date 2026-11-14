# KStars en français

Traduction du fichier de la GUI `kstars.po` en français.

But : une interface professionnelle, francisée et épurée.

## État actuel

Relecture complète effectuée par lots. Depuis, le fichier est maintenu au fil
des mises à jour de KStars : à chaque nouveau `msgmerge` contre le `.pot`
amont, les chaînes marquées « fuzzy » ou non traduites sont relues et
corrigées.

État visé en permanence : `msgfmt --statistics kstars.po` → 0 fuzzy, 0 non
traduit, `msgfmt --check` sans erreur.

## Documentation

La documentation (manuel utilisateur, fichiers Sphinx) vit dans un dépôt
séparé. Ce dépôt-ci ne concerne que `kstars.po` (l'application elle-même).

## Source

Le fichier `kstars.po` de ce dépôt suit la branche summit/trunk5 de KDE. Il
contient déjà les commentaires `#. +> trunk5` à conserver impérativement lors
de toute édition (ne jamais les supprimer par erreur).

Référence en ligne : https://fr.l10n.kde.org/apps/pofiles.php#kstars. Depuis
novembre 2026 (passage des traductions KDE de SVN à Git), le fichier de
référence est
[summit/messages/kstars/kstars.po](https://invent.kde.org/localization/l10n-fr/-/blob/master/summit/messages/kstars/kstars.po)
dans le dépôt `localization/l10n-fr`.
Le `Project-Id-Version` du fichier n'est pas toujours fiable pour dater une
version : croiser plutôt `POT-Creation-Date` avec `appdata.xml` et le
`git log` du dépôt source KStars.

## Circuit de soumission

Depuis novembre 2026, livraison par **merge request** sur
`localization/l10n-fr` (invent.kde.org), depuis un fork personnel. La MR est
fusionnée dès que la pipeline `po-lint` est verte.

1. Clone partiel du fork (`--filter=blob:none` + sparse-checkout sur
   `summit/messages/kstars` et `summit/messages/documentation-kstars-docs-kde-org`),
   remotes `origin` = fork, `upstream` = `localization/l10n-fr`.
2. Relecture dans le `kstars.po` de ce dépôt (format sans retour à la ligne),
   commit ici.
3. Nouvelle branche dans le clone depuis `upstream/master`, report des seules
   entrées modifiées sur le fichier summit : le summit est replié à 80
   colonnes, recopier notre fichier produirait ~18 000 lignes de diff de pure
   mise en forme. Le script de report ne réécrit que les entrées dont la
   traduction ou l'état fuzzy change.
4. `msgfmt --check`, commit (auteur réel), push de la branche sur le fork,
   MR vers `localization/l10n-fr:master` (cocher « Delete source branch » et
   « Allow commits from members »).

Le summit est déjà fusionné avec les nouveaux modèles par scripty : il sert de
base pour repérer les nouvelles chaînes (`git fetch upstream`), plus besoin de
`msgmerge` local. Ses fuzzy pré-remplis automatiquement ne respectent pas nos
conventions : toujours les relire.

Documentation : les `.po` de la doc vivent aussi dans `l10n-fr`, sous
`summit/messages/documentation-kstars-docs-kde-org/` (noms aplatis). Circuit à
valider à la prochaine livraison doc. L'ancien circuit (fork GitHub du dépôt
doc, `svn-delivery/`, mail) est caduc.

## Site ouebe

Le lien du [fichier po](https://websvn.kde.org/trunk/l10n-support/fr/summit/messages/websites-kstars-kde-org/kstars-kde-org.po?view=log).

Le site se trouve [ici](https://kstars.kde.org/fr/).

### KDE en français
Un [glossaire de KDE](https://fr.l10n.kde.org/dict/).

#### Doc kstars en français
Elle se trouve [ici](https://kstars-docs.kde.org/fr/index.html).

#### Doc kstars en anglais
Elle se trouve [ici](https://docs.kde.org/trunk5/en/kstars/kstars/index.html).

## Compilation du fichier

Le fichier source kstars.po est compilé en kstars.mo avec la commande:

<code>msgfmt -o kstars.mo kstars.po</code>

Il faut que le paquet "gettext" (apt install gettext) soit installé.

Pour l'utiliser avec la version Flatpak de KStars, copier le `.mo` vers
`~/.var/app/org.kde.kstars/data/locale/fr/LC_MESSAGES/kstars.mo` (pas dans le
checkout OSTree, qui est en lecture seule et écrasé à chaque mise à jour).

### Extraction chaînes non-traduite
<code>msgattrib --untranslated source.po -o output.po</code><br/>
Il existe une option pour les fuzzy également (--only-fuzzy).

## Vérification des po

Vérifications systématiques après chaque modification :

<code>msgfmt --check kstars.po -o /dev/null</code><br/>
<code>msgfmt --statistics kstars.po</code>

Outils complémentaires pour une passe ponctuelle plus poussée :

* **i18nspector** (paquet système, `apt install i18nspector`) : vérifie
  l'en-tête, l'encodage, les pluriels...
  <code>i18nspector -l fr fichier.po</code>
  [doc](https://i18nspector.readthedocs.io/en/stable/)

* **pology** (dépôt [KDE/pology](https://github.com/KDE/pology), pas de
  paquet système — cloner puis lancer depuis le clone) : règles
  linguistiques françaises (typographie, choix terminologiques de l'équipe,
  fautes courantes).
  <code>PYTHONPATH=&lt;chemin_du_clone_pology&gt; python3 &lt;chemin_du_clone_pology&gt;/bin/posieve check-rules -s lang:fr fichier.po</code>
  [doc](https://community.kde.org/KDE_Localization/fr/pology)

  Rendement bruité (pas mal de faux positifs sur les règles génériques) :
  à utiliser comme passe complémentaire ponctuelle en fin de relecture,
  pas comme vérification systématique à chaque commit.


## Bonnes pratiques

* règle pour anti- (voir https://fr.wiktionary.org/wiki/anti-#fr)
* Points cardinaux : attention aux règles (p. ex (https://www.btb.termiumplus.gc.ca/redac-chap?lang=fra&lettr=chapsect3&info0=3.3.2)
* Enlever tous les `:` finaux sur les libellés d'interface courts (choix
  délibéré : QLabel/QCheckBox/QPushButton/QRadioButton courts, pas les
  phrases complètes).
* Points de suspension : uniformisés vers `…` (unicode) en fin de `msgstr`,
  jamais `...` (ASCII) — sauf dans les `msgid` anglais sources.
* Pas de guillemets autour de Ekos et INDI 
* En français l'apostrophe est le caractère U+2019 « ’ », et non U+0027 « ' » (qui correspond à celle sur mon clavier, même touche que le ?). Dans vim, on peut les trouver en faisant ['], et on l'entre avec « Ctrl+K '9 ». Dans vim, on peut chercher et remplacer avec:
  <code>:%s/[']/’/gc</code> (en entrant directement Ctrl+k '9 dans la ligne ex). Mais, car il y a toujours un mais, l'équipe de traduction de KDE a choisi l'inverse, à savoir l'apostrophe simple (U+0027). Donc, c'est <code>:%s/’/'/gc</code> qu'il faut faire.
* Jargon astrophoto délibérément gardé en anglais : Light/Dark/Bias/Flat non
  traduits (seul Video → Vidéo l'est).

## Glossaire

* Capture -> Acquisition
* Meridian flip -> Retournement au méridien
* Focusor -> Moteur de mise au point
* Plate solver -> Résolveur / résolution astrométrique
* Autofocus -> Mise au point automatique
* location -> position (et non emplacement)
* Backlash -> Jeu (mécanique)
* Scheduler -> Ordonnanceur (jamais « planificateur », y compris dans la doc)
* Planner (Observation, Mosaic) -> Planificateur (d'observations, de mosaïque)
* Job (Scheduler, Capture) -> Tâche
* Camera -> Caméra (jamais « appareil » seul) ; DSLR -> APN
* Dust cap -> Capuchon antipoussière (sans tiret)
* Dithering / Dither -> Décalage
* Park / Unpark -> Parquer / Déparquer
* Polar Alignment -> Alignement polaire
* Slew -> Pointer (télescope/monture)
* Field rotation -> Rotation de champ
* Tilt (plate/correction) -> Inclinaison
* Autoguiding -> Guidage automatique
* Dark (frame) / Dark Library -> dark / Bibliothèque de darks
* Binning -> Regroupement
* Rolloff roof -> Toit roulant
* Stream tracking -> Suivi sur flux
* Dome shutter -> Obturateur de la coupole (doc) / du dôme (kstars.po)
* Focal ratio / F-Number -> Rapport F/D (partout, app et doc)
* Focal Reducer ratio -> Facteur du réducteur de focale
* Light box -> Boîte à flat ; Brightness (boîte à flat) -> Luminosité
* Target ADU -> ADU cible
* Field derotation -> Dérotation de champ
* Trail (étoiles) -> Traînée ; to trail -> filer

## Historique

* 2026-09-21 : terminologie caméra / APN harmonisée dans kstars.po et la doc.
* 2026-09-24 : harmonisation Job / Task → « tâche » (Scheduler, Capture, Task Queue).
* 2026-10-03 : fusion du POT du 2026-09-28 (6 nouvelles chaînes, 2 fuzzy :
  accès fichiers MCP, « Ouvrir une image récente », ordonnanceur). Doc
  `ekos-scheduler` : 12 nouvelles chaînes et 7 fuzzy (files de pré/post
  démarrage et arrêt), « Scheduler » harmonisé en « ordonnanceur » partout
  (18 entrées). Livré et signalé par mail.
* 2026-10-19 : fusion du POT du 2026-10-17 (3 nouvelles chaînes, 4 fuzzy :
  alignement polaire sans monture, échec D-Bus, raisons d'ordonnancement,
  info-bulle Subframe / SEP Multi Star). Bouton `&Queue` de gestion des
  tâches annulées renommé « Après la file ». Livré et signalé par mail.
* 2026-10-27 : fusion du POT du 2026-10-26 (32 nouvelles chaînes, 12 fuzzy :
  nouvelle fonction Stream Tracking traduite « suivi sur flux », omission de
  tâches dans la file, info-bulle Subframe). Doc : `fits-viewer-livestacker`,
  `ekos-scheduler-taskqueue` (obturateur de la coupole, tâches ignorées) et
  `ekos-tilt-correction` (réglages de détection d'étoiles) : 32 nouvelles
  chaînes, 18 fuzzy ; « Live Stacker… » aligné sur « Empilement en direct… ».
  Livré et signalé par mail.
* 2026-10-29 : fusion du POT du 2026-10-27 (2 nouvelles chaînes, 5 fuzzy :
  téléchargement des données caméra du calculateur d'exposition depuis
  indilib/camera-data). Contresens corrigés : « Read noise constant » →
  « Bruit de lecture constant », nombre de poses calculé, facteur du réducteur
  de focale. Doc `ekos-capture` : 50 nouvelles chaînes, 13 fuzzy (ouverture du
  calculateur, fichiers de données caméra, détail du calcul). « Rapport F/D »
  harmonisé partout (kstars.po, ekos-capture, ekos-focus, ai-telescopes,
  index). Les en-têtes du tableau d'intégration et « Mono »/« Color » ne sont
  pas passés par i18n() en amont et restent en anglais. Livré et signalé par
  mail.
* 2026-11-09 : fusion du POT du 2026-11-08 (289 nouvelles chaînes, 17 fuzzy :
  diagnostic d'échec de l'alignement, calibration des flats par la luminosité
  de la boîte à flat, dérotation de champ Alt-Az, arrêt de l'observatoire dans
  l'ordonnanceur). « Target ADU » harmonisé en « ADU cible ». Aucune chaîne à
  traduire côté doc.
* 2026-11-09 : fusion du POT du 2026-11-09 (15 nouvelles chaînes nettes : bilan
  de configuration de l'alignement). Livré et signalé par mail.
* 2026-11-14 : passage des traductions KDE de SVN à Git. Livraison désormais
  par MR sur `localization/l10n-fr` depuis un fork (voir « Circuit de
  soumission »). Première MR : fusion du POT du 2026-11-11 (4 chaînes de
  calibration des flats, fuzzy pré-remplis par l'outillage KDE réécrits :
  « images plates », « caissons lumineux » → flats, boîte à flat), diff de
  29 lignes sur le summit.
* 2026-11-14 : doc comparée au summit (`scripts/compare_doc_summit.py`) :
  117 fichiers sur 118 identiques. `ekos-capture` (POT du 2026-11-11) :
  7 fuzzy sur la calibration des flats par la boîte à flat, pré-remplis hors
  conventions par l'outillage KDE, retraduits (libellés contrôlés contre
  kstars.po ; « file d'attente de séquences » et « capuchon antipoussière »
  alignés sur l'appli). Ajouté à la MR !2 (premier passage de la doc par le
  nouveau circuit). Nouveau circuit signalé par mail au mainteneur (plus de
  mail à chaque livraison).
* 2026-11-14 : lecture de la MR l10n-fr !1 (scripts summit portés sur Git, non
  fusionnée). Un cron du coordinateur fait merge/scatter du summit vers
  trunk5/6 et stable5/6, génère les docbooks et ouvre ses propres MR en fusion
  automatique. Pour nous : rebaser sur `upstream/master` juste avant le push,
  `msgfmt --check` sur le summit (un .po en échec n'est pas répercuté), valider
  le docbook nous-mêmes. `appliquer_sur_summit.py` inchangé.
