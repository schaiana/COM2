# coding: utf-8

import sindrome

b = [[1, 0, 1, 0, 1, 0, 1]]
param = {}
param['n'] = 7
param['k'] = 4
#param['R'] = code['k']/code['n']

u_hat = sindrome.decode_HDD(b, param)
print('b = {}\n û = {}'.format(b, u_hat))





