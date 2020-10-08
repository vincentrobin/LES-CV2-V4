#!/bin/bash


#ITERATIONS A TRAITER POUR LE POST-TRAITEMENT
ideb=0
ifin=30


#NOMBRE DE PROCESSUS PARALLELES A CREER
nproc=20


#----------------------------------------------------#
#-ECRIRE ICI LA TACHE A REALISER POUR CHAQUE ITERATION
#----------------------------------------------------#
TacheParIteration () {

  #Iteration courante
  ite=$1

  #Script Python temporaire pour paraview sur la base de Script_visu.py
  NomScriptPython="paraview-volavg-p_${ite}.py"
  cp /home/robinv/scratch/LES-CV2PropaFoam/postprocess/paraview-volavg-p.py $NomScriptPython

  Line="spreadSheetView1.ViewTime = timesteps[$ite]"
  sed -i "25c $Line" $NomScriptPython

  Fic_sortie="pmoy_${ite}.csv"
  Fic_sortie2="pmoy2_${ite}.csv"
  Line="ExportView('$Fic_sortie', view=spreadSheetView1)"
  sed -i "40c $Line" $NomScriptPython
  Line="csvfile=open('$Fic_sortie')"
  sed -i "44c $Line" $NomScriptPython
  Line="f=open('$Fic_sortie2', 'w')"
  sed -i "54c $Line" $NomScriptPython
	
  #Exécution du script Paraview sur l'itération courante
  /home/bonneaul/scratch/ParaView-5.7.0-osmesa-MPI-Linux-Python2.7-64bit/bin/pvbatch $NomScriptPython

  #Nettoyage du fichier temporaire  
  rm $NomScriptPython

  #suppression de la première ligne di fichier
#  tail -1 $Fic_sortie > $Fic_sortie_tmp
#  mv $Fic_sortie_tmp $Fic_sortie

}
#----------------------------------------------------#
#----------------------------------------------------#



#TRAVAIL A EFFECTUER POUR CHAQUE PROCESSUS PARALLELE
TacheParProc () {
  i_proc=$1
  if [ -f "./ListeTravailProc_pmoy_$i_proc" ];then
  ListeIte=$(cat ./ListeTravailProc_pmoy_$i_proc)
  for ite in $ListeIte;
  do
  echo "Proc $i_proc traite l'itération ${ite}"
  TacheParIteration $ite
  done
  rm ./ListeTravailProc_pmoy_$i_proc
  else 
  echo "Proc $i_proc n'a rien à faire...Zzz..."
  fi
}



#REPARTITION DES ITERATIONS ENTRE LES PROCESSUS
#On distribue les itérations à réaliser en passant par un fichier
#temporaire pour chaque processus ListeTravailProc(i)

echo "Début du script"
ideb_proc=0
iend_proc=$(($nproc-1))
for i_proc in `seq $ideb_proc $iend_proc`;
do
Datafileproc="./ListeTravailProc_pmoy_$i_proc"
if [ -f "$Datafileproc" ];then
  rm $Datafileproc
fi
done

i_proc=0
for i_fichier in `seq $ideb $ifin`;
do
  Datafileproc="./ListeTravailProc_pmoy_$i_proc"
  echo "$i_fichier" >> $Datafileproc
  i_proc=$((($i_proc+1)%$nproc))
done

# Chaque processus exécute sa tâche en parallèle
for i_proc in `seq $ideb_proc $iend_proc`;
do
  TacheParProc $i_proc &
done

wait
# concatenation des fichiers de resultats
echo 'temps,volume,pression,massevol' > pmoy2.csv
cat pmoy2_* >> pmoy2.csv
rm pmoy_* pmoy2_*
mv pmoy2.csv pmoy.csv
echo "Fin du script"
