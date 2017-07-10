import moose
import pylab
import rdesigneur as rd
import sys
import time

import numpy as np
import sys
import os

# Dumping plots to files
def dump_data(dump_dir):
    for x in moose.wildcardFind( '/model/graphs/#' ):
        # Create file name
        name = os.path.join(dump_dir,x.name)
        np.savetxt(name, x.vector)

path = './cells/R155T1.CNG.swc'
simTime = 0.05

DUMP_PATH = sys.argv[1]

rdes = rd.rdesigneur(
	chanProto = [
		['./chans/hd.xml'],
		['./chans/kap.xml'],
		['./chans/kad.xml'],
		['./chans/kdr.xml'],
		['./chans/na3.xml'],
		['./chans/nax.xml'],
		['./chans/CaConc.xml'],
		['./chans/Ca.xml']
	],
	cellProto = [[path, 'elec']],
	spineProto = [['makeActiveSpine()', 'spine']],
	chanDistrib = [
		["hd", "#dend#,#apical#", "Gbar", "50e-2*(1+(p*3e4))" ],
		["kdr", "#", "Gbar", "p < 50e-6 ? 500 : 100" ],
		["na3", "#soma#,#dend#,#apical#", "Gbar", "850" ],
		["nax", "#soma#,#axon#", "Gbar", "1250" ],
		["kap", "#axon#,#soma#", "Gbar", "300" ],
		["kap", "#dend#,#apical#", "Gbar",
			"300*(H(100-p*1e6)) * (1+(p*1e4))" ],
		["Ca_conc", "#", "tau", "0.0133" ],
		["kad", "#soma#,#dend#,#apical#", "Gbar", "50" ],
		["Ca", "#", "Gbar", "50" ]
	],
	spineDistrib = [['spine', '#dend#,#apical#', '20e-6', '1e-6']],
	stimList = [['soma', '1', '.', 'inject', '(t>0.02) * 1e-9' ]],
	plotList = [['soma', '1', '.', 'Vm', 'Membrane potential'],
	        ['soma', '1', 'Ca_conc', 'Ca', 'Ca conc (uM)']],
	#plotList = [['soma', '1', '.', 'Vm', 'Membrane potential']]
	#moogList = [['#', '1', 'Ca_conc', 'Ca', 'Calcium conc (uM)', 0, 120],
	#    ['#', '1', '.', 'Vm', 'Soma potential']]
)

rdes.buildModel()

moose.reinit()
start_time = time.time()
moose.start(simTime)
end_time = time.time()

print "Time taken: ", (end_time-start_time)

# Dumping table data to DUMP_PATH folder
dump_data(DUMP_PATH)

# Visualization
rdes.display()

#plot1 = moose.element("/model/graphs/plot0")
#plot2 = moose.element("/model/graphs/plot1")


#rdes.displayMoogli( 0.0002, 0.0255 )
