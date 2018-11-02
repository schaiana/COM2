% Curso: Engenharia de Telecomunicações
% Disciplina: COM2
% Alunas: Leticia e Schaiana
% Exercício 3: simulação do desempenho de erro de bit, teórico e prático.

close all; clear all; clc;

% Parâmetros
N = 16;
u = 4;
L = 50e3;
n = N*L;
SNR = 10;
h = [2 -0.5 0.5];
M = 2;

% Gerando a informação
info = randint(1,n,M);

% Modulando a informação
bpsk = pskmod(info,M);


% Transmitindo a informação
x = ex1_transmissor(bpsk,N,u);

% Pré alocação da matriz, para evitar que o Matlab aumente o tamanho da
% matriz em cada iteração do FOR
taxa_err = zeros(1,SNR+1);
pb_t = zeros(1,SNR+1);

% Variando a razão sinal ruído
for r = 0:SNR
    % Canal 
    conv = filter(h,1,x);    
    y = awgn(conv,r,'measured');
    X = ex2_receptor(y,h,N,u);
    
    % Informação recebida - demodulando a informação
    info_rec = pskdemod(X,M);
    
    % Taxa de erros
    [null, taxa_err(r+1)] = biterr(info,info_rec);
    
    % Probabilidade de erro de bit teórica
    pb_t(r+1) = qfunc(sqrt(2.*(10^(r/10))));
end


% Plotando o desempenho de erro de bit, em teoria e em prática
figure(1)
semilogy(0:SNR,taxa_err,'r');
hold on;
semilogy(0:SNR,pb_t,'b');
hold off;
legend('Simulação','Teoria');
xlabel('Eb/N0');
ylabel('Pb');
title('Questão 3 - Sistema OFDM: Desempenho de erro de bit');