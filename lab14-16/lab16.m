function functionSelectorGUI
    
    fig = figure('Position', [100 100 1400 800], 'Name', 'Function Selector', 'NumberTitle', 'off', 'MenuBar', 'none');

 
    uicontrol('Style', 'pushbutton', 'Position', [50,110, 100, 30], 'String', 'Funkcja nr 1', 'Callback', @buttonCallback, 'Tag', 'Button1');
    uicontrol('Style', 'pushbutton', 'Position', [50, 80, 100, 30], 'String', 'Funkcja nr 2', 'Callback', @buttonCallback, 'Tag', 'Button2');
    uicontrol('Style', 'pushbutton', 'Position', [50, 50, 100, 30], 'String', 'Funkcja nr 3', 'Callback', @buttonCallback, 'Tag', 'Button3');
    uicontrol('Style', 'pushbutton', 'Position', [50, 10, 100, 30], 'String', 'Funkcja nr 4', 'Callback', @buttonCallback, 'Tag', 'Button4');
    uicontrol('Style', 'text', 'Position', [250, 110, 400, 15], 'String', 'f = x1.^2 + x2.^2');
    uicontrol('Style', 'text', 'Position', [250, 80, 400, 15], 'String', 'f = -cos (x1) .* cos(x2) .* exp(1).^(-(x1 - pi).^2 + (x2 - pi ).^2)');
    uicontrol('Style', 'text', 'Position', [250, 50, 400, 15], 'String', 'f = (1 - 8.*x1 + 7.*x1.^2 - 7/3.*x1.^3 + 1/4.*x1.^4).*((x2.^2).*exp(1).^-(x2))');
    uicontrol('Style', 'text', 'Position', [250, 10, 400, 15], 'String', 'f = (1 - 8.*x1 + 7.*x1.^2 - 7/3.*x1.^3 + 1/4.*x1.^4).*((x2.^2).*exp(1).^-(x2))');
    
    

 
    function runFunction(choice)
        switch choice
            case 1
                wybor = 1;
            case 2
                wybor = 2;
            case 3
                wybor = 3;
            case 4
                wybor = 4;
        end

        switch wybor
            case 1
                f = @(x1, x2) x1.^2  +  x2.^2 ;
                x1p = -10;
                x1k = 10;
                x2p = -10;
                x2k = 10;
                xpocz = -10;
                ypocz = 10;
                lambda = 1;
                pk = 0.1;
            case 2
                f = @(x1,x2) 3.*x1.^4 - 2/3.*x2.^3 + 2.*x1.^2 + x2.^2;
                x1p = -1;
                x1k = 0.4;
                x2p = -1;
                x2k = 1;
                xpocz = -1;
                ypocz = 1;
                lambda = 0.1;
                pk = 0.02;
            case 3
                f = @(x1,x2) 5*((x1 - 1).^2) + 10*((x2 - 3).^2);
                x1p = -20;
                x1k = 20;
                x2p = -20;
                x2k = 20;
                xpocz = -10;
                ypocz = 10;
                lambda = 1;
                pk = 0.2;

            case 4
                f = @(x1,x2) 100*((x1 - x2.^2).^2) + (1 - x1).^2;
                x1p = -2;
                x1k = 2;
                x2p = -1;
                x2k = 3;
                xpocz = -2;
                ypocz = 3;
                lambda = 0.5;
                pk = 0.1;
        end

        
        [x1_min, x2_min, dx1, dx2, it] = grad(f, xpocz, ypocz, pk, lambda, x1p, x1k, x2p, x2k);
        
        
        plotGraphs(x1_min, x2_min, dx1, dx2, it, f, x1p, x1k, x2p, x2k, lambda,pk);
    end

   
    % Funkcja rysująca wykresy
    function plotGraphs(x1_min, x2_min, dx1, dx2, it, f, x1p, x1k, x2p, x2k, krok,pk)
        % Rysowanie pierwszego subplot
        subplot(2, 1, 1);
        [x, y] = meshgrid(x1p:pk:x1k, x2p:pk:x2k);
        z = f(x, y);
        mesh(x, y, z);
        hold on;
        plot3(dx1, dx2, f(dx1, dx2), 'ko-', 'MarkerSize', 5);
        plot3(x1_min, x2_min, f(x1_min, x2_min), 'r*', 'MarkerSize', 10);
        title('Wykres 3D');
        xlabel('x1');
        ylabel('x2');
        zlabel('f(x1, x2)');

        % Rysowanie drugiego subplot
        subplot(2,1,2 );
        [c, h] = contour(x, y, z);
        clabel(c, h);
        hold on;
        plot(dx1(1), dx2(1), 'bx', 'MarkerSize', 10);
        plot(x1_min, x2_min, 'r*', 'MarkerSize', 10);
        text(dx1(1), dx2(1), ' START');
        text(x1_min, x2_min, ' STOP');
        title('Kontur');
        xlabel('x1');
        ylabel('x2');
        txtResult = uicontrol('Style', 'text', 'Position', [800, 10, 400, 15], 'String', 'Wynik = ');
        set(txtResult, 'String', ['X  = ' num2str(x1_min) '    Y = ' num2str(x2_min) '    Iteration =  ' num2str(it)]);
        uicontrol('Style', 'text', 'Position', [1000, 10, 400, 15], 'String', txtResult);
    end
    
    function buttonCallback(source, ~)
        switch source.Tag
            case 'Button1'
                runFunction(1);
            case 'Button2'
                runFunction(2);
            case 'Button3'
                runFunction(3);
            case 'Button4'
                runFunction(4);
        end
    end
    function [x1_min, x2_min, dx1, dx2, it] = grad(f, xpocz, ypocz, pk, lambda, x1p, x1k, x2p, x2k)
    eps = 1e-2;
    X = [ xpocz ; ypocz];
    iteracje = 0;
    maxIteracja = 400;
    gradiencik = [(f(X(1) + eps, X(2)) - f(X(1), X(2))) / eps; (f(X(1), X(2) + eps) - f(X(1), X(2))) / eps];
    euklides = norm(gradiencik);
    dx1 = [];
    dx2 = [];
    
    while  iteracje <= maxIteracja 
        gradiencik = [(f(X(1) + eps, X(2)) - f(X(1) - eps, X(2)))/(2*eps);(f(X(1), X(2) + eps) - f(X(1), X(2) - eps))/(2*eps)];
        
        euklides = norm(gradiencik);
        alpha =  lambda / euklides;
        X = X - alpha * gradiencik;
        dx1= [dx1 ; X(1)];
        dx2= [dx2 ; X(2)];
        
        iteracje = iteracje + 1;
        if euklides < eps
            break;
        end

       
       
    end
    
    it = iteracje;
    x1_min = X(1);
    x2_min = X(2);
    end
end