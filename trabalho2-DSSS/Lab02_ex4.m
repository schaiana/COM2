% Curso: Engenharia de Telecomunica��es
% Disciplina: COM2
% Alunas: Leticia e Schaiana
% Exerc�cio 4: Probabilidade de erro de bit te�rica e pr�tica

close all; clear all; clc;

%Par�metros
M = 7;
N = 2.^M -1;
spc = 1;
spb = spc*N;
Nb = 100000;
H =  [2 -0.5 0.5];
SNR = 10;
estado = [1 0 0 0 0 0 0];
taps = [7 6 5 4 2 1]; % Tabela 7.1
r_a = randi([0 1], 1,Nb);
% Polariza��o
p = r_a*2 -1
% Superamostragem
x_n = kron(p,ones([1,N]));


for i=1:N
    xor = mod(sum(estado(taps)),2);
    cod(i) = estado(end);
    estado = circshift(estado,N,2);
    estado(1) = xor;
end

% Ajusta o vetor de c�digo
codigo = repmat(cod,1,Nb); 
x = codigo.*x_n;

% Canal 
conv = filter(H,1,x);
Eb = sum(conv.^2)/Nb;

for r = 1:SNR
    % Ru�do linear
    r_l = Eb/10^((r)/10);
    ruido = randn(1,length(conv)).*sqrt(r_l/2);
    
    y = conv + ruido; 
    y_1 = y.*codigo;
    
    remod = reshape(y_1,[spb,Nb]);
    correlator = sum(remod)./spb;
    limiar  = correlator > 0;
    
    % Taxa de erros
    [null, taxa_err(r+1)] = biterr(r_a,limiar);
    
    % Probabilidade de erro de bit te�rica
    pb_t(r+1) = qfunc(sqrt(2.*(10^(r/10))));
  
end

figure(1)
semilogy(0:SNR,taxa_err,'r');
hold on;
semilogy(0:SNR,pb_t,'b');
hold off;
legend('Simula��o','Teoria');
xlabel('Eb/N0');
ylabel('Pb');
title('Desempenho de erro de bit');
