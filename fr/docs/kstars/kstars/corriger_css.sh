# !/bin/sh

# les resources href="help...." sont pas trouvées en local
#  <link rel="stylesheet" type="text/css" href="help:/kdoctools5-common/kde-default.css">
#  <link rel="stylesheet" type="text/css" href="help:/kdoctools5-common/kde-docs.css">
#  <link rel="stylesheet" type="text/css" href="help:/kdoctools5-common/kde-localised.css">

# il faut donc les remplacer avec le chemin absolu
# <link rel="stylesheet" type="text/css" href="/usr/share/doc/HTML/en/kdoctools5-common/kde-default.css">
#  <link rel="stylesheet" type="text/css" href="/usr/share/doc/HTML/en/kdoctools5-common/kde-docs.css">
#  <link rel="stylesheet" type="text/css" href="/usr/share/doc/HTML/fr/kdoctools5-common/kde-localised.css">

# il y a aussi la ligne de l'image kde
# <img src="help:/kdoctools5-common/top-kde.jpg" width="36" height="34">
# qu'il faut remplacer par
# <img src="/usr/share/doc/HTML/en/kdoctools5-common/top-kde.jpg" width="36" height="34">

# on fait ça avec sed

for i in *.html
do
  sed -i 's|help:|/usr/share/doc/HTML/en|g' $i
  sed -i 's|/usr/share/doc/HTML/en/kdoctools5-common/kde-localised.css|/usr/share/doc/HTML/fr/kdoctools5-common/kde-localised.css|' $i
done
