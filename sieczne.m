% Funkcja sieczne
function [x, n] = sieczne(f, a, b, tol, ftol)
    tic; 
    n = 0; 
    X0 = a;
    X1 = b;
    while true
        x = X1 - f(X1) * ((X1 - X0) / (f(X1) - f(X0)));
        if abs(f(x)) < ftol || abs(x - X1) < tol
            break;
        end
        X0 = X1;
        X1 = x;
        n = n + 1;
    end
   fprintf('sieczne wynik = %.6f, n = %d, czas  = %.6f s\n', x, n, toc);  
end
