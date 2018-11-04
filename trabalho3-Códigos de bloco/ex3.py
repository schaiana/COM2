# coding: utf-8

import numpy as np
import sindrome
import komm
import matplotlib.pyplot as plt

N_cw = 100000 
code = komm.HammingCode(3) 
EbN0_list = np.arange(-1.0, 8.0, step = 1.0) 

k = code.dimension
n = code.length
R = code.rate
u = np.random.randint(2, size = k*N_cw)

u_reshaped = np.reshape(u,newshape = (N_cw,k))
c_reshaped = np.apply_along_axis(code.encode, axis = 1, arr = u_reshaped)

c = np.reshape(c_reshaped, newshape = (n*N_cw,)) 
mod = komm.PAModulation(2)
s = mod.modulate(c)
Pb = []
for EbN0 in EbN0_list:
    EbN0_linear = 10**(EbN0/10)
    Eb = np.linalg.norm(s)**2 #Eb = total de energia transmitida (cada elem. ao quadrado somado, que dá 700000)/ número de bits de informação (400000)
    N0 = Eb/EbN0_linear
    w = np.random.randn(n*N_cw) * np.sqrt(N0/2) #vetor gaussiano com média zero e variância 1, multiplica pela raiz da variância do canal awgn (N0) para mudar a variância 1
    r = s + w
    b = mod.demodulate(r)
    b_reshaped = np.reshape(b, newshape = (N_cw, n))
    u_hat_reshaped = np.apply_along_axis(code.decode, axis = 1, arr = b_reshaped)
    u_hat = np.reshape(u_hat_reshaped, newshape = (k*N_cw))
    Pb.append(np.sum(u != u_hat)/(k*N_cw)) 

#armazenar num vetor e depois colocar pontos
    print(EbN0)
    

    plt.figure(1)
    plt.semilogy(-1:7,Pb)
    plt.ylabel('Probabilidade de erro (Pb)')
    plt.xlabel('dB')
    plt.show()
    