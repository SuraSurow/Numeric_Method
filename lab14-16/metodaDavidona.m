function [punkt_munimum, iteracje] = metodaDavidona(f, a, b, eps)
    h = 1e-5;
    tol = eps;
    pochodna1 = @(x) (f(x+h) - f(x-h)) / (2 * h);
    pochodna2 = @(x) (f(x+h) - 2 * f(x) + f(x-h)) / (h^2);
    Z = (3 * (f(a) - f(b))/b-a) + pochodna1(a) + pochodna1(b);
        Q = sqrt(Z * Z - pochodna1(a)*pochodna1(b));
        XM = b - (pochodna1(b) + Q -Z)/(pochodna1(b) - pochodna1(a) + 2* Q) *( b-a);
    
    n = 0;
    while(abs(pochodna1(XM)) >= tol || abs(b-a) >=tol)
        Z = (3 * (f(a) - f(b))/b-a) + pochodna1(a) + pochodna1(b);
        Q = sqrt(Z * Z - pochodna1(a)*pochodna1(b));
        XM = b - (pochodna1(b) + Q -Z)/(pochodna1(b) - pochodna1(a) + 2* Q) *( b-a);
        if(pochodna1(XM) > 0)
            b = XM;
        else
            a = XM;
        end
       n=n+1;
    end
    iteracje = n;
    punkt_munimum = XM;
end