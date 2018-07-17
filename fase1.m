function[theta1, theta2]= fase1(x, y, t1anterior, t2anterior)
%fase 1
% Nesta etapa programa move o efetuador terminal para posição (x,y)
% acionando um link e depois o outro.
    verificar(x,y);
    oldobj = instrfind;     %elimina resquicios presentes na porta serial
     if not(isempty(oldobj))
         fclose(oldobj);
         delete(oldobj);
     end
 
    s1 = serial('COM3','BaudRate',9600);   %cria objeto serial
     fopen(s1);
     pause(3);
     
    [theta1, theta2] = CinInv(x,y); % obtem os angulos
    t1 = theta1;
    t2 = theta2;
    pontos1 = abs(t1 - t1anterior)/1.5; % determina a quantidade de posiçoes intermediárias
    pontos2 = abs(t2 - t2anterior)/1.5;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
    trajetoria1 = linspace(t1anterior, t1, pontos1); % obtem os pontos entre o anglo inicial e final
    trajetoria2 = linspace(t2anterior, t2, pontos2);
 
for i =1:pontos1  % envia as posiçoes ao ombro, mantendo a junta na posiçao inicial
    fwrite(s1,1);
    pause(0.025);

    fwrite(s1,trajetoria1(i));
    pause(0.025);

    fwrite(s1,t2anterior);
    pause(0.025);
end
for i =1:pontos2  % envia as posiçoes a junta, mantendo o ombro em sua posiçao final
    fwrite(s1,1);
    pause(0.025);

    fwrite(s1,t1);
    pause(0.025);

    fwrite(s1,trajetoria2(i));
    pause(0.025);
end
fclose(s1);
end
    
