#
# This python Script creates the boundary condition file containing the inlet and outlet
# velocity profiles of air, fuel and exhaust for OpenFoam LES of CV2
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
import csv
#
# fonction to read a csv file with ";" to separate column
# used to read experimental data file
#
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
# Generic function to describe the valves openning
# It is a mass flow rate in kg/s
#
def funcopenlaw(X):
    Ea=1.85
    coef2=0.10
    coef3=0.027
    min2=max+ 0.000350
    max2=max+ 0.00325
    min3=max+ 0.00372
    max3=max+ 0.00507
    if min < X < max :
        xadim=((X)-min)/(max-min)
        return (coef1*(1-xadim)*np.exp(-Ea*(1-xadim)/(xadim)))
    if min2 < X < max2 :
        xadim2=((X)-min2)/(max2-min2)
        return (coef1*coef2*(1-xadim2)*xadim2)
    if min3 < X < max3 :
        xadim3=((X)-min3)/(max3-min3)
        return (coef1*coef3*(1-xadim3)*xadim3)
    else:
        return 0

def funcopenlaw2(X):
    Ea=0.005
    coef2=0.50
    coef3=0.15
    min2=max+ 0.000350
    max2=max+ 0.00325
    min3=max+ 0.00372
    max3=max+ 0.00507
    if min < X < max :
        xadim=((X)-min)/(max-min)
        return (coef1*(1-xadim)*np.exp(-Ea*(1-xadim)/(xadim)))
    if min2 < X < max2 :
        xadim2=((X)-min2)/(max2-min2)
        return (coef1*coef2*(1-xadim2)*xadim2)
    if min3 < X < max3 :
        xadim3=((X)-min3)/(max3-min3)
        return (coef1*coef3*(1-xadim3)*xadim3)
    else:
        return 0

#
# fitting functions obtained from visualization of the valves openning
# It is a mass flow rate in kg/s
#
def funcopenfit(t):
    if cycl==0 :
        if 0.01012 < t < 0.02468 :
            return 0.8*0.345*(1-(t/0.02468))*np.exp(-2.577*(1-(t/0.02468))/(1-1.438*(1-t/0.02468)))
        if 0.02507 <t < 0.02791 :
            return (80256.7*np.power(t,3)-9125.44*np.power(t,2)+314.348*t-3.40986)
        if 0.02844 < t < 0.02975 :
            return (906927*np.power(t,3)-82515*np.power(t,2)+2497.97*t-25.1637)
        else:
            return 0
    if cycl==1 :
        if 0.0046 < t < 0.01982 :
            return 0.88*0.5977*(1-(t/0.01982))*np.exp(-1.9581*(1-(t/0.01982))/(1-1.0965*(1-t/0.01982)))
        if 0.020203 <t < 0.02305 :
            return (168250*np.power(t,3)-17027.9*np.power(t,2)+500.12*t-4.54119)
        if 0.023581 < t < 0.0249 :
            return (2.2326e6*np.power(t,3)-169789*np.power(t,2)+4294.93*t-36.1402)
        else:
            return 0
    if cycl==2 :
        if 0.00373 < t < 0.01951 :
            return 0.88*0.5575*(1-(t/0.01951))*np.exp(-1.82549*(1-(t/0.01951))/(1-1.02187*(1-t/0.01951)))
        if 0.0199 <t < 0.02274 :
            return (164983*np.power(t,3)-16543.9*np.power(t,2)+480.105*t-4.30259)
        if 0.02327 < t < 0.02458 :
            return (1.9856e6*np.power(t,3)-149859*np.power(t,2)+3760.21*t-31.3723)
        else:
            return 0
    if cycl==3 :
        if t <= 0.00354 or t >= 0.02454 or 0.01946<= t <= 0.01985 or 0.0227 <=t<= 0.02323 :
            return 0
        if 0.00354 < t < 0.01946 :
            return 0.88*0.55266*(1-(t/0.01946))*np.exp(-1.80968*(1-(t/0.01946))/(1-1.00432*(1-t/0.01946)))
        if 0.01985 <t < 0.0227 :
            return (138790*np.power(t,3)-14822.9*np.power(t,2)+441.989*t-4.01844)
        if 0.02323 < t < 0.02454 :
            return (1.64988e6*np.power(t,3)-125525*np.power(t,2)+3171.85*t-26.6267)
        else:
            return 0
