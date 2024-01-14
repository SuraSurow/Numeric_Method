function [minimum, n] = metodaPolowienia(f, a, b, tol)
    iteration = 0;
    h = 1e-5;
    gradient = @(x) (f(x+h) - f(x-h)) / (2 * h);
        while(abs(b-a)>=tol)
            xm = ( a + b ) / 2;
            x1 = a+0.25*(b-a);
            x2 = b-0.25*(b-a);
            if(f(a)>f(xm))
                a = x1;
            elseif(f(b)>f(xm))
                b = x2;
            else
                a = x1;
                b=x2;
            end
            iteration = iteration + 1;
        end
        minimum = (a+b)/2;
        n = iteration;
        return;
end
          


        
