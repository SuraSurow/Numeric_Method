function [xb, nb] = styczne(f, a, b, tol, ftol)
    tic;
    if (f(a) * f(b) > 0)
        error("Na zadanym przedziale brak pierwiaskow!!!");
    end
    x0 = a;
    x1 = b;
    nb = 0;
    h = 1e-5;
    while true
        f_x0 = f(x0);
        f1_x0 = (f(x0 + h) - f(x0 - h)) / (2 * h);
        if abs(f1_x0) < eps
            error('Bliska zeru przybliżona pochodna. Metoda stycznych nie zadziała.');
        end
        x1 = x0 - f_x0 / f1_x0;
        nb = nb + 1;
        if abs(f(x1)) < ftol || abs(x1 - x0) < tol
            break;
        end
        x0 = x1;
    end
    xb = x1;
    fprintf('styczne wynik = %.6f, n = %d, czas  = %.6f s\n', x1, nb, toc);
end


   