#
# READING EPERIMENTAL DATA FILE
#
# file Name
file1 = 'data-exp.csv'
# reading file
xi = reader(file1)
#
# TABLES INITIALIZATION
#
airmassflowratelaw=[]
fuelmassflowrate=[]
exhaustmassflowratelaw=[]
airmassflowratefit=[]
airvelocity=[]
exhaustvelocity=[]
fuelvelocity=[]
density=[]
pressure=[]
temperature=[]
density2=[]
pressure2=[]
temperature2=[]
timeoutlet=[]
soundspeed=[]
soundspeed2=[]
#
# PARAMETERS TO GENERATE VELOCITY PROFILES AS BC
#
# number of point describing the profile
N=1000
# volume chamber of CV2 m3
Volchambre=0.321*10**(-3)
# mean molecular weight
Molweight=0.02884
# gamma
gamma=1.4
# section of the air inlet m2
sectinlet=25*10**(-6)*3.14159
# section of the fuel inlet m2
sectinjecteur=2.8224e-6*3.14159
# section of the exhaust outlet m2
sectoutlet=25*10**(-6)*3.14159
# number of the cycle for which the boundary file is generated
cycl=1
#
cycletime=0.125
# number of fuel injectors
ninjector=4
# intial time s
tminini = 0.0 + cycl*cycletime
tmin=tminini
# final time of the inlet phase
# this is an approximate value : the real end correspond to the closing of the valve
# after this closing the velocity will be set to zero until the outlet openning
tmax = 0.030 + cycl*cycletime
# fuel injection time
injectionstart=0.01 + cycl*cycletime
# fuel injection duration
injectionstop=0.0175 + cycl*cycletime
#
# PARAMETERS for the INLET of each cycles.
# these parameters set the shape of the generic function that describes the inlet valve openning
#
if cycl==0 :
    # desire mass fraction of fuel in the domain at the end of injection
    # (based on air and fuel inlets)
    Yf=0.0
    # initial pressure in the chamber
    Pini=111000
    # intial temperature in the chamber
    Tini=307
    # end time of main valve bounces
    #max=0.023+tmin
    max=0.020+tmin
    # start time of the valve opening
    #min=0.005+tmin
    min=0.010+tmin
    # total mass injected in the domain
    massinjtot=0.00024
    coef1=1
    # name of data file created
    fileC01 = 'CV2inoutBC-0.csv'
    # x variable expe file: time
    varx=(xi[0,:]-xi[0,0])
    # y variable expe file: pressure converted in Mpa
    vary=xi[1,:]/10
if cycl==1 :
    Yf=0.06
    Pini=102089
    Tini=286
    max=0.0198+tmin
    min=0.0015+tmin
    massinjtot=0.00057
    coef1=1
    fileC01 = 'CV2inoutBC-0.125.csv'
    varx=(xi[0,:]-xi[0,0])
    vary=xi[1,:]/10
if cycl==2 :
    Yf=0.06
    Pini=102089
    Tini=286
    max=0.0198+tmin
    min=0.0015+tmin
    massinjtot=0.00057
    coef1=1
    fileC01 = 'CV2inoutBC-0.25.csv'
    varx=(xi[0,:]-xi[0,0])
    vary=xi[1,:]/10

if cycl==3 :
    Pini=101300
    Tini=298
    max=0.0195+tmin
    min=-0.0001+tmin
    coef1=0.492
    fileC01 = 'CV2inoutBC-0.375.csv'
# time table
t = np.linspace(tmin,tmax,N)
timestep=(tmax-tmin)/N
# calculation of integral constant to obtain the right injected mass during the cycle
funcopenint=0
for i in range(N):
     funcopenint+=funcopenlaw(t[i])*timestep
# attention recalage fait que pour le cycle 0 pour l'instant à corriger ensuite
coef1=massinjtot/funcopenint
# intial masse in the chamber
masseini=Pini*Molweight*Volchambre/(8.314*Tini)

