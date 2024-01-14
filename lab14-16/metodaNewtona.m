function [punkt_min, iteracje] = metodaNewtona(f, a, b, inpTol)
    h = 1e-5;
    tol = inpTol;
    pochodna1 = @(x) (f(x+h) - f(x-h))/(2 * h);
    pochodna2 = @(x) (f(x+h) - 2 * f(x) + f(x-h) )/( h*h);
    if(abs(f(a))>abs(f(b)))
        xk = b;
    elseif(f(a) < f(b))
        xk = a;
    else
        xk = b;
    end
    n=0;
    while ( abs ( pochodna1(xk) ) >= tol)
        if(f(a) > f(b))
            xk = xk - (pochodna1(xk)/pochodna2(xk));
        elseif(f(a) < f(b))
            xk = xk +(pochodna1(xk)/pochodna2(xk));
        else
            xk = xk - (pochodna1(xk)/pochodna2(xk));
        end
        n=n+1;
    end
    punkt_min = xk;
    iteracje = n;
    if(punkt_min> b)
        punkt_min = b;
    elseif(punkt_min< a)
        punkt_min = a;
    end
end


