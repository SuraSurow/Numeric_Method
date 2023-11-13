function [x, y, z, a, v] = eliminacjaGaussa(M_wspol, W_kolumn)
    [wierszW, kolW] = size(W_kolumn);
    [wierszM, kolM] = size(M_wspol);
    
    if (kolW > 1) 
        error("Wektor kolumnowy B ma za dużo kolumn (MAX 1)");
    end
    
    if (wierszW ~= wierszM) 
        error("Ilość wierszy w macierzy i wektorze nie jest taka sama!!!");
    end

    rozszM = [M_wspol W_kolumn];

    for i = 1:wierszM
        [~, maxIndex] = max(abs(rozszM(i:end, i)));
        maxIndex = maxIndex + i - 1;
        rozszM([i maxIndex], :) = rozszM([maxIndex i], :);
        
        for j = i+1:wierszM
            mnoznik = rozszM(j, i) / rozszM(i, i);
            rozszM(j, :) = rozszM(j, :) - mnoznik * rozszM(i, :);
        end
    end
    
    W_rozw = zeros(wierszM, 1);
    
    for i = wierszM:-1:1
        W_rozw(i) = (rozszM(i, end) - rozszM(i, i+1:wierszM) * W_rozw(i+1:wierszM)) / rozszM(i, i);
    end
    
    % Wyniki
    x = W_rozw(1);
    y = W_rozw(2);
    z = W_rozw(3);
    a = W_rozw(4);
    v = W_rozw(5);
    
    % Wyświetlanie wyników
    fprintf('Wyniki:\n');
    fprintf('x = %.4f\n', x);
    fprintf('y = %.4f\n', y);
    fprintf('z = %.4f\n', z);
    fprintf('a = %.4f\n', a);
    fprintf('v = %.4f\n', v);
end
        W_rozw(i) = (rozszM(i, end) - rozszM(i, i+1:wierszM) * W_rozw(i+1:wierszM)) / rozszM(i, i);
    end
end
