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

Référence en ligne : https://fr.l10n.kde.org/apps/pofiles.php#kstars, lien
direct
[websvn](https://websvn.kde.org/trunk/l10n-support/fr/summit/messages/kstars/kstars.po?view=co).
Le `Project-Id-Version` du fichier n'est pas toujours fiable pour dater une
version : croiser plutôt `POT-Creation-Date` avec `appdata.xml` et le
`git log` du dépôt source KStars.

## Circuit de soumission

Pas d'accès en écriture au SVN KDE, et pas de MR GitLab possible pour ce
dépôt. Le circuit de livraison est :

1. `git push` sur le fork GitHub personnel
2. Signalement par mail au mainteneur côté KDE que le fichier à jour est disponible
   sur le fork. 

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
* Scheduler -> Ordonnanceur
* Dithering / Dither -> Décalage
* Park / Unpark -> Parquer / Déparquer
* Polar Alignment -> Alignement polaire
* Slew -> Pointer (télescope/monture)
* Field rotation -> Rotation de champ
* Tilt (plate/correction) -> Inclinaison
* Autoguiding -> Guidage automatique
