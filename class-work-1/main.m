format long
% Dado o sistema linear abaixo para n=40 equações:
%
% para  i=1;                                  x(i)+x(i+1)=1.50;
%
% para  i=2:n/2                  x(i-1)+4*x(i)+x(i+1)=1.00;
%
% para  i=n/2+1:n-1           x(i-1)+5*x(i)+x(i+1)=2.00;
%
% para  i=n;                       x(i-1)+x(i)            =3.00;

% a). Armazene o sistema acima em forma de matriz completa;
n = 40;

for i = 1 : n
    for j = 1 : n
        A(i,j) = 0;
    end
end

for i = 1 : n
    if (i == 1)
        A(i, i) = 1;
        A(i, i+1) = 1;
        B(i) = 1.5;
    elseif (i == n)
        A(i, i - 1) = 1;
        A(i, i) = 1;
        B(i) = 3;
    elseif (i <= n/2)
        A(i, i - 1) = 1;
        A(i, i) = 4;
        A(i, i + 1) = 1;
        B(i) = 1.0;
    elseif (i > n/2)
        A(i, i - 1) = 1;
        A(i, i) = 5;
        A(i, i + 1) = 1;
        B(i) = 2.0;
    end
end

% a1). Resolva o sistema acima por um método direto completo (Eliminação Gaussiana (ECV) ou LU-Crout (CCO));

[lu_croat_solve float_ops] = lu_croat_solve(A, B);

image_by_lu_croat = lu_croat_solve * A;

% a2). Imprima somente a 1º e última incógnitas e o resíduo máximo;
printf("X(1) solved by lu_croat:\n\t");
lu_croat_solve(1)

printf("X(40) solved by lu_croat:\n\t");
lu_croat_solve(n)

printf("Residuo maximo by lu_croat:\n\t");
residuo_max = max(abs(lu_croat_solve * A - B))

% a3). Calcule o número total de operações em PONTO FLUTUANTE utilizadas e calcule o número de operações teórico;
printf("lu_croat float operations count:\n\t");
float_ops_lu_croat = float_ops

% b). Armazene o sistema acima na forma otimizada de 4 vetores;

for i = 1
    r(i) = 1;
    d(i) = 1;
end

for i = 2 : n/2
    t(i) = 1;
    r(i) = 4;
    d(i) = 1;
end

for i = n/2 + 1 : n - 1
    t(i) = 1;
    r(i) = 5;
    d(i) = 1;
end

for i = n
    t(i) = 1;
    r(i) = 1;
end

% b1). Resolva o sistema acima por um método direto otimizado (Gauss-Otimizado para matriz tridiagonal);
[gauss_x float_ops] = gauss_solve(t, r, d, B);

% b2). Imprima somente a 1º e última incógnitas e o resíduo máximo;
printf("X(1) solved by gauss tridiagonal:\n\t");
gauss_x(1)

printf("X(40) solved by gauss tridiagonal:\n\t");
gauss_x(n)

printf("Residuo maximo by gauss tridiagonal:\n\t");
residuo_max = max(abs(gauss_x * A - B))

% b3). Calcule o número total de operações em PONTO FLUTUANTE utilizadas e calcule o número de operações teórico;
printf("gauss tridiagonal float operations count:\n\t");
float_ops_gauss_tridiagonal = float_ops

% c). Resolva o sistema acima por um método iterativo (Gauss-Seidel), utilizando o armazenamento otimizado em 4 vetores item b):

% c1). Teste fatores de relaxação f (sub ou sobre, entre 0<f<2) e determine previamente
% (com critério de parada grosseiro, 1e-2) o seu valor otimizado, que permita a convergência
% com o menor número de iterações. Imprima o numero de iterações de cada teste
% (pode-se usar critério de parada maior, 1e-2, para  efetuar menos iterações nesta fase de testes);

for i = 1 : n
    seed(i) = 1;
end

current_max_it = 1000000000;
relaxation_factor = 1;
for i = 1 : 19
    relaxation_factor_test = i / 10;
    [gauss_seidel_x iter_count] = gauss_seidel_solve(t, r, d, B, seed, 1e-2, relaxation_factor_test);
    iter_count_vector(i, 1) = relaxation_factor_test;
    iter_count_vector(i, 2) = iter_count;

    if(current_max_it > iter_count)
        current_max_it = iter_count;
        relaxation_factor = relaxation_factor_test;
    end
end

format short
printf("relaxation factors | iteration count for 1e-2:\n\t");
iter_count_vector

printf("chose relaxation factor:\n\t");
relaxation_factor
format long

% c2). Determine a solução S={xi} do sistema acima, pelo método iterativo de Gauss-Seidel, com critério de parada Max|Dxi|<=1.10-4
% (Dx = diferenças entre variáveis novas e antigas), e uso o valor otimizado do fator de relaxação obtido acima.
% Imprima somente a 1º e última incógnitas e o resíduo máximo. Use um algoritmo otimizado, que não realize cálculos com lugares vazios na matriz,
% senão o método de Gauss-Seidel não vale a pena;

[gauss_seidel_x iter_count float_ops] = gauss_seidel_solve(t, r, d, B, seed, 1e-4, relaxation_factor);

printf("X(1) solved by gauss seidel:\n\t");
gauss_seidel_x(1)

printf("X(40) solved by gauss seidel:\n\t");
gauss_seidel_x(n)

printf("Residuo maximo by gauss seidel:\n\t");
residuo_max = max(abs(gauss_seidel_x * A - B))

% c3). Imprima o número de iterações e o número total de operações em PONTO FLUTUANTE utilizadas;

printf("Solved gauss seidel in steps:\n\t");
iter_count

printf("Float operations gauss seidel:\n\t");
float_ops_gauss_seidel = float_ops

% c4). Imprima o erro de Truncamento máximo na solução S obtida acima, em variavel ‘double’ para isolar o efeitos dos arredondamentos.
% Lembre-se que o erro de Truncamento máximo pode ser obtido com  Max|xi(aproximado,double,criterio)-xi(aproximado,double,criterio2)|.

gauss_seidel_x_double = gauss_seidel_solve(t, r, d, B, seed, 1e-8, relaxation_factor);

printf("Truncamento entre criterio de parada 1e-4 e 1e-8 :\n\t");
erro_de_truncamento = max(abs(gauss_seidel_x - gauss_seidel_x_double))

% d). Imprima, no final, o número de operações em PONTO FLUTUANTE utilizadas em cada um dos 3 métodos e indique o melhor método utilizado.
printf("Float operations:\n\t");
float_ops_lu_croat
printf("\t");
float_ops_gauss_tridiagonal
printf("\t");
float_ops_gauss_seidel
printf("O melhor metodo para resolver o problema é o Gauss optimizado para matrix tridiagonal!\n");
