# coding: utf-8

import numpy as np
import sindrome
import komm

param = {}
param['n'] = 7
param['k'] = 4

u = np.random.randint(2, size = param['k'])
code = komm.HammingCode(param['n']-param['k'])
param['c'] = code.encode(u)
mod = komm.PAModulation(2)
s = mod.modulate(param['c'])
w = np.random.randn(param['n'])*np.sqrt(N0/2) 
r = s + w
u_hat = sindrome.decode_SDD(r, param)
print('u = {}\n û = {}'.format(u, u_hat))

