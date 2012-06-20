#!/usr/bin/python

import sys, commands

#combined_energy = float(input('What is the energy of the combined system? '))


C = {'omega500': -37.3418231186, 
     'omega550': -37.3532367442,
     'omega560': -37.3554149946}
C['opt'] = C['omega560']

H = {'exact': -.5,
     'omega500': -0.4910508287,
     'omega510': -0.4914140744,
     'omega520': -0.4917629316,
     'omega530': -0.4920978975,
     'omega540': -0.4924194598,
     'omega550': -0.4927280963,
     'omega560': -0.4930242741,
     'omega1000': -0.4988035643} 
H['opt'] = H['omega1000']

Li = {'omega100':  -7.2560721906,
      'omega200':  -7.2727056069, 
      'omega270':  -7.2845179524,
      'omega300':  -7.2897220928,   
      'omega400':  -7.3077508938,     
      'omega500':  -7.3263661761,    
      'omega600':  -7.3447693290,   
      'omega700':  -7.3622937343,      
      'omega800':  -7.3785097371,      
      'omega900':  -7.3931959666,
      'omega1000': -7.4062833895,     
      'omega10000': -7.4857228705}

Li['opt'] = Li['omega10000']

N = {'omega100': -53.7963285464,
     'omega200': -53.8345639013,
     'omega300': -53.8771446608,
     'omega400': -53.9166487340,
     'omega500': -53.9507765094,
     'omega600': -53.9795882814,
     'omega700': -54.0040214145,
     'omega800': -54.0251837771,
     'omega900': -54.0440598058}

Li2 = {'omega100': -14.5490104861,
       'omega200': -14.5811787103,  
       'omega250': -14.5974918232,    
       'omega270': -14.6041532738,  
       'omega300': -14.6143271052} 


Li2['opt'] = Li2['omega270'] 

CH = {'omega550': -38.0494138875}
CH['opt'] = CH['omega550']


CH3 = {'omega500': -39.3863709237}
CH3['opt'] = CH3['omega500']

print 'Li2 - 2*Li'
print 'Using opt values: ', -627.509469*(Li2['opt'] - 2*Li['opt'])
print 'Using the same values: ', -627.509469*(Li2['omega270'] - 2*Li['omega270'])

print 'CH - (C + H)'
print 'Using opt values: ', -627.509469*(CH['opt'] - H['opt'] - C['opt'])
print 'Using same values: ', -627.509469*(CH['omega550'] - H['omega550'] - C['omega550'])


print 'CH3 - (C + 3*H)'
print 'Using opt values: ', -627.509469*(CH3['opt'] - 3*H['opt'] - C['opt'])
print 'Using same values: ', -627.509469*(CH3['omega500'] - 3*H['omega500'] - C['omega500'])



