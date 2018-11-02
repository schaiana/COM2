% Curso: Engenharia de Telecomunicações
% Disciplina: COM2
% Alunas: Leticia e Schaiana
% Exercício 1: implementação de um transmissor OFDM.

function [x] = ex1_transmissor(X,N,u)
    
    % Tamanho novo da matriz
    col = length(X)/N;
    i = [N,col];
    
    % Transformando o vetor em matriz
    X_m = reshape(X,i);
    
    % Transformada inversa de Fourier
    X_ifft = ifft(X_m,N,1);
    
    %Prefixo Cíclico (PC)
    
    % Recupera parte do PC correspondente ao tamanho u
    X_pc = X_ifft((N-u+1):N,:);
    
    % Concatena parte do PC com a informação total
    X_conc = [X_pc;X_ifft];
    
    % Realiza a conversão de paralelo para serial e efetua a transmissão
    x = reshape(X_conc,1,[]);
    
end


