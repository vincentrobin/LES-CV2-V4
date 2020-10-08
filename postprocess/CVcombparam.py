#!/usr/bin/python
#
import matplotlib
from scipy.optimize import curve_fit
from matplotlib.figure import Figure
import matplotlib.pyplot as plt
import matplotlib.ticker as mtick
from matplotlib import rc
import numpy as np
import subprocess
import struct
import scipy
import sys
import re
import os
from pylab import *
import operator
#
# vincent :
# chemin latex sur ma machine (mac) : pas nécessaire si latex et python bien installé
os.environ["PATH"] += os.pathsep + '/usr/local/texlive/2019/bin/x86_64-darwin'

# fonction qui lit un fichier text (csv) qui contient un tableau avec des ";" pour séparer les colonnes
def reader(file):
    # attention encodage utf8 : peut créer des bugs de lecture si mal réglé
    f = open(file, encoding='utf-8-sig')
    lines = f.readlines()
    f.close
    N = len(lines)-1
    # délimiteur des chaines de charactère
    line = lines[0].strip().split(";")
    M = len(line)
    x = np.zeros((M,N))
    #
    for i in range(N):
        line = lines[i+1].strip().split(";")
        for j in range(M):
            # il semblerait que la conversion chaine de caractère a float se fasse tout seul ss probleme.
            # Attention ce ne sera peut-être pas toujours le cas!!!!!
            x[j,i] = line[j]
    return x
#
def reader2(file):
    # attention encodage utf8 : peut créer des bugs de lecture si mal réglé
    f = open(file, encoding='utf-8-sig')
    lines = f.readlines()
    f.close
    N = len(lines)-1
    # délimiteur des chaines de charactère
    line = lines[0].strip().split(",")
    M = len(line)
    x = np.zeros((M,N))
    #
    for i in range(N):
        line = lines[i+1].strip().split(",")
        for j in range(M):
            # il semblerait que la conversion chaine de caractère a float se fasse tout seul ss probleme.
            # Attention ce ne sera peut-être pas toujours le cas!!!!!
            x[j,i] = line[j]

    return x
#
#
def tri_ins(t,col):
    N=len(t[col,:])
    M=len(t)
    resu=np.zeros((M,N))
    temp=np.zeros((M))
    for k in range(0,N):
        for l in range(0,M):
            resu[l,k]=t[l,k]
    for k in range(1,N):
        for l in range(0,M):
            temp[l]=resu[l,k]
        j=k
        while j>0 and temp[col]<t[col,j-1]:
            for l in range(0,M):
                resu[l,j]=resu[l,j-1]
            t[col,j]=t[col,j-1]
            j-=1
        t[col,j]=temp[col]
        for l in range(0,M):
            resu[l,j]=temp[l]
    return resu

#
# 0 : DEBUT PROGRAMME
#
# I : PREPARATION DES DONNEES
#
# lecture des données
file1 = '../preprocess/data-exp.csv' # Name of the file that you want to upload
xi = reader(file1) # Call the subroutine
file2 = 'pmoy.csv' # Name of the file that you want to upload
xi2 = reader2(file2) # Call the subroutine
# tri des données temps croissant
xi2=tri_ins(xi2,0)

# manipulation des données expe
# je considère le temps initiale est 0 et on normalise par le temps d'un cycle
timestep=0.0001
cycletime=0.125
n=int(cycletime/timestep)
varx=np.linspace(0,cycletime,n)
# on extrait les quantités pour cycle comp.
vary=[]
ncycle=12
cyclecomp=2
for j in range(ncycle):
    varyc1=[]
    for i in range(n):
        ii=int(n*j+i)
        # attention conversion pression Bar en MPa
        varyc1.append(xi[1,ii]/10)
    vary.append(varyc1)

# dérivée max pression expé
DerP=np.zeros(n)
#print(vary[2][n-1])
for i in range(1,n):
    DerP[i]=(vary[cyclecomp][i]-vary[cyclecomp][i-1])/(varx[i]-varx[i-1])*1000000
Derpmax=max(DerP)
alphamax=20000
dHmax=1200000
gamma=0.4
rhomoy=2.6
Qpertes=0.0*Derpmax
tauxreac=(4*Derpmax+Qpertes)/((1-gamma)*dHmax*rhomoy)
Segreg=1-((4*Derpmax+Qpertes)/((1-gamma)*dHmax*rhomoy*alphamax))
print(Derpmax,Segreg,1-Segreg)
print(tauxreac)
# manipulation des données num

varx2=(xi2[0,:]-0.125)
n2=len(varx2)
# conversion Pa en Mpa
vary2=xi2[2,:]/1000000
# définition des maximas (utile pour le graph)
xmin,xmax=0.038,0.052
#ymin,ymax=min(vary),max(vary)
xmin,xmax=0,max(varx)
#xmin,xmax=0.0325/0.125+2,2.5
#ymin,ymax=0,2
#ymin2,ymax2=0,2

# II : PREPARATION DE LA FIGURE
#
# style, format, etc de la figure
plt.style.use('_classic_test')
s = 16 # taille de la font
rc('font',**{'family':'DejaVu Sans','serif':['Computer Modern Roman']})
rc('text', usetex=True)
rc('xtick', labelsize=s)
rc('ytick', labelsize=s)
rc('axes', labelsize=s)
# taille de la figure
width = 10
height  = width/2.5
plt.figure().set_size_inches(width, height)
# definition des axes pour la courbe pression
axes1 = plt.gca()
axes1.set_xlim(xmin, xmax)
#axes1.set_ylim(ymin, ymax)
plt.ylabel('Pressure ' '($\mathrm{MPa}$)',fontsize=s)
plt.xlabel('Normalised time',fontsize=s)
plt.plot(varx,vary[cyclecomp],color='navy',linewidth=1.5,label='Experiment')
plt.plot(varx2,vary2,color='darkred',linewidth=1.5,label='LES')
#plt.plot(DerPx,DerP,color='darkred',linewidth=1.5,label='der')
#plt.legend(loc='best')
#plt.legend(loc='upper left')
plt.grid()
# definition des axes pour la courbe flux
#axes2 = plt.gca()
#axes2 = axes1.twinx()
#axes2.set_xlim(xmin, xmax)
#axes2.set_ylim(ymin2, ymax2)
#yticks([0.08, 0.18,0.36])
#yticks(np.linspace(0,4,5))
#plt.ylabel('Wall heat flux ' '($\mathrm{MW/m^2}$)',fontsize=s)
#plt.plot(varx,vary2,color='darkred',linewidth=1.5,label='LES')
# echelle log
#plt.yscale('log')
# legende
#h1, l1 = axes1.get_legend_handles_labels()
#h2, l2 = axes2.get_legend_handles_labels()
#axes1.legend(h1+h2, l1+l2, loc='best')
#
# III : SAUVEGARDE DE LA FIGURE
#
plt.legend(loc='best')
#plt.savefig('../JPC_JOINT_v3/media/pressurenumexp.pdf',dpi=350,bbox_inches='tight')
#plt.savefig('image.eps')
plt.show()

