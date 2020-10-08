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
def reader3(file):
    # attention encodage utf8 : peut créer des bugs de lecture si mal réglé
    f = open(file, encoding='utf-8-sig')
    lines = f.readlines()
    f.close
    N = len(lines)-4
    # délimiteur des chaines de charactère
    line = lines[4].strip().split()
    M = len(line)
    x = np.zeros((M,N))
    for i in range(N):
        line = lines[i+4].strip().split()
        for j in range(M):
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
file1 = '../preprocess/python-scripts/data-exp.csv' # Name of the file that you want to upload
xi = reader(file1) # Call the subroutine
cycl=0
if cycl==0 :
    file2 = '../preprocess/CV2cyclefiles/CV2inoutBC-0.csv'
    file3 = '../preprocess/CV2cyclefiles/CV2inoutBC-0.03.csv'
    file4 = '../results/volRegion0.dat'
    file5 = '../results/volRegion0.03.dat'
    xmin,xmax=0,1
    ymin,ymax=0.1,0.5
if cycl==1 :
#
#
    xmin,xmax=1,2
    ymin,ymax=0.1,1.8
#if cycl==2 :
#
#
#if cycl==3 :
#
#
xi2 = reader(file2)
xi3 = reader(file3)
xi4 = reader3(file4)
xi5 = reader3(file5)
# tri des données temps croissant
#xi2=tri_ins(xi2,0)

#print (xi2)
# manipulation des données
# je considère le temps initiale est 0 et on normalise par le temps d'un cycle
cycletime=0.125
varx=(xi[0,:]-xi[0,0])/cycletime
varx2=(xi2[0,:])/cycletime
varx3=(xi3[0,:])/cycletime
varx4=(xi4[0,:])/cycletime
varx5=(xi5[0,:])/cycletime
n=len(varx)
# conversion bar en Mpa
vary=xi[1,:]/10
# conversion Pa en Mpa
vary2=xi2[9,:]/1000000
vary3=xi3[5,:]/1000000
vary4=xi4[1,:]/1000000
vary5=xi5[1,:]/1000000

# définition des maximas (utile pour le graph)
#xmin,xmax=min(varx),max(varx)
#ymin,ymax=min(vary),max(vary)
#xmin,xmax=0,max(varx)
ymin2,ymax2=0,2
# dérivée max pression expé
timestep=0.0001
ncycle=int(cycletime/timestep)
DerPx=np.linspace(0,cycletime,ncycle)
DerP=np.zeros(ncycle)
print(n,ncycle)
for i in range(1,ncycle):
    j=int(i+2*ncycle)
    DerP[i]=(vary[j]-vary[j-1])/(varx[j]-vary[j-1])*(10**6)/0.125
 #   print (DerP[j])
print(max(DerP))

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
axes1.set_ylim(ymin, ymax)
plt.ylabel('Pressure ' '($\mathrm{MPa}$)',fontsize=s)
plt.xlabel('Normalised time',fontsize=s)
plt.plot(varx,vary,color='navy',linewidth=1.5,label='Experiment')
plt.plot(varx2,vary2,color='darkred',linewidth=1.5,label='isentro')
plt.plot(varx3,vary3,color='darkred',linewidth=1.5,label='isentro')
plt.plot(varx4,vary4,color='darkgreen',linewidth=1.5,label='LES')
plt.plot(varx5,vary5,color='darkgreen',linewidth=1.5,label='LES')

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
#plt.legend(loc='best')
#plt.savefig('pressurenumexp.pdf',dpi=350,bbox_inches='tight')
#plt.savefig('image.eps')
plt.show()

