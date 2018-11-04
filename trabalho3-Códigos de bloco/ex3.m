clear all;
close all;
N = 10000;
%codigo de Goley
codigo_goley.k = 12;
n_goley = 23;
R_goley = codigo_goley.k/n_goley;
b_goley = randi([0 1], N, codigo_goley.k);
%tabela M tirada da internet (wolfram)
M = [1 0 0 1 1 1 0 0 0 1 1 1; 1 0 1 0 1 1 0 1 1 0 0 1 ; 1 0 1 1 0 1 1 0 1 0 1 0 ; 1 0 1 1 1 0 1 1 0 1 0 0;
    1 1 0 0 1 1 1 0 1 1 0 0; 1 1 0 1 0 1 1 1 0 0 0 1; 1 1 0 1 1 0 0 1 1 0 1 0; 1 1 1 0 0 1 0 1 0 1 1 0;
    1 1 1 0 1 0 1 0 0 0 1 1; 1 1 1 1 0 0 0 0 1 1 0 1; 0 1 1 1 1 1 1 1 1 1 1 1];
paridade = M';
%função matlab que gera matriz identidade
I =  eye(codigo_goley.k);
codigo_goley.G = [I, paridade];
aux = eye(n_goley-codigo_goley.k); 
codigo_goley.h = [paridade',aux];
erro_goley = syndtable(codigo_goley.h);
sindrome_goley = mod(erro_goley*codigo_goley.h',2);
codigo_goley.lut = [sindrome_goley erro_goley];
b_goley_mod = (mod(b_goley*codigo_goley.G,2)*2)-1;
u_goley = de2bi(0:((2^codigo_goley.k)-1),codigo_goley.k,2,'left-msb'); 
palavra_codigo_goley = mod(u_goley*codigo_goley.G,2);
codigo_goley.c = palavra_codigo_goley;
w0 = 1;
w1 = 0;
w2 = 0;
w3 = 0;

A7 = 0;
A8 = 0;
A9 = 0;
A11 = 0;
A12 = 0;
A15 = 0;
A16 = 0;
A23 = 0;
%verificando padroes
for i= 1:length(erro_goley)
    padrao = sum(erro_goley(i,:));
    if(padrao == 1)
        w1 = w1+1;
    end
    if(padrao == 2)
        w2 = w2+1;
    end
    if(padrao == 3)
        w3 = w3 +1;
    end
   
end

for j= 1:length(palavra_codigo_goley)
    padrao2 = sum(palavra_codigo_goley(j,:));
    if(padrao2 == 7)
        A7 = A7+1;
    end
    if(padrao2 == 8)
        A8 = A8+1;
    end
    if(padrao2 == 11)
        A11 = A11 +1;
    end
    if(padrao2 == 12)
        A12 = A12 +1;
    end
    if(padrao2 == 15)
        A15 = A15 +1;
    end
    if(padrao2 == 16)
        A16 = A16 +1;
    end
    if(padrao2 == 23)
        A23 = A23 +1;
    end
end
%hamming
n_hamming = 7;
codigo_hamming.k = 4;
R_hamming = codigo_hamming.k/n_hamming;
codigo_hamming.G = [1 0 0 0 1 1 0; 0 1 0 0 1 0 1; 0 0 1 0 0 1 1; 0 0 0 1 1 1 1];
codigo_hamming.lut = [0 0 0 0 0 0 0 0 0 0; 0 0 1 0 0 0 0 0 0 1; 0 1 0 0 0 0 0 0 1 0; 
    1 0 0 0 0 0 0 1 0 0; 1 1 1 0 0 0 1 0 0 0; 0 1 1 0 1 0 0 0 0 0;
    1 1 0 1 0 0 0 0 0 0];

codigo_hamming.h = [1 1 0 1 1 0 0; 1 0 1 1 0 1 0; 0 1 1 1 0 0 1];
b_hamming = randi([0 1], N, codigo_hamming.k);
b_hamming_mod = (mod(b_hamming*codigo_hamming.G,2)*2)-1;
u_hamming = de2bi(0:((2^codigo_hamming.k)-1),codigo_hamming.k,2,'left-msb'); 
codigo_hamming.c = mod(u_hamming*codigo_hamming.G,2);
%tava dando problema mas com ajuda 
Eb_aux_goley = sum(sum(b_goley_mod.^2))/(N*codigo_goley.k); 
Eb_aux_hamming = sum(sum(b_hamming_mod.^2))/(N*codigo_hamming.k); 

objeto_sindrome = Sindrome;

%goley e hamming simulado
 for Eb = [-1:7]
    aux = Eb_aux_goley/10^(Eb/10);
    ruido = randn(length(b_goley_mod),n_goley).*sqrt(aux/2);
    goley_awgn = b_goley_mod + ruido; 
    y_goley  = goley_awgn > 0;
    
    for i = 1:length(y_goley);
       u_hat_hdd_goley(i,:) = objeto_sindrome.HDD(y_goley(i,:),codigo_goley);
       u_hat_sdd_goley(i,:) = objeto_sindrome.SDD(y_goley(i,:),codigo_goley);
       u_hat_sdd_goley2 = u_hat_sdd_goley > 0;
        
    end;
    [num_hdd_hat_goley(Eb+2), taxa_goley_hdd(Eb+2)] = biterr(b_goley,u_hat_hdd_goley);
    [num_sdd_hat_goley(Eb+2), taxa_goley_sdd(Eb+2)] = biterr(b_goley,u_hat_sdd_goley2);
     
    aux_hamming =  Eb_aux_hamming/10^(Eb/10); 
    ruido_hamming = randn(length(b_hamming_mod),n_hamming).*sqrt(aux_hamming/2);
    hamming_awgn = b_hamming_mod + ruido_hamming; 
    y_hamming  = hamming_awgn > 0;
    
     for i = 1:length(y_hamming);
       u_hat_hamming = objeto_sindrome.HDD(y_hamming(i,:),codigo_hamming);
       u_hat_hamming2 = objeto_sindrome.SDD(y_hamming(i,:),codigo_hamming);
       if(u_hat_hamming==0)
       else
        u_hat_hdd_hamming(i,:) = u_hat_hamming;
       end;
       if(u_hat_hamming2==0)
       else
        u_hat_sdd_hamming(i,:) = u_hat_hamming2;
       end
        
    end; 
    u_hat_sdd_hamming2 = u_hat_sdd_hamming > 0;
    [num_hdd_hat_hamming(Eb+2), taxa_hamming_hdd(Eb+2)] = biterr(b_hamming,u_hat_hdd_hamming);
    [num_sdd_hat_hamming(Eb+2), taxa_hamming_sdd(Eb+2)] = biterr(b_hamming,u_hat_sdd_hamming2);
end;

%teorico
for Eb = [-1:7]
    
    Eb_linear = 10^(Eb/10); 
    %goley
    Eb_aux_goley = Eb_linear*R_goley; 
    %nao codificado usando apenas a equacao da sinalizacao polar
    Pc_not_cod(Eb+2) = qfunc(sqrt(2*Eb_linear)); 
    %HDD
    p_HDD_goley = qfunc(sqrt((2*Eb_aux_goley)));
    Pc_HDD_goley(Eb+2) = 1-(w0*(1-p_HDD_goley)^(n_goley-1) + w1*(1-p_HDD_goley)^(n_goley-1) + w2*(1-p_HDD_goley)^(n_goley-2) + w3*(1-p_HDD_goley)^(n_goley-3));
    %SDD
    Pc_SDD_goley(Eb+2) = A7*qfunc(sqrt(2*7*Eb_aux_goley)) + A8*qfunc(sqrt(2*8*Eb_aux_goley)) + A11*qfunc(sqrt(2*11*Eb_aux_goley))
    + A12*qfunc(sqrt(2*12*Eb_aux_goley)) + A15*qfunc(sqrt(2*15*Eb_aux_goley)) + A16*qfunc(sqrt(2*16*Eb_aux_goley)) + A23*qfunc(sqrt(2*23*Eb_aux_goley));
    %hamming
    Eb_aux_hamming = Eb_linear*R_hamming;
    %HDD
    p_HDD_hamming = qfunc(sqrt((2*Eb_aux_hamming)));
    Pc_HDD_hamming(Eb+2) = 1 - (1*(1-p_HDD_hamming)^(n_hamming-0) + 7*(1-p_HDD_hamming)^(n_hamming-1));
    %SDD
    Pc_SDD_hamming(Eb+2) = 7*qfunc(sqrt(2*3*Eb_aux_hamming)) + 7*qfunc(sqrt(2*4*Eb_aux_hamming)) + 1*qfunc(sqrt(2*7*Eb_aux_hamming));
    
end

%HDD 
figure();
semilogy([-1:7],taxa_goley_hdd);
hold on;
semilogy([-1:7],taxa_hamming_hdd); 
semilogy([-1:7],Pc_HDD_goley);
semilogy([-1:7],Pc_HDD_goley/codigo_goley.k);
semilogy([-1:7],Pc_HDD_hamming);
semilogy([-1:7],Pc_HDD_hamming/codigo_hamming.k);
legend('HDD Goley','HDD Hamming','HDD Goley Superior','HDD Goley Inferior','HDD Hamming Superior','HDD Hamming Inferior')
title('Desempenho do Sistema HDD');
ylabel('Probabilidade de erro (Pb)');
xlabel('dB');
hold off;

%SDD
figure();
semilogy([-1:7],taxa_goley_sdd);
hold on;
semilogy([-1:7],taxa_hamming_sdd); 
semilogy([-1:7],Pc_SDD_goley);
semilogy([-1:7],Pc_HDD_hamming);
legend('SDD Goley','SDD Hamming','SDD Goley Superior','SDD Hamming Superior')
title('Desempenho do Sistema HDD');
ylabel('Probabilidade de erro (Pb)');
xlabel('dB');
hold off;

figure();
semilogy([-1:7],taxa_goley_sdd);
hold on;
semilogy([-1:7],taxa_hamming_sdd); 
semilogy([-1:7],taxa_goley_hdd);
semilogy([-1:7],taxa_hamming_hdd);
semilogy([-1:7],Pc_not_cod);
legend('SDD Goley','SDD Hamming','HDD Goley','HDD Hamming','Desempenho Polar')
title('HDD vs SDD');
ylabel('Probabilidade de erro (Pb)');
xlabel('dB');
hold off;