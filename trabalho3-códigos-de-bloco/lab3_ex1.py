# -*- coding: utf-8 -*-
#Interpreta o arquivo como utf-8 (aceita acentos)



import numpy as np
import komm


def HDD(b, code):
    n = code[0]
    k = code[1]
    G = code[2]
    H = code[3]
    LUT = code[4]
    H_t = H.transpose()
    S = np.remainder(b*H_t, 2)    
    nLinhas = len(LUT)    
    nColunas = len(LUT[0])
    u_hat = 0;
    for i in range(1,nLinhas):
        '''if(S == LUT(i,1:k-1)):
            erro = lut(i,(len(s))+1:)
            palavra_codigo = erro^b
            u_hat = palavra_codigo(1:k)'''
def SDD(r, code):  
    c = code[0]
    k = code[1]
    dist = r*c
    v,i = dist.max(0),dist.argmax(0)
    c_hat = (c(i,)+1)/2
    u_hat = c_hat(1:k)
    
    

      

msg="teste"
print(msg)
"""
function [u_hat] = HDD(b,struct_info)
    k = struct_info.k;
    lut = struct_info.lut;
    h = struct_info.h;
    s = mod(b*h',2);
    [l,c] = size(lut);
    u_hat = 0;
    for i=1:l
       if(s == lut(i,1:k-1))
          erro = lut(i,(length(s))+1:end);
          palavra_codigo = xor(erro,b);
          u_hat = palavra_codigo(1:k);
          break
       end
    end
end

function [u_hat] = SDD(r,struct_info)
    c = struct_info.c;
    k = struct_info.k;
    dist = r * c';
    [M, index] = max(dist);
    c_hat = (c(index,:)+1)/2;
    u_hat = c_hat(1:k);
end
"""