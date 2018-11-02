% Curso: Engenharia de Telecomunica��es
% Disciplina: COM2
% Alunas: Leticia e Schaiana
% Exerc�cio 3: Gerador de sequ�ncias bin�rias pseudo-aleat�rias (LFSR)

close all; clear all; clc;

%Par�metros sequ�ncia bin�ria pseudo-aleat�ria 1
estado = [1 0 0];
taps = [1 3];
a_corr1 = fc_lfsr(taps,estado);
%Par�metros sequ�ncia bin�ria pseudo-aleat�ria 2
estado = [1 0 0 0 0];
taps = [5 2];
a_corr2 = fc_lfsr(taps,estado);
%Par�metros sequ�ncia bin�ria pseudo-aleat�ria 3
estado = [1 0 0 0 0];
taps = [5 4 2 1];
a_corr3 = fc_lfsr(taps,estado);

%Par�metros sequ�ncia bin�ria pseudo-aleat�ria 4
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
subplot(411);plot(-10:10,a_corr1,'r');title('Sequ�ncia bin�ria pseudo-aleat�ria 1');
subplot(412);plot(-34:34,a_corr2); title('Sequ�ncia bin�ria pseudo-aleat�ria 2');xlim([-35 35]); 
subplot(413); plot(-34:34,a_corr3,'k');title('Sequ�ncia bin�ria pseudo-aleat�ria 3'); xlim([-35 35]);
subplot(414); plot(-34:34,a_corr4,'g');title('Sequ�ncia Aleat�ria');xlim([-35 35]);
