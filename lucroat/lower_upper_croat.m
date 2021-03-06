function [L U B] = lower_upper_croat(n, A, B)
    L(n,n) = 0;
% k = 1
    for i=1:n
        L(i,1) = A(i,1);
        U(i,i) = 1;
    end
    for j=2:n
        U(1,j) = A(1,j)/L(1,1);
    end

% k = 2
    for k = 2:(n-1)
        for i = k:n
            soma = 0;
            for r = 1: k-1
                soma += L(i,r)*U(r,k);
            end
            L(i,k) = A(i,k) - soma;
        end

        for j = k+1:n
            soma = 0;
            for r = 1: k-1
                soma += L(k,r)*U(r,j);
            end
            U(k,j) = (A(k,j) - soma)/L(k,k);
        end
    end
% k = n i = n
    soma = 0;
    for r = 1 : n-1
        soma += L(n,r)*U(r,n);
    end
    L(n,n) = A(n,n) - soma;
end
