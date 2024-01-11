function [minimum_extremum, n] = metodaPolowienia(a, b, f, tolInp)
    h = 10.^-5;
    pochodna = @(x) (f(x+h) - f(x-h))/(2 * h);
    tol = tolInp;
    iter = 0;
    while ( b - a  >= tol)
        xm = (a + b) * 0.5; 
        x1 = a + 0.25 * (b - a);
        x2 = b - 0.25 * (b - a);

        if ( ( b - a ) < tol ) || ( abs(pochodna(xm) )< tol)
            minimum_extremum = xm;
            n = iter;
            return;  % Zakończenie funkcji w przypadku spełnienia warunku
        end

        f_a = f(a);
        f_b = f(b);
        f_xm = f(xm);


        if f_b > f_xm && f_b > f_a
            b = (b + xm) * 0.5;
        elseif f_xm > f_a
            a = (a + xm) * 0.5;
        elseif f_a > f_xm && f_a > f_b
            a = (a + xm) * 0.5;
        end

        iter = iter + 1;
    end

    minimum_extremum = xm;
    n = iter;
end