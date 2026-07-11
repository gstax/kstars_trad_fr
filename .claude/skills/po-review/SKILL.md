---
name: po-review
description: Ce skill doit être utilisé quand l'utilisateur demande de continuer, démarrer ou reprendre la relecture de kstars.po (ou d'un autre fichier .po de ce dépôt), dit "lot suivant", "passe au lot", "reprends la relecture", ou fait référence au projet de relecture par lots de kstars.po. Fournit le workflow validé de relecture et correction lot par lot des fichiers de traduction française .po de KDE.
version: 1.5.0
---

# Relecture de fichiers .po (kstars.po)

Workflow validé pour relire et corriger la traduction française de `kstars.po` (ou tout autre fichier `.po` de ce dépôt), lot par lot, sans jamais pousser vers le dépôt distant.

## Contexte du projet

- Le fichier `kstars.po` fait ~14 900 entrées. Il est découpé en **22 lots par module source**, listés avec leur avancement dans la mémoire projet `project_kstars_po_review.md` (type `project`). Toujours consulter cette mémoire en premier pour savoir où en est la relecture et quel est le prochain lot.
- `kstars_i18n.cpp` (noms de constellations, villes, étoiles, catalogues) est **exclu** du premier passage — ce sont des noms propres générés automatiquement.
- Communication **exclusivement en français** avec l'utilisateur (voir mémoire `feedback_language_french_only`).

## Étapes par lot

