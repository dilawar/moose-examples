"""markov_channels.py: 

"""
    
__author__           = "Dilawar Singh"
__copyright__        = "Copyright 2017-, Dilawar Singh"
__version__          = "1.0.0"
__maintainer__       = "Dilawar Singh"
__email__            = "dilawars@ncbs.res.in"
__status__           = "Development"

import sys
import os
import matplotlib.pyplot as plt
import numpy as np
import moose

def print_channel(a):
    for k in dir(a):
        if '_' == k[0]:
            continue
        if 'get' in k:
            k = k.replace('get', '' )
            try:
                print( k, getattr(a, k.lower()) )
            except Exception:
                pass

a = moose.MarkovChannel('/mc' )
a.numStates = 2
a.labels = ['a', 'b']
a.initialState=[0.1,0.1]
a.state = [0.1, 0.1]
print( a.numStates )
print( a.labels)