# Air loop
airmassinj=0
for i in range(N):
     # mass integration : required to calculate the averaged density in the chamber
     airmassinj+=funcopenlaw(t[i])*timestep
     # averaged density in the chamber
     density.append((masseini+airmassinj)/Volchambre)
     temperature.append(Tini*(density[i]/density[0])**(gamma-1))
     pressure.append(Pini*(density[i]/density[0])**(gamma))
     soundspeed.append((gamma*8.314*temperature[i]/Molweight)**(0.5))
     # air mass flow rate and velocity
     airmassflowratelaw.append(funcopenlaw(t[i]))
     airmassflowratefit.append(funcopenfit(t[i]))
     airvelocity.append(airmassflowratelaw[i]/(density[i]*sectinlet))

# total mass of fuel injected (a cooriger : approximaiton)
massfuel=airmassinj*Yf
# Fuel loop
for i in range(N):
    if injectionstart < t[i] < injectionstop :
        fuelmassflowrate.append(massfuel/((injectionstop-injectionstart)*ninjector))
        fuelvelocity.append(-fuelmassflowrate[i]/(density[i]*sectinjecteur))
    else:
         fuelvelocity.append(0)
         fuelmassflowrate.append(0)

# Information Printing
print ('-----')
print ('INLET - SI')
print ('-----')
print ('initial mass : ', masseini)
print ('initial temperature : ', Tini)
print ('initial pressure : ', Pini)
print ('injected air mass : ',airmassinj)
print ('injected fuel mass : ',massfuel)
print ('end compressure temperature: ', temperature[N-1])
print ('end compressure pressure: ', pressure[N-1])
#
# plotting velocity time evolution (a subsonic inlet assumption is used : to check on this graph)
# plt.figure(figsize=(12,7), dpi=100)
# plt.plot(t,airvelocity)
# #plt.plot(t,soundspeed)
# plt.show()
#
# Velocity and pressure for the constant volume phase : 0
endtimecvc=0.064
timeoutlet=[tmax,tmin+endtimecvc-1*10**(-6)]
exhaustvelocity2=[0,0]
exhaustmassflowratelaw2=[0,0]
# PARAMETERS for the OUTLET of each cycles of the generic function that describes the inlet valve openning
#
tmin=tmin+endtimecvc
tmax=cycletime + cycl*cycletime
if cycl==0 :
    # end time of main valve bounces
    max=0.055+tmin
    # start time of the valve opening
    min=tmin
    # total mass injected in the domain
    massejctot=0.00023
    coef1=1
    # pressure in the chamber before outlet opening
    pressurechange=-14000
    tempchange=-0
    Pini=pressure[N-1]+pressurechange
    Tini=temperature[N-1]+tempchange
    pressure22=[pressure[N-1],pressure[N-1]]
    # nameof data file created
    fileC02 = 'CV2inoutBC-0.03.csv'
if cycl==1 :
    max=0.045+tmin
    min=tmin
    massejctot=0.00074
    coef1=1
    pressurechange=+1080000
    tempchange=+1400
    Pini=pressure[N-1]+pressurechange
    Tini=temperature[N-1]+tempchange
    pressure22=[pressure[N-1],pressure[N-1]]
    fileC02 = 'CV2inoutBC-0.155.csv'
if cycl==2 :
    max=0.045+tmin
    min=tmin
    massejctot=0.00058
    coef1=1
    pressurechange=+750000
    tempchange=+1300
    Pini=pressure[N-1]+pressurechange
    Tini=temperature[N-1]+tempchange
    pressure22=[pressure[N-1],pressure[N-1]]
    fileC02 = 'CV2inoutBC-0.28.csv'
if cycl==3 :
    Pini=101300
    Tini=298
    max=0.0195+tmin
    min=-0.0001+tmin
    coef1=0.492
    fileC02 = 'CV2inoutBC-0.405.csv'
# time table
t2 = np.linspace(tmin,tmax,N)
timestep=(tmax-tmin)/N
#calculation of integral constant to obtain the right injected mass during the cycle
funcopenint=0
for i in range(N):
     # mass integration : required to calculate the averaged density in the chamber
     funcopenint+=funcopenlaw2(t2[i])*timestep
