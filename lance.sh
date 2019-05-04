#!/bin/bash


###### plan de renommage machine Ubuntu - DIRED 2016 ###### 

#### a copier et le rendre executable ####
# - recherche le chemin de la cle usb
# - pour recuperer les valeurs compteur.
# - V1.03


#CALPETARD Olivier - AMI - lycee Antoine ROUSSIN
#0692 02 25 06



#############################################
# Run using sudo, of course.
#############################################
if [ "$UID" -ne "0" ]
then
  echo "Il faut etre root pour executer ce script. ==> sudo "
  exit 
fi 

#on cherche la cle usb
find /media -type f -name rename.sh > disque

read USB < disque

#on copie le fichier rename.sh vers le repertoire ou on lance le script
pwd > PWD
read reper < PWD
cp "$USB" "$reper"

#on enregistre le chemin de la cle usb pour pouvoir lire les compteurs
sed -i -e "s/rename.sh//g" disque

#on rend le script executable
chmod +x rename.sh

#on lance le script en mode sudo
sudo ./rename.sh
########################################################################
#phase de renommage
########################################################################
#lit le nom actuel du pc $hostn
hostn=$(cat /etc/hostname)
read USB < disque

#lit le fichier pcname.txt sur la cle usb nouveau nom $newhost
read newhost < $USB/pcname.txt

#change hostname in /etc/hosts & /etc/hostname
sudo sed -i "s/$hostn/$newhost/g" /etc/hosts
sudo sed -i "s/$hostn/$newhost/g" /etc/hostname

#affiche le nouveau nom
echo "le nouveau nom est $newhost"

echo $hostn,$newhost >> $USB/liste_pc.csv


echo  "apres le reboot lancer l'installation Fusioninventory-agent"

echo "C'est fini ! Un reboot est nécessaire..."
read -p "Voulez-vous redémarrer immédiatement ? [O/n] " rep_reboot
if [ "$rep_reboot" = "O" ] || [ "$rep_reboot" = "o" ] || [ "$rep_reboot" = "" ] ; then
  reboot
fi


