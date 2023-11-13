function W_rozw = eliminacjaGaussa(M_wspol, W_kolumn)
    [wierszW, kolW] = size(W_kolumn);
    [wierszM, kolM] = size(M_wspol);
    
    if (kolW > 1) 
        error("Wektor kolumnowy B ma za dużo kolumn (MAX 1)");
    end
    
    if (wierszW ~= wierszM) 
        error("Ilość wierszy w Macierzy i Wektorze nie jest taka sama !!!");
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
end
