function [t,r1x,r1y,r2x,r2y,d,m1,m2,l1,l2,H]=Pendulo_Doble(h,T,m1,m2)
n = ceil(T/h);
g = 9.8;
l1 = 1.3;
l2 = 1.1;
d = 1.1*(l1+l2);

% x: angulo, w: velocidad angular o x punto

f1 = @(x1,x2,w1,w2) -(m1.*g.*sin(x1) + m2.*sin(x1-x2).*(g*cos(x2)+l1*cos(x1-x2)*w1^2+l2*w2^2)) / (l1*(m1 + sin(x1-x2)^2*m2));
f2 = @(x1,x2,w1,w2)  sin(x1-x2)*(m1*(g*cos(x1)+l1*w1^2) + m2*(g*cos(x1)+l1*w1^2+cos(x1-x2)*l2*w2^2) ) / (l2*(m1 + sin(x1-x2)^2*m2));

%% Crear Vectores para PreAlocar Memoria
%Posiciones de masas cartesianas
r1x = zeros(n+1,1);
r1y = zeros(n+1,1);
r2x = zeros(n+1,1);
r2y = zeros(n+1,1);

%Energías
K = zeros(n+1,1);
V = zeros(n+1,1);
H = zeros(n+1,1);

%Tiempo y Posiciones de masas coordenadas naturales (angulos x's) y velocidades angulares (w's)
t  = zeros(n+1,1);
x1 = zeros(n+1,1);
x2 = zeros(n+1,1);
w1 = zeros(n+1,1);
w2 = zeros(n+1,1);

%% Elegir Condiciones Iniciales
x1_0 = 1.8*pi/2;
x2_0 = 1.2*pi/2;
w1_0 = 0;
w2_0 = 1;
x1(1) = x1_0;
x2(1) = x2_0;
w1(1) = w1_0;
w2(1) = w2_0;

%% Integracion simple
for i=1:n+1
   
    %calculo de coordenadas naturales
    if i<=n
        w1(i+1) = w1(i) + h*f1(x1(i),x2(i),w1(i),w2(i));
        w2(i+1) = w2(i) + h*f2(x1(i),x2(i),w1(i),w2(i));
        x1(i+1) = x1(i) + h*w1(i);
        x2(i+1) = x2(i) + h*w2(i);
    end
    
    %Calculo del tiempo asociado a esta iteración
    t(i) = h*(i-1);
    
    %Transformación a coodrdenadas cartesianas para despues graficar con plot
    r1x(i) = l1*sin(x1(i)) ;
    r1y(i) = -l1*cos(x1(i)) ;
    r2x(i) = r1x(i) + l2*sin(x2(i)) ;
    r2y(i) = r1y(i) - l2*cos(x2(i)) ;
    
    %Calculo de Energía como forma de ver el error cometido
    K(i) = 0.5*(m1+m2)*(l1^2)*(w1(i)^2) + 0.5*(m2)*(l2^2)*(w2(i)^2) + (m2)*(l1*l2)*(cos(x1(i)-x2(i)))*(w1(i))*(w2(i)) ;
    V(i) = - (m1+m2)*(g)*(l1)*(cos(x1(i))) - (m2)*(g)*(l2)*(cos(x2(i))) ;
    H(i) = K(i) + V(i) ; 
    
end
