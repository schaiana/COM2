# coding: utf-8

import numpy as np
import sindrome
import komm

param = {}
param['n'] = 7
param['k'] = 4

b = np.random.randint(2, size = param['n'])
#code = komm.HammingCode(param['n']-param['k'])
#param['c'] = code.encode(u)
mod = komm.PAModulation(2)
s = mod.modulate(b)

awgn = komm.AWGNChannel(snr=1.0, signal_power=1.0)
r = awgn(s); 
u_hat = sindrome.decode_SDD(r, param)
print('b = {}\n û = {}'.format(b, u_hat))

'''
% Codigo de Hamming
codigo.n = 7;
codigo.k = 4;
% Taxa do codigo
R = codigo.k/codigo.n;
% Matriz geradora
Ik = eye(k,k);
p = [1 1 0;1 0 1;0 1 1;1 1 1];
codigo.G = [Ik,p];
% Palavras codigo
u_decimal = [0:2^codigo.k-1];
codigo.u = de2bi(u_decimal,codigo.k,2,'left-msb');
% Codigo de bloco
C = mod(codigo.u*codigo.G,2);
codigo.c = (C*2)-1;
% Informacao: b
b = randi([0 1], 1,codigo.n)
b_polar = (b*2)-1;
r = awgn(b_polar,1);
objeto_sindrome = Sindrome;
u_estimado = objeto_sindrome.SDD(r,codigo)
function [u_hat] = SDD(r,struct_info)
    c = struct_info.c;
    k = struct_info.k;
    dist = r * c';
    [M, index] = max(dist);
    c_hat = (c(index,:)+1)/2;
    u_hat = c_hat(1:k);
end'''