# attention regalage fait que pour le cycle 0 pour l'instant
coef1=massejctot/funcopenint
# intial masse in the chamber
masseini=Pini*Molweight*Volchambre/(8.314*Tini)
# exhaust loop
exhaustmassejc=0
for i in range(N):
     # mass integration : required to calculate the averaged density in the chamber
     exhaustmassejc+=funcopenlaw2(t2[i])*timestep
     # averaged density in the chamber
     density2.append((masseini-exhaustmassejc)/Volchambre)
     temperature2.append(Tini*(density2[i]/density2[0])**(gamma-1))
     pressure2.append(Pini*(density2[i]/density2[0])**(gamma))
     soundspeed2.append((gamma*8.314*temperature2[i]/Molweight)**(0.5))
     # air mass flow rate and velocity
     exhaustmassflowratelaw.append(-funcopenlaw2(t2[i]))
     exhaustvelocity.append(-exhaustmassflowratelaw[i]/(density2[i]*sectoutlet))

exhaustmassflowratelaw2.extend(exhaustmassflowratelaw)
exhaustvelocity2.extend(exhaustvelocity)
pressure22.extend(pressure2)
timeoutlet.extend(t2)

# Information Printing
print ('-----')
print ('OUTLET - SI')
print ('-----')
print ('mass in the closed domain : ', masseini)
print ('ejected exhaust mass : ',exhaustmassejc)
print ('end expansion temperature: ', temperature2[N-1])
print ('end expansion pressure: ', pressure2[N-1])
#
# plotting velocity time evolution (a subsonic inlet assumption is used : to check on this graph)
# plt.figure(figsize=(12,7), dpi=100)
# plt.plot(t,exhaustvelocity)
# plt.plot(t,soundspeed2)
# plt.show()

# Writing Files
with open(fileC01, 'w', newline='') as csvfile:
    spamwriter = csv.writer(csvfile, delimiter=';')
    spamwriter.writerow(['time (s)', 'air mass flow  rate (kg/s)', 'fuel mass flow  rate (kg/s)', 'inlet air velocity (m/s) x','y','z', 'inlet fuel velocity (m/s) x','y','z','pressure'])
    for i in range(N):
        spamwriter.writerow([t[i], airmassflowratelaw[i], fuelmassflowrate[i], airvelocity[i], 0.0, 0.0, fuelvelocity[i], 0.0, 0.0, pressure[i]])

with open(fileC02, 'w', newline='') as csvfile:
    spamwriter = csv.writer(csvfile, delimiter=';')
    spamwriter.writerow(['time (s)', 'air mass flow  rate (kg/s)', 'outlet velocity (m/s) x','y','z','pressure'])
    for i in range(N+2):
        spamwriter.writerow([timeoutlet[i],exhaustmassflowratelaw2[i], exhaustvelocity2[i], 0.0, 0.0,pressure22[i]])

# plot

plt.figure(figsize=(12,7), dpi=100)
#plt.plot(t,airmassflowratelaw)
plt.plot(timeoutlet,exhaustmassflowratelaw2)
plt.show()
# #
#Pa --> Mpa
for i in range(N):
    pressure[i]=pressure[i]/1000000
    pressure2[i]=pressure2[i]/1000000
for i in range(N+2):
    pressure22[i]=pressure22[i]/1000000
    #
plt.figure(figsize=(12,7), dpi=100)
axes1 = plt.gca()
#axes1.set_xlim(tminini, tmax)
axes1.set_xlim(0.185, tmax)
axes1.set_ylim(0.05, 0.4)
plt.plot(t,pressure)
#plt.plot(t2,pressure2)
plt.plot(timeoutlet,pressure22)
plt.plot(varx,vary)
plt.show()
# #
 # plt.figure(figsize=(12,7), dpi=100)
 # plt.plot(timeoutlet,exhaustvelocity2)
 # plt.show()
# #
# plt.figure(figsize=(12,7), dpi=100)
# plt.plot(t,airvelocity)
# plt.show()
