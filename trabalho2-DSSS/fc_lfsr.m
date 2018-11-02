

function [a_corr] = fc_lfsr(taps,estado)

    m = length(estado);
    N = 2.^m -1;     

    for i=1:N
        xor = mod(sum(estado(taps)),2);
        cod(i) = estado(end);
        estado = circshift(estado,N,2);
        estado(1) = xor;
    end

    j = 1;
    for i = -N-3:N+3
        p = (cod*2)-1;
        shift_circ = circshift(p,i,2);
        a_corr(j) = ((sum(p.*shift_circ))/N);    
        j = j+1;    
    end
    
end
