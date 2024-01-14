function [minimum, n] = metodaPowella(f, x1, x3, tol)
    n = 0;
    
    while (x3 - x1) >= tol
        x2 = x1 + (x3 - x1) / 3;
        
        delta = x2 - x1;
        
        xm = x2 - 0.5 * delta * (f(x3) - f(x1)) / (f(x1) - 2*f(x2) + f(x3));
        
        if f(xm) < f(x2)
            if xm < x2
                x3 = x2;
            else
                x1 = xm;
            end
        else
            if xm < x2
                x1 = xm;
            else
                x3 = x2;
            end
        end
        
        n = n + 1;
    end
    
    minimum = (x1 + x3) / 2;
end