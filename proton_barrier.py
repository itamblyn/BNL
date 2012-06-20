#!/usr/bin/python

# pbepbe = 0.93865702 

E_H2 = -1.15733860711
E_H = -0.494385492148
midpoint = -1.64686818869

barrier = (midpoint - (E_H2 + E_H))*1000*27.211383

print 'pbe ', barrier

# b3lyp = 0.93168464

E_H2 = -1.17061101080
E_H = -0.497311436793
midpoint = -1.66222554903

barrier = (midpoint - (E_H2 + E_H))*1000*27.211383

print 'b3lyp ', barrier

# bnl, gamma .8
E_H = -0.4957886489
E_H2 = -1.1409112140

midpoint = -1.6427181980

barrier = (midpoint - (E_H2 + E_H))*1000*27.211383

print 'bnl8 ', barrier

# bnl, gamma .85

E_H = -0.4962864483
E_H2 = -1.1414701414
midpoint = -1.6438700879

barrier = (midpoint - (E_H2 + E_H))*1000*27.211383

print 'bnl_middle ', barrier

# bnl, gamma .9 
E_H = -0.4966854735
H_H2 = -1.1418873329
midpoint = -1.6447769114


barrier = (midpoint - (E_H2 + E_H))*1000*27.211383

print 'bnl9 ', barrier

# bnl, gamma cross
E_H = -0.4966854735
H_H2 = -1.1418873329
midpoint = -1.6427181980


barrier = (midpoint - (E_H2 + E_H))*1000*27.211383

print 'bnl_cross ', barrier


print "this seems bizzare..."

print "note that the pbe and b3lyp numbers come from g03, not qchem"
