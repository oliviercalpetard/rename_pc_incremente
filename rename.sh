#!/bin/bash

###### plan de renommage machine Ubuntu - DIRED 2016 ###### 

#### changement apporté pour la version 14.04  ####
# - lit le fichier compteur correspondant
# - on incremente le compteur et renomme la machine
# - avec le plan de nommage region reunion.
# - reste a installer fusioninventory-agent
# - V1.03


#CALPETARD Olivier - AMI - lycee Antoine ROUSSIN
#0692 02 25 06

#valeur a modifier par les utilisateurs
#code etablissement Lxx pour lycee Cxx pour college
etab=L05

#votre nom de AMI
ami="Mr CALPETARD Olivier"

#debut du script
#on marque le poste comme fait 
fait=$(date +'%d-%m-%Y--%H:%M:%S')
#salle du pc
echo "Entrez la salle: "
read salle

echo "poste fait le : $fait / par $ami /affecter en salle: $salle
" > /etc/poweredbyme

echo "$salle" > /etc/GM_ESU

#on cherche la cle usb
find /media -type f -name rename.sh > disque
sed -i -e "s/rename.sh//g" disque

#on lit le repertoire de la cle usb
read usb < disque
#on lit le repertoire d'execution
pwd > PWD
read reper < PWD


selection=
until [ "$selection" = "0" ]; do
    echo ""
    echo "c'est un fixe ou un portable?"
    echo "1 - un PC fixe"
    echo "2 - un PC portable"
    echo "3 - un PC All-In-One"    
    echo ""
    echo "0 - quittez"
    echo ""
    echo -n "Entrez votre reponse: "
    read selection
    echo ""
    case $selection in
        1 ) echo "on lit le compte anterieur des PC"
			 
			b=` awk '{print (total +=$1)}' $usb/compteur_ord.txt `
			echo "$b"
			echo "on incremente"
			let b++
			echo "c'est le PC numero: $b"
			xx=` printf %05d $b `
			echo "$etab-ORD$xx" > $usb/nom_ord.txt
			echo "$etab-ORD$xx" > $usb/pcname.txt
			mkdir $usb/$salle
			echo "$etab-ORD$xx">> $usb/$salle/esu_tab.csv
			
			echo "nouveau compte PC: $b"
			echo -n "$b" > $usb/compteur_ord.txt
			echo renommage du pc
			exit;;
			
        2 ) echo "on lit le compte anterieur des Portables"
			
			b=` awk '{print (total +=$1)}' $usb/compteur_por.txt `
			echo "$b"
			echo "on incremente"
			let b++
			echo "c'est le Portable numero: $b"
			xx=` printf %05d $b `
			echo "$etab-POR$xx" > $usb/nom_por.txt
			echo "$etab-POR$xx" > $usb/pcname.txt
			mkdir $usb/$salle
			echo "$etab-POR$xx">> $usb/$salle/esu_tab.csv
			
			echo "nouveau compte portable: $b"
			echo -n "$b" > $usb/compteur_por.txt
			echo renommage du pc
			exit;;
			
		3 ) echo "on lit le compte anterieur des all-in-one"
			
			b=` awk '{print (total +=$1)}' $usb/compteur_aio.txt `
			echo "$b"
			echo "on incremente"
			let b++
			echo "c'est le Portable numero: $b"
			xx=` printf %05d $b `
			echo "$etab-AIO$xx" > $usb/nom_aio.txt
			echo "$etab-AIO$xx" > $usb/pcname.txt
			mkdir $usb/$salle
			echo "$etab-AIO$xx">> $usb/$salle/esu_tab.csv
			
			echo "nouveau compte des All-In-One: $b"
			echo -n "$b" > $usb/compteur_aio.txt
			echo renommage du pc
			exit;;	
		0 ) exit ;;
        * ) echo "merci de tapez 1, 2, ou 0"
    esac
 
  
done

