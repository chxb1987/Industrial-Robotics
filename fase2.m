function[theta1, theta2]= fase2(x, y, t1anterior, t2anterior)
% Mmove o efetuador terminal para a posi��o (x,y), 
% movendo os dois Links ao mesmo tempo com a mesma velocidade.

        verificar(x,y);
    oldobj = instrfind;     %elimina resquicios presentes na porta serial
     if not(isempty(oldobj))
         fclose(oldobj);
         delete(oldobj);
     end
 
    s1 = serial('COM3','BaudRate',9600);   %cria objeto serial
     fopen(s1);
     pause(3);
     [theta1, theta2] = CinInv2(x,y); % obtem as vari�veis de junta 
     t1 = theta1;
     t2 = theta2;
     pontos = 50    %numero de posi�oes intermediarias entre o angulo inicical e final
     distancia1 = abs(t1 - t1anterior);   
     distancia2 = abs(t2 - t2anterior);
     velocidade = max(distancia1, distancia2)/pontos;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
    cont = max(distancia1, distancia2);

       %trajeto1 crescente ou descrescente
       if t1anterior <t1                    % se o angulo final � maior que o angulo inicial
           trajetoria1 = [t1anterior:velocidade:t1]; % pontos intermediarios para traj crescente
       else
           trajetoria1 = [t1anterior:-velocidade:t1]; % pontos intermediarios para traj decrescente
       end
       %traj2 crescente ou decrescente
       if t2anterior >t2
           trajetoria2 = [t2anterior:-velocidade:t2];
       else
           trajetoria2 = [t2anterior:velocidade:t2];
       end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       comp = abs(length(trajetoria1)-length(trajetoria2)); 
    % diferen�a entre a maior e a menor trajet�ria
    
   if distancia1<distancia2 % complementa a menor trajet�ria para que fiquem ambas do mesmo tamanho
       trajetoria1(end: end+comp) = t1;
   else
       trajetoria2(end: end+comp) = t2;
   end

   %envia as posi�oes angulares aos servomotores
for i =1:length(trajetoria1)
    fwrite(s1,1);
    pause(0.025);

    fwrite(s1,trajetoria1(i));
    pause(0.025);

    fwrite(s1,trajetoria2(i));
    pause(0.025);
end
fclose(s1);
end
    
