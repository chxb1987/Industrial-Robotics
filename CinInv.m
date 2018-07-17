function[a1, a2] = CinInv(x,y);
    L1 = 99;
    L2 = 100;
    denoD2 = 2*L1*L2;
    numD2 = ((x^2) + (y^2) - (L1^2) - (L2^2));
    
    d2pos = acosd(numD2/denoD2);
    d2neg = 360 - d2pos;
    
    denoD1pos = x*(L1+L2*cosd(d2pos)) + y*(L2)*sind(d2pos);
    if(denoD1pos ~= 0)%nao entra num ponto de singularidade
        numD1pos = y*(L1+L2*cosd(d2pos)) - x*(L2)*sind(d2pos);
        d1pos = atand(numD1pos/denoD1pos);
    end
    
    denoD1neg = x*(L1+L2*cosd(d2neg)) + y*(L2)*sind(d2neg);    
    if(denoD1neg ~= 0)
        numD1neg = y*(L1+L2*cosd(d2neg)) - x*(L2)*sind(d2neg);
        d1neg = atand(numD1neg/denoD1neg);
    end

    d1 = round(d1neg + 5);% o motor 1 tem seu 0 a -5 graus por motivos mecanicos do servo.
    d2 = round(d2neg + 90+20);%90 pois o motor 2 está a 90 graus de diferença do motor 1
                             % e 20 pois o motor 2 está, alem dos 90 graus,
                             % mais 20 graus de diferença por escolha de
                             % nao deixar o grau 0 sobrepor a junta do
                             % ombro.
    v1 = round(d1pos + 5);
    v2 = round(d2pos + 90+20);
    
    D1 = d1;
    D2 = d2;
    V1 = v1;
    V2 = v2;
    
    
    OffsetD2V2 = 50; %Valores a serem somados nas variaveis de 
    OffsetD1V1 = -5; %junta dada a folga e erros 
                     %aleatorios no sistema.
                     % Devem ser ajustados a cada montagem, mas ficam por
                     % volta desses valores, D2V2 = 45 e D1V1 = -2
    d1 = D1 + OffsetD1V1;
    D1 = d1;
    d2 = D2 + OffsetD2V2;
    D2 = d2;
    v1 = V1 + OffsetD1V1;
    V1 = v1;
    v2 = V2 + OffsetD2V2;
    V2 = v2;
    
    %condicoes angulares, trata valores maiores que 360 e menores que 0
    if (d1<0)
        D1 = d1 + 180;  %POR QUE 180????? d1 é calculado com a tang, e com
                        %nao usamos o 4o quadrante dos eixos xy, se o
                        %angulo gerado for negativo, ele tem um
                        %correspondente no 2o quadrante cuja tangente é a
                        %mesma.
    else if (d1 > 360)
            D1 = d1 - 360;% se o ang for maior que 360, é a mesma coisa que
                          % ele mesmo menos 360, a diferença é que o servo
                          % talvez possa ir em tal angulo
        end
    end
    
    if (d2<0)
        D2 = d2 + 180;
    else if (d2 > 360)
            D2 = d2 - 360;
        end
    end
    
    if (v1<0)
        V1 = v1 + 180;
    else if (v1 > 360)
            V1 = v1 - 360;
        end
    end
    
    if (v2<0)
        V2 = v2 + 180;
    else if (v2 > 360)
            V2 = v2 - 360;
        end
    end
    
    D1; %Mostra os valores pra debug mesmo
    D2;
    V1;
    V2;
    a1 = D1;
    a2 = D2;
    %fase0(D1,D2,90,90);
   % fase0(V1,V2,90,90);% essa função quase nunca eh chamada por limitacoes 
                        %mecanicas do servo, assim as duas solucoes
                        %cinematicas se resumem em grande parte na primeira
                        %chamada de funcao.
    
    
   
    %FALTA FAZER: Escolher entre a soluçao D1 D2 e V1 V2
                % Analisar singularidades, por exemplo P(200, 0)
                % 
end
