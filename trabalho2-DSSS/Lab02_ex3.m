% Curso: Engenharia de Telecomunicações
% Disciplina: COM2
% Alunas: Leticia e Schaiana
% Exercício 3: Gerador de sequências binárias pseudo-aleatórias (LFSR)

close all; clear all; clc;

%Parâmetros sequência binária pseudo-aleatória 1
estado = [1 0 0];
taps = [1 3];
a_corr1 = fc_lfsr(taps,estado);
%Parâmetros sequência binária pseudo-aleatória 2
estado = [1 0 0 0 0];
taps = [5 2];
a_corr2 = fc_lfsr(taps,estado);
%Parâmetros sequência binária pseudo-aleatória 3
estado = [1 0 0 0 0];
taps = [5 4 2 1];
a_corr3 = fc_lfsr(taps,estado);

%Parâmetros sequência binária pseudo-aleatória 4
random = randi([0 1], 1, 31);
j = 1;
M = 5;
N = 2.^M -1;  

for i = -N-3:N+3
    codigo_ciclico = circshift(random,i,2);
    a_corr4(j) = ((sum(random.*codigo_ciclico))/N);
    j = j+1;    
end

figure(1)
subplot(411);plot(-10:10,a_corr1,'r');title('Sequência binária pseudo-aleatória 1');
subplot(412);plot(-34:34,a_corr2); title('Sequência binária pseudo-aleatória 2');xlim([-35 35]); 
subplot(413); plot(-34:34,a_corr3,'k');title('Sequência binária pseudo-aleatória 3'); xlim([-35 35]);
subplot(414); plot(-34:34,a_corr4,'g');title('Sequência Aleatória');xlim([-35 35]);
