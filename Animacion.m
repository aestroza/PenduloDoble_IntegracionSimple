clear
clc
%% Paso 1: Generar los datos a Graficar/Animar
%elegir los parámetros 
h = 1e-05; 
T = 5;
masa1 = 1;
masa2 = 1.5;
[t,r1x,r1y,r2x,r2y,d,m1,m2,l1,l2,H] = Pendulo_Doble(h,T,masa1,masa2);
n = ceil(T/h);
%cálculo de cuantas imágenes será necesario para tener 50 imágenes por segundo
framespara50fps = 50*T ;
j=zeros(1,framespara50fps);

%% Paso 2: Crear el Esceneario
%Los limites de la figura los elegí de forma que la figura mostrada en mi
%computador (1080p 24") fuera lo mas cuadrada posible, de forma que al
%graficar al pendulo sus brazos no se deformaran por tener una escena descuadrada
Escena = figure('InnerPosition',[0 0 1135 1080]);
for k = 0 : framespara50fps-1
    %Limpiar la figura para comenzar cada iteración con una figura en blanco
    clf
    
    %Obtener el indice correcto para conseguir 50 imagenes por segundo
    %busca el indice que tiene la informacion de pasos de tiempo en saltos
    %de 0.02, esto se ve viendo el vector j, sirve para todo T y h
    index = round(k*(2/(100*h)) + 1);
    
    %Extraer los datos del paso adecuado
    j(k+1) = t(index) ;
    t_k = j(k+1);
    r1x_index = r1x(index);
    r1y_index = r1y(index);
    r2x_index = r2x(index);
    r2y_index = r2y(index);
    H_index = H(index);
    
    %Graficar el pendulo doble
    plot([0 r1x_index],[0 r1y_index],'lineWidth',1.5) % linea desde el origen a la masa 1
    hold on
    plot([r1x_index r2x_index],[r1y_index r2y_index],'lineWidth',1.5) % linea masa 1 el origen a masa 2
    plot(r1x_index, r1y_index, 'g.', 'LineWidth', 3, 'MarkerSize', 90*m1) % masa 1
    plot(r2x_index, r2y_index, 'g.', 'LineWidth', 3, 'MarkerSize', 90*m2) % masa 2
    
    %Añadir informacion al plot
    grid on
    xlabel('x')
    ylabel('y')
    title(['t = ',num2str(t_k),' s ',' Paso = ',num2str(h),' s ', ' Energía = ', num2str(H_index), ' J'])
    axis([-d d -d d])
    
    %% Paso 3
    StuctPelicula(k+1) = getframe(Escena, [0 0 1135 1080]);  
end

%% Paso 5: Guardar la Pelicula
%Crear un Objeto VideoWriter y Escribir el nombre con que se guardará el .avi
myWriter = VideoWriter(['PenduloDoble  Paso = ',num2str(h), ' masa1 = ',num2str(m1),'  masa2 =', num2str(m2)]);            %create an .avi file

%Opcional: cambiar a mp4, creo que daba problemas
% myWriter = VideoWriter(['PenduloDoble  Paso = ',num2str(h)],'MPEG-4'); 

%Elegir los
myWriter.FrameRate = 50;

%Abrir el objeto VideoWriter, escribir la pelicula, y cerrar el archivo.
open(myWriter);
writeVideo(myWriter, StuctPelicula);
close(myWriter);
disp('Listo!')