% Curso: Engenharia de Telecomunicações
% Disciplina: COM2
% Alunas: Leticia e Schaiana
% Exercício 1: Implementação de um sistema DSSS 

close all; clear all; clc;

% Parâmetros
Nb = 800;	% Número de bits transmitidos
L = 200;	% Código: pseudo-aleatório de período
N = 10;     % Número de chips por bit de informação
fc = 40000; % Modulação BPSK 
spc = 100;  % Número de amostras por chip
spb = spc*N;% Taxa de amostras por bit
Rb = 1000;	% Taxa de bits
fa = Rb*spb;% Frequência de amostragem
Tb = 1/Rb;  % Tempo de bit
Ta = 1/fa;  % Tempo de amostragem
D = Nb*Tb;   % Duração
M = 1e6;    % Número de amostras
t = 0:Ta:D-Ta; % Vetor de tempo
Portadora = cos(2*pi*fc*t); % Portadora

% Cria informação e código 
xt = randi([0 1],1,Nb); % Informação aleatória
ct = randi([0 1],1,L); % Código aleatório 

% Polarização
xt_p = xt.*2-1; % Informação
ct_p = ct.*2-1; % Código

% Superamostragem
f1 = ones(1,spb);
xt_s = filter(f1,1, upsample(xt_p,spb));
f2 = ones(1,spc);
ct_s = filter(f2,1, upsample(ct_p,spc));

% Ajusta o vetor de código
ct_conc = repmat(ct_s,1,length(xt_s)/length(ct_s));

% Informação codificada
st = ct_conc.*xt_s;

% Sinal em BPSK
BPSK = Portadora .* st;

%Ajuste vetor de frequência
passo_f = fa/length(t);
f = -fa/2:passo_f:(fa/2-1);
X = fft(xt_s);
C = fft(ct_conc);
S = fft(st);
sBPSK = fft(BPSK);

%Plots

%Formas de onda no domínio do tempo
figure(1)
subplot(411);plot(t,xt_s,'r');title('Sinal x(t)');xlim([0 4*1/spb]);ylim([-1.2 1.2]);
subplot(412);plot(t,ct_conc);title('Sinal c(t)');xlim([0 4*1/spb]);ylim([-1.2 1.2]);
subplot(413);plot(t,st,'g');title('Sinal s(t)');xlim([0 4*1/spb]);ylim([-1.2 1.2]);
subplot(414);plot(t,BPSK,'k');title('Sinal sBPSK(t)');xlim([0 4*1/spb]);ylim([-1.2 1.2]);

%Espectro no domínio da frequência
figure(2)
subplot(411);plot(f,fftshift(abs(X)),'r');title('X(f)');
subplot(412);plot(f,fftshift(abs(C)));title('C(f)');
subplot(413);plot(f,fftshift(abs(S)),'g');title('S(f)');
subplot(414);plot(f,fftshift(abs(sBPSK)),'k');title('sBPSK(f)');


