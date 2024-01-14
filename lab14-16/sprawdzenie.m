clc
close all
clear all

a1 = 0.25; b1 = 0.75;
a2 = -10; b2 = 10;
a3 = -2; b3 = 2;
a4 = -2; b4 = -1;

fprintf('Wybierz funkcję:\n');
fprintf('1. f(x) = x^2 - x\t\ta=%.2f\tb=%.2f\n', a1, b1);
fprintf('2. f(x) = (1/3) * x^2 - (13/7) * x + 11\t\ta=%.2f\tb=%.2f\n', a2, b2);
fprintf('3. f(x) = x^4 - 12*x^3 + x + 4\t\ta=%.2f\tb=%.2f\n', a3, b3);
fprintf('4. f(x) = -x^3 + 3*x^2 - 3*x\t\ta=%.2f\tb=%.2f\n', a4, b4);

wybor = input('Wprowadź numer funkcji (1-4): ');

switch wybor
    case 1
        f = @(x) x.^2 - x;
        a = a1;
        b = b1;
    case 2
        f = @(x) (1/3) * x.^2 - (13/7) * x + 11;
        a = a2;
        b = b2;
    case 3
        f = @(x) x.^4 - 12*x.^3 + x + 4;
        a = a3;
        b = b3;
    case 4
        f = @(x) -x.^3 + 3*x.^2 - 3*x;
        a = a4;
        b = b4;
    otherwise
        error('Nieprawidłowy wybór funkcji.');
end

% Sprawdzenie czy użytkownik chce edytować wartości a i b
edycja = input('Czy chcesz edytować wartości a i b? (1 - Tak, 0 - Nie): ');

if edycja
    a = input('Podaj nową wartość a: ');
    b = input('Podaj nową wartość b: ');
end

eps = 1e-5;

% Metoda Połowienia
tic;
[x1, n1] = metodaPolowienia(f, a, b, eps);
czas_polowienia = toc;

fprintf("\nCzas dla Metody Połowienia: %.3f  sek\tWynik:%.2f\tN:%d\t\n", czas_polowienia, x1, n1);

% Metoda Newtona
tic;
[x2, n2] = metodaNewtona(f, a, b, eps);
czas_powella = toc;

fprintf("\nCzas dla Metody Newtona: %.3f  sek\tWynik:%.2f\tN:%d\t\n", czas_powella, x2, n2);

% Wykres funkcji z zaznaczeniem miejsc, gdzie obie metody znalazły minimum
t = linspace(a - 2, b + 2, 1000);
figure;
plot(t, f(t))
hold on;
plot(x1, f(x1), 'ro', 'MarkerSize', 10)
plot(x2, f(x2), 'rx', 'MarkerSize', 10)
legend('f(x)', 'Minimum Metody Połowienia', 'Minimum Metody Newtona')
title('Wykres funkcji z zaznaczonymi minimum')
xlabel('x')
ylabel('f(x)')
grid on;
hold off;