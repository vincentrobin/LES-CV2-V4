#### import the simple module from the paraview
from paraview.simple import *
#### disable automatic camera reset on 'Show'
#paraview.simple._DisableFirstRenderCameraReset()

# create a new 'OpenFOAMReader'
DonneesBrutes = OpenFOAMReader(FileName='../run/toto.foam',CaseType='Decomposed Case')
DonneesBrutes.MeshRegions = ['internalMesh']
#totofoam.CellArrays = ['Invtign', 'PSfuel', 'PSfuel_0', 'Qwall', 'RS', 'RS_0', 'T', 'Tgf', 'U', 'U_0', 'alphat', 'cmin', 'deltaH', 'nut', 'omegaC', 'omegaFrac', 'omegaRS', 'p', 'p_0', 'rho', 'tau', 'tau_0']
DonneesBrutes.Createcelltopointfiltereddata = 0
DonneesBrutes.CellArrays = ['p','rho']

# get the time-keeper
#timeKeeper1 = GetTimeKeeper()
timesteps = DonneesBrutes.TimestepValues

# create a new 'Integrate Variables'
integrateVariables1 = IntegrateVariables(Input=DonneesBrutes)

# Properties modified on integrateVariables1
integrateVariables1.DivideCellDataByVolume = 1

# Create a new 'SpreadSheet View'
spreadSheetView1 = CreateView('SpreadSheetView')
spreadSheetView1.ViewTime = timesteps[1]

# show data in view
integrateVariables1Display = Show(integrateVariables1, spreadSheetView1)

# Properties modified on spreadSheetView1
spreadSheetView1.FieldAssociation = 'Cell Data'

# set active source
SetActiveSource(integrateVariables1)

# update the view to ensure updated data information
spreadSheetView1.Update()

# export view
ExportView('volavg.csv', view=spreadSheetView1)

# ecriture des donnees
import csv
csvfile=open('volavg.csv')
reader = csv.reader(csvfile, delimiter=',')
a=0
for row in reader:
    a=a+1
    if a > 1:
       volavg=row[2]
       vol=row[1]
       rhomoy=row[3]

f=open('volavg-2.csv', 'w')
writer = csv.writer(f)
writer.writerow((str(spreadSheetView1.ViewTime),vol,volavg,rhomoy))
f.close()

