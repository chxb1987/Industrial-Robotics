function[theta1, theta2]= fase3(x, y, t1anterior, t2anterior)
% O efetuador alcança a posição (x,y) movendo os dois links ao mesmo tempo, 
% com velocidades proporcionais terminando o movimento juntos.

    verificar(x,y);
    oldobj = instrfind;     %elimina resquicios presentes na porta serial
     if not(isempty(oldobj))
         fclose(oldobj);
         delete(oldobj);
     end
 
    s1 = serial('COM3','BaudRate',9600);   %cria objeto serial
     fopen(s1);
     pause(3);
     [theta1, theta2] = CinInv2(x,y); % obtem as variaveis de juntas
     t1 = theta1;
     t2 = theta2;
     pontos = abs(t1 - t1anterior);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
        trajetoria1 = linspace(t1anterior, t1, pontos); % gera os pontos intermediarios entre o angulo inicial e final
        trajetoria2 = linspace(t2anterior, t2, pontos);
 
    % envia as posiçoes angulares aos servomotores
for i =1:pontos
    fwrite(s1,1);
    pause(0.025);

    fwrite(s1,trajetoria1(i));
    pause(0.025);

    fwrite(s1,trajetoria2(i));
    pause(0.025);
end
fclose(s1);
end
    
