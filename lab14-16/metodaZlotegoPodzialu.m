function [punkt_min, iteracje] = metodaZlotegoPodzialu(f, a, b, tol)
    iter = 0;
    
    e = (sqrt(5) - 1) * 0.5;
    x1 = a + e * e * ( b - a);
    x2 = a + e * (b - a);
    xm = x1 + x2 / 2;

    while abs(x1 - x2) >= tol
        if ( f(x1) > f(x2))
            x1 = xm;
        else
            x2 = xm;
        end
        iter = iter + 1;
    end

    iteracje = iter;
    punkt_min = (a+b)*0.5;
end


