function[a] = verificar (x, y)
% Verifica a possibilidade de alcan�ar o ponto solicitado pelo usu�rio
x = -100;
y = 120;

if((y>0)&&(-199*x < x^2 + y^2)&&(x^2+y^2 <39601)&&(x^2+y^2>2025))
    %%esta dentro dos volume de trabalho
else
error(message('O ponto solicitado est� fora do volume de trabalho'));
end
%end
