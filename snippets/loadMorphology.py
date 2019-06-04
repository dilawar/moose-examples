#########################################################################
# loadMorphology.py ---
#
# Filename:  loadMorphology.py
# Author: Upinder S. Bhalla
# Maintainer: Dilawar Singh
# Logs:
#   2019-06-03: Ported to PyQt5. Python3 only.
########################################################################

import moose
try:
    import moogli
except Exception as e:
    print( 'Moogli not found.' )
    quit(0)
from moose import neuroml
from PyQt5 import QtCore, QtWidgets
import sys
import os

frameRunTime = 0.0002
runtime = 1.0
inject = 5e-10
simdt = 5e-5

def main():
    """
    Demonstrates how one can visualise morphology of a neuron using the MOOSE.
    """
    app = QtWidgets.QApplication(sys.argv)
    filename = 'barrionuevo_cell1zr.CNG.swc'
    moose.Neutral( '/library' )
    moose.Neutral( '/model' )
    cell = moose.loadModel( filename, '/model/testSwc' )
    for i in range( 8 ):
        moose.setClock( i, simdt )
    hsolve = moose.HSolve( '/model/testSwc/hsolve' )
    hsolve.dt = simdt
    hsolve.target = '/model/testSwc/soma'
    moose.le( cell )
    moose.reinit()

    # Now we set up the display
    compts = moose.wildcardFind( "/model/testSwc/#[ISA=CompartmentBase]" )
    compts[0].inject = inject
    ecomptPath = [x.path for x in compts]
    morphology = moogli.extensions.moose.read(path="/model/testSwc", vertices=15)
    viewer = moogli.Viewer("Viewer")
    viewer.attach_shapes( morphology.shapes.values() )
    view = moogli.View("main-view")
    viewer.attach_view( view )
    # morphology = moogli.read_morphology_from_moose(name = "", path = "/model/testSwc")
    # morphology.create_group( "group_all", ecomptPath, -0.08, 0.02, \
    #         [0.0, 0.5, 1.0, 1.0], [1.0, 0.0, 0.0, 0.9] )

    # viewer = moogli.DynamicMorphologyViewerWidget(morphology)
    def callback( morphology, viewer ):
        moose.start( frameRunTime )
        Vm = [moose.element( x ).Vm for x in compts]
        morphology.set_color( "group_all", Vm )
        currTime = moose.element( '/clock' ).currentTime
        #print currTime, compts[0].Vm
        if ( currTime < runtime ):
            return True
        return False

    #viewer.set_callback( callback, idletime = 0 )
    #viewer.showMaximized()
    viewer.show()
    app.exec_()

if __name__ == '__main__':
    main()
