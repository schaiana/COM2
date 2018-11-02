% Curso: Engenharia de Telecomunicações
% Disciplina: COM2
% Alunas: Leticia e Schaiana
% Exercício 2: implementação de um receptor OFDM., seguido de equalização.

function [X] = ex2_receptor(x,h,N,u)

    % Tamanho novo da matriz
    col = length(x)/(N+u);
    
    % Converte de serial para paralelo
    y_sp = reshape(x,[(N+u),col]);
    
    % Retira o PC correspondente ao tamanho u
    y_sp(1:u,:) = [];
    
    % Transformada de Fourier
    Y = fft(y_sp);
    
    % Cálculo do H
    H = fft(h,N); 
    H_t = H.';
    
    % Ajusta a matriz
    rep = repmat(H_t,1,size(Y,2));
    
    % Equalização
    X_hat = Y./rep;
    X = reshape(X_hat,1,[]);
    
end