1. **Retrouver les bornes du lot** : `grep -n "^#: <module>"` sur le début et la fin du module cible, en repérant où commence le module suivant dans l'ordre du fichier (les modules sont contigus, jamais entrelacés).
2. **Lire le lot en entier**, en le découpant en tranches d'environ 700-800 lignes si nécessaire (limite de ~25000 tokens par lecture).
3. **Demander à l'utilisateur quelles catégories vérifier** pour ce lot (sauf s'il l'a déjà précisé pour cette session) : lister les catégories lettrées ci-dessous et proposer de répondre par lettres (ex. "a, d, m") ou "toutes".

   Catégories :
   - **a. Contresens / mistranslations** (sens inversé, faux-amis, confusion entre deux termes proches — ex. Stat/Star, Form/Format)
   - **b. Incohérences terminologiques** entre entrées sœurs proches (même concept traduit différemment à deux endroits)
   - **c. Grammaire** (accords de genre/nombre, conjugaison, élisions manquantes)
   - **d. Ponctuation française** : espace insécable (`\xa0`) **systématique** avant `:`/`;`/`?`/`!` et à l'intérieur des guillemets `« »`. Corriger toute occurrence d'espace normale ou d'absence d'espace vers `\xa0`, même si l'usage existant à cet endroit du fichier est différent — l'objectif est l'harmonisation complète, pas la cohérence locale.
   - **e. HTML/CSS cassé** dans les chaînes `<html>...</html>` (balises non fermées, mal imbriquées, ou espaces intempestives injectées dans des attributs `style="..."` — ce dernier point est un motif récurrent repéré dans ce fichier)
   - **f. Texte corrompu** (résidus de charabia, mots dupliqués)
   - **g. Espaces traînantes** en fin de `msgstr` (souvent un reliquat du retrait d'un `:` final)
   - **h. Mauvaises unités** (ms vs sec, etc.)
   - **i. Spécificateurs de format** (`%1`, `%2`, `%n`) : vérifier que tous ceux du `msgid` sont présents dans le `msgstr`, même nombre, même si l'ordre change pour la grammaire française (ex. `%1 étoiles trouvées dans %2` peut légitimement inverser `%1`/`%2`, mais aucun ne doit disparaître).
   - **j. Accélérateurs clavier** (`&` devant une lettre) : repérer les doublons de raccourci dans une même boîte de dialogue après traduction, ou un `&` mal replacé sur une lettre qui n'existe plus dans le mot traduit.
   - **k. Pluriels** (`msgid_plural`/`msgstr[0]`/`msgstr[1]`) : accord correct des deux formes selon la règle de pluriel française (différente de l'anglais).
   - **l. Majuscules de titre** : l'anglais majuscule chaque mot des menus/titres ("Show Grid Lines"), le français ne majuscule que le premier mot ("Afficher les lignes de grille") — piège fréquent des traductions trop littérales.
   - **m. Espace insécable avant unités et symboles** (`°`, `'`, `"`, `%`), particulièrement fréquent dans KStars (coordonnées, ascension droite/déclinaison, magnitudes).
   - **n. Virgule décimale** vs point anglais dans les valeurs numériques d'exemple présentes dans les chaînes.
   - **o. Terminologie astro standard** : cohérence avec le vocabulaire technique français usuel (ascension droite/déclinaison, pas de calque du type "montée droite" ; noms de catalogues à ne jamais traduire — Messier, NGC, etc.).
   - **p. Anglicismes / calques** : traductions trop littérales qui sonnent faux en français technique (ex. "réaliser" pour "realize" au sens de "se rendre compte").
   - Ne **pas** signaler l'absence de `:` final sur les libellés d'interface courts (choix délibéré de l'utilisateur, voir mémoire `feedback_no_trailing_colon_ui`).

4. **Lister les problèmes** trouvés dans les catégories sélectionnées, dans un tableau `Ligne | Avant | Après proposé | Motif`, classés par gravité (contresens et bugs sérieux en premier).
5. **Attendre la validation explicite** de l'utilisateur avant de corriger quoi que ce soit. Si l'utilisateur soulève un doute sur une correction proposée (ex. une espace traînante pourrait être nécessaire avant un widget numérique), vérifier le raisonnement avant d'agir — ne pas appliquer aveuglément.
6. **Appliquer les corrections** avec un script Python plutôt qu'Edit (le fichier est trop volumineux et les entrées se répètent) :
   - Préférer un remplacement par **contenu exact** (`text.count(old) == 1` avant remplacement) pour les entrées sur une seule ligne.
   - Pour les entrées **multi-lignes** ou quand le remplacement par contenu échoue à cause de caractères invisibles, indexer directement par numéro de ligne (`lines[lineno - 1]`).
   - **Piège fréquent** : la typographie française de ce fichier doit systématiquement utiliser une espace insécable `\xa0` (et non une espace normale) avant `:`, `;`, `?`, `!`, avant les unités/symboles (`°`, `'`, `"`, `%`), et à l'intérieur des guillemets `« »` — voir catégorie **d** et **m**. Si un remplacement échoue avec « 0 occurrences », vérifier d'abord avec `xxd` ou `repr()` si le texte existant contient déjà un `\xa0` plutôt qu'un espace normale, avant de re-essayer avec le bon caractère.
   - Ne jamais toucher aux entrées `kstars_i18n.cpp` ni retirer un `:` final délibéré.
7. **Valider** avec `msgfmt --check kstars.po -o /dev/null`.
8. **Committer séparément pour ce lot uniquement** :
   - `git add kstars.po && git commit --author="steve <stax@ik.me>"` avec un message décrivant les catégories de corrections (pas de liste exhaustive ligne par ligne).
   - **Jamais** de `Co-Authored-By`.
   - **Jamais** de `git push` — l'utilisateur pousse lui-même.
9. **Vérifier l'harmonisation avec la doc** : si le lot a corrigé au moins un libellé UI court (pas une description longue type tooltip/whatsthis), lancer `python3 ~/sources/documentation-kstars-docs-kde-org/check_ui_labels.py` (nécessite `polib`, déjà installé) depuis la racine de ce dépôt doc. Ce script compare les libellés cités entre `` `` `` dans les `.po` de la doc avec leur traduction dans `kstars.po`. Corriger dans la doc toute nouvelle divergence causée par la correction du lot (commit séparé dans le dépôt doc, même règles : `--author="steve <stax@ik.me>"`, sans push). Voir [[reference_check_ui_labels]]. Ne pas toucher aux divergences préexistantes sans rapport avec le lot en cours.
10. **Mettre à jour le suivi** :
   - `TaskUpdate` : marquer le lot `completed`.
   - Éditer `project_kstars_po_review.md` : ajouter la ligne d'avancement du lot (commit(s), nombre de corrections, points notables).
   - Si un motif de bug transversal est découvert ailleurs dans le fichier (hors du lot courant), le noter dans la section "Motifs récurrents" de cette mémoire pour ne pas le re-découvrir plus tard.
   - Mettre à jour la ligne d'index dans `MEMORY.md`.

## Décisions transversales déjà tranchées

- Pas de `:` final sur les libellés UI courts → voir `feedback_no_trailing_colon_ui`. **Le repérage manuel lot par lot n'est pas fiable** : après la clôture des 22 lots de kstars.po, une passe automatisée a trouvé 52 occurrences oubliées dans des lots déjà validés (voir `project_kstars_po_review`, section "Passe complémentaire"). En clôture d'une relecture complète (ou si l'utilisateur en fait la demande en cours de route), lancer une passe dédiée par script cherchant tout `msgid` de widget QLabel/QCheckBox/QPushButton/QRadioButton/QGroupBox se terminant par `:` dont le `msgstr` garde encore un `:` final (espace normale ou insécable), plutôt que de compter uniquement sur la vigilance manuelle.
- Points de suspension : uniformisés vers `…` (caractère unicode) en fin de `msgstr`, jamais `...` (ASCII) — sauf dans les `msgid` anglais sources, à ne pas toucher.
- **La même leçon (repérage manuel lot par lot non fiable) s'applique aussi aux espaces insécables (catégorie d/m) et aux points de suspension.** En clôture d'une relecture complète, prévoir systématiquement une passe automatisée par script pour ces trois catégories (au minimum) : `:` finaux oubliés, espaces normales restantes avant `:`/`;`/`?`/`!`/`« »`/unités, et `...` ASCII restants — ne pas se fier uniquement à la vigilance manuelle lot par lot pour ces motifs répétitifs et faciles à manquer visuellement.
- Si un nouveau motif transversal (touchant beaucoup d'entrées dans tout le fichier) est repéré, le signaler explicitement à l'utilisateur et proposer une passe dédiée séparée du lot en cours, plutôt que de le mélanger aux corrections du lot — voir comment la question des points de suspension a été traitée.
- **Ajout de nouvelle(s) catégorie(s) à la checklist après la clôture d'une relecture complète** (ex. catégories i à p ajoutées le 2026-07-11, après clôture des 22 lots + `kstars_i18n.cpp` + fusion summit) : la couverture des lots déjà relus sur ces catégories est **nulle**, pas seulement incomplète — elles n'existaient pas au moment de la relecture. Traiter comme une passe complémentaire dédiée (voir [[project_kstars_po_review]] pour le plan concret), et avant de se lancer dans une relecture manuelle intégrale, trier les catégories par automatisabilité :
  - **Full-scan scriptable directement** (motif syntaxique détectable à 100 %, ex. spécificateurs de format `%1`/`%2`/`%n`, espace insécable avant unité, virgule décimale) → script sur tout le fichier, tableau de diffs, validation, correction.
  - **Extraction de candidats par script + relecture ciblée** (motif repérable mais jugement humain nécessaire sur chaque occurrence, ex. pluriels, accélérateurs clavier, majuscules de titre) → script qui réduit ~14 900 entrées à une liste de candidats, puis relecture normale sur ce sous-ensemble seulement.
  - **Manuel / grep de motifs connus** (jugement linguistique pur, pas de motif syntaxique fiable, ex. terminologie technique, anglicismes) → grep ciblé sur des anti-patterns déjà repérés en premier lieu ; relecture manuelle intégrale seulement si le grep ne suffit pas.
- **Catégorie m (espace insécable avant unités/symboles °, ', ", %) — piège découvert le 2026-07-11** : un script full-scan brut donne énormément de faux signaux. Dans `kstars.po`, la notation compacte d'angle (arcmin/arcsec/degré, ex. `170' - 240'`, `%1°`, DMS) a une convention dominante et cohérente de **zéro espace**, sur des dizaines d'occurrences sans exception — y insérer une espace insécable casserait cette convention établie (qui correspond à l'usage scientifique standard des DMS compacts). Ne corriger que les vraies incohérences **internes au fichier** (une entrée qui dévie de la convention majoritaire pour ce même symbole), pas toutes les occurrences détectées par le motif syntaxique. Toujours établir la convention dominante par symbole avant de proposer des corrections.
- **Catégorie n (virgule décimale) — piège découvert le 2026-07-11** : la majorité des `\d+\.\d+` détectés dans les `msgstr` ne sont **pas** des valeurs d'exemple à localiser : désignations d'époque astronomique (`J2000.0`), tailles de fichiers techniques, numéros de version logicielle (`v4.1.0`), adresses IP, URLs/DOI, syntaxe de saisie affichée à l'identique. Ne proposer la conversion que pour des valeurs numériques citées en prose explicative (tooltip, exemple d'usage) ; se méfier aussi des valeurs seules type `msgid` = `"3.5"` qui peuvent être une valeur de champ numérique (`QDoubleSpinBox`) potentiellement reparsée par le code selon la locale, où changer le texte risquerait de casser la valeur plutôt que juste l'affichage.
- **Catégorie l (majuscules de titre) — rendement très faible constaté le 2026-07-11** : même après un filtrage agressif (ne garder que les `msgid` en vraie Title Case anglaise, exclure une longue liste de noms propres/marques/acronymes/labels techniques), le taux de vrai positif est resté autour de 4 % sur `kstars.po` (6 corrections sur 164 candidats). Le vocabulaire du domaine (noms d'astronomes, marques d'instruments, catalogues, termes techniques) sature ce type de détection syntaxique. Ne pas viser l'exhaustivité automatisée sur cette catégorie : mieux vaut relire un échantillon, évaluer le ratio signal/bruit tôt, et accepter un résultat partiel plutôt que d'éplucher mécaniquement tous les candidats. **Décision utilisateur (2026-07-11)** : les libellés à deux volets joints par `&`/`&&` (ex. « Acquisition & Résolution », « Charger & Pointer ») qui gardent une majuscule sur les deux mots sont un choix de style assumé — ne pas les signaler comme des calques à corriger.
- **Catégories o (terminologie astro) et p (anglicismes/calques) — méthode affinée le 2026-07-11** : contrairement aux apparences, une partie est scriptable, mais pas par simple détection syntaxique (ni par le "minage" statistique naïf) :
  - **Ce qui marche** : (1) préservation mécanique des noms de catalogues (extraire les motifs `NGC \d+`/`Messier \d+`/etc. du `msgid`, vérifier qu'ils réapparaissent identiques dans le `msgstr`) ; (2) une liste de paires (mot anglais piège, calque français correspondant) **croisée avec le `msgid`** — ne flaguer une occurrence du calque français que si le mot anglais piège est vraiment présent dans le `msgid` correspondant, ce qui élimine l'essentiel du bruit (ex. ne signaler "actuellement" que si le `msgid` contient "actually", pas partout où "actuellement" traduit correctement "currently").
  - **Ce qui ne marche pas bien** : le minage statistique (fréquence des cognats anglais/français, fréquence des n-grammes techniques) proposé comme alternative plus systématique a été testé en profondeur mais n'a rien trouvé de neuf : le vocabulaire scientifique commun franco-anglais est dominé par des cognats et une terminologie déjà cohérente (hérité des 22 lots), donc ce type d'analyse ne fait que confirmer l'absence de problème plutôt que d'en révéler. Ne pas y investir de temps sauf pour une vérification de tranquillité d'esprit ponctuelle.
  - **Ce qui marche le mieux reste le signal humain** : la seule vraie incohérence terminologique trouvée ("backlash" traduit tantôt par "jeu" (dominant, 11 occurrences) tantôt par "contrecoups"/"rebond" (4 occurrences)) a été repérée en relisant une chaîne pour une autre catégorie (m) et en remarquant que "contrecoups" sonnait faux dans son contexte — puis vérifiée par `grep` sur toutes les occurrences du terme anglais source. Réflexe à garder : quand un terme "sonne bizarre" en le lisant pour une autre raison, vérifier systématiquement toutes ses occurrences dans le fichier avant de continuer.

## Quand ce workflow ne s'applique pas

Si l'utilisateur travaille sur un fichier `.po` complètement différent sans lien avec ce projet de découpage en lots, ou demande une tâche ponctuelle sur `kstars.po` (ex. corriger une seule chaîne signalée), ce workflow lourd n'est pas nécessaire — traiter la demande directement.
