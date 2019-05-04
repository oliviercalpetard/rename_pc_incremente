# script de renomage automatique des pc - configuration regionreunion
renommer les pcs en incrementant de 1 un copmteur

modifier le code établissement et la mot de passe administrateur pour windows dans rename.sh et winrename.bat et add_user.bat
copier tous les fichiers sur une clé USB
au début tous les compteurs sont a zéro

## pour windows
on lance add_user.bat pour activer le compte administrateur puis winrename.bat

## pour linux
copier lance.sh sur le poste
puis chmod +x lance.sh
puis sudo ./lance.sh

le script vous pose la question si c'est un pc fixe ou un portable ou un all-in-one
il va renomer le pc avec une valeur
copier sur la clé dans un dossier "salle" la liste des pc (partique pour ESU)
copier sur la clé une liste des pc renomer avec leur anciens noms et nouveau noms 
