% 1). Determine os zeros REAIS da função f(x) = x*tan(x)-1, e seus resíduos, entre -2*pi e 2*pi. Lembre-se de verificar e evitar pontos de descontinuidades (nesse caso existem descontinuidades em pi/2 e seus múltiplos);

printf("==================================================================\n");
printf("Questao 1:\n\n");

domain = [-2*pi 2*pi]

f = @(x) x .* tan(x) .- 1

f_roots = roots_newton(f, domain, 0.05, 10, 1e-14)'

residuo = f(f_roots)

%
% 2). Determine todas as raízes, respectivas multiplicidades e resíduos do polinômio de grau 7 com os seguintes coeficientes em ordem decrescente de grau:
%
%        a=[+1 -7  +20.95 -34.75 +34.5004 -20.5012 +6.7512 -0.9504 ]
%
% 2a). Use o método de Newton tradicional (com multiplicidade M=1);

printf("==================================================================\n");
printf("Questao 2a:\n\n");

polynome_coefficients = [+1 -7 +20.95 -34.75 +34.5004 -20.5012 +6.7512 -0.9504]'

polynome_roots = roots_polynomial_newton(polynome_coefficients, 0.001, 1e-14)'

residuo = abs(horner(polynome_coefficients, polynome_roots))

% 2b). Use o método de Newton, usando a estimativa da multiplicidade M de cada raiz (teste diferentes valores de raízes iniciais e diferentes limites (1e-2, 1e-3,...) para a soma dos restos na estimativa da multiplicidade).

printf("==================================================================\n");
printf("Questao 2b:\n\n");

[polynome_roots multiplicities] = roots_polynomial_newton_with_multiplicity(polynome_coefficients, 0.001, 1e-14, 1e-5);

polynome_roots = polynome_roots'
multiplicities = multiplicities'

residuo = abs(horner(polynome_coefficients, polynome_roots))

% 2c). Monte o polinômio fatorado em binômios (x-raiz(1))^M(1) * (x-raiz(2))^M(2) * ....., com as raizes arredondadas paar o seu valor exato.

printf("==================================================================\n");
printf("Questao 2c:\n\n");

polynome = @(x) (x - 0.8)^1 * (x - 0.9)^1 * (x - 1)^3 * (x - 1.1)^1 * (x - 1.2)^1

% RESPOSTAS:
%
% x = + 0.800000000014627 + 0.000000000000000 i com M = 1
% x = + 0.899999999783241 + 0.000000000000000 i com M = 1
% x = + 1.000000000009858 + 0.000000000000000 i com M = 3
% x = + 1.100000000070061 + 0.000000000000000 i com M = 1
% x = + 1.200000000046985 + 0.000000000000000 i com M = 1;
%
% ARREDONDE PARA GERAR O POLINÔMIO EXATO.
%
% 2d). Obtenha e imprime as raízes pela função  roots do Octave e pelo WolfraAlfa.

printf("==================================================================\n");
printf("Questao 2d:\n\n");

polynome_roots_octave = roots(polynome_coefficients)

printf("wolframalpha_result =\n");
printf("\t0.8\n\t0.9\n\t1.00019\n\t1.1\n\t1.2\n");
printf("\t0.999907 - 0.000160622 i\n");
printf("\t0.999907 + 0.000160622 i\n");

%
% 3). Dado o sistema:
%
% f1 = x(1)^3+x(2)^3-2 = 0
%
% f2 = sen(x(1))*cos(x(2))-0.45 = 0
%
% determine e imprima:
%
% - uma solução  pelo método de Newton com derivadas numérica;
%
% - o resíduo máximo das equações do sistema de  equações não lineares
%
% Escolha valores iniciais (radianos) e critério de parada compatível com a variavel double.
printf("==================================================================\n");
printf("Questao 3:\n\n");

f = @(x) x(1)^3 + x(2)^3 - 2

g = @(x) sin(x(1)) * cos(x(2)) - 0.45

initial_value = [-0.5; 0.5;]

solution = non_linear_system_newton(f, g, initial_value, 1e-14)

f_residuo = abs(f(solution))
g_residuo = abs(g(solution))

% Obs.:
%
% (i). Faça o algoritmo completo, com um programa principal (tipo main.m) que chame todas as functions necessárias para cada item, postado no ambiente VPL deste link, em ordem de chamada: main.m deve ser o primeiro arquivo;
%
% (ii). Imprima as respostas de forma clara e concisa, APENAS com os resultados de cada item;
