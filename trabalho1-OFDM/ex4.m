%Curso: Engenharia de Telecomunicações
%Disciplina: COM2
%Alunas: Leticia e Schaiana
%Exercício 4: plotar envoltórias instantâneas no tempo e espectros na frequência

close all; clear all; clc;

% Parâmetros
Rb = 16e6;
N = 64;
u = 16;
L = 100;
SNR = 100;
h = [(2/sqrt(5)) 0 1/sqrt(5)];
M = 2;
n = N*L;

% Gerando a informação
info = randint(1,n,M);

% Modulando a informação
X = pskmod(info,M);

% Transmitindo a informação
x = ex1_transmissor(X,N,u);

% Canal
conv = filter(h,1,x);
%y = awgn(conv,SNR,'measured');
y = conv;

% Superamostrando
sup = 10;
y_sup = resample(y,sup,1); 
x_sup = resample(x,sup,1);

%Taxa por causa do PC
Rs = Rb + Rb*(u/N); 

% Frequência de amostragem
fa = Rs*sup;

% Período de amostragem
ta = 1/fa;

% Tempo
j = (N+u)*L*sup;
t = 0:ta:j*ta-ta;


% Frequência
i = -length(t)/2:length(t)/2-1;
f = i*fa/2;

% Fourier
X = fft(x_sup);
Y = fft(y_sup);


% Delimitador
tam = (N+u)*sup;

%Plotando as envoltórias e os espectros
figure(1)
subplot(411)
plot(t(1:tam),abs(x_sup(1:tam)));
title('Questão 4 - Sistema OFDM: x(t) - envoltória instantânea no tempo');
subplot(412)
plot(t(1:tam),abs(y_sup(1:tam)));
title('Questão 4 - Sistema OFDM: y(t) - envoltória instantânea no tempo');
subplot(413)
plot(f,10*log10(fftshift(abs(X))));
title('Questão 4 - Sistema OFDM:  x(n) - espectro na frequência');
subplot(414)
plot(f,10*log10(fftshift(abs(Y)))); 
title('Questão 4 - Sistema OFDM: y(n) - espectro na frequência');
