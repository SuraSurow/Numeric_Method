clc
close all
clear all

wybor = 4;

switch wybor
    case 1
        f = @(x) exp(x - 1) - 2;
        a = -1;
        b = 2;
    case 2
        f = @(x) (2.^-x) + exp(x) + 2*cos(x) - 6;
        a = 1;
        b = 3;
    case 3
        f = @(x) log(x + (2/3));
        a = -0.5;
        b = 2;
    case 4
        f = @(x) x.^3 - 2*x - 5;
        a = 0;
        b = 3;
    otherwise
        error('Nieprawidłowy wybór.');
end

tol = 10^(-5);
ftol = 10^(-4);

[xb, nb] = sieczne(f, a, b, tol, ftol);

[xf, nf] = styczne(f, a, b, tol, ftol);

t = a :0.01: b;
plot (t , f (t) )
hold on ;
grid on ;
plot ( xb , f( xb ) , 'ro ')
plot ( xf , f( xf ) , 'rx ')


