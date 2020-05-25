%% Elegir el sistema a simular (los largos se eligen en Pendulo_doble.m)
h = 1e-05; 
T = 5;
masa1 = 1;
masa2 = 1.5;
[t,r1x,r1y,r2x,r2y,d,m1,m2,l1,l2,H] = Pendulo_Doble(h,T,masa1,masa2);
n = ceil(T/h);

%% Graficar todos los puntos obtenidos
H_0 = H(1);
H_f = H(n+1);
plot(r1x,r1y,'lineWidth',1.5)
hold on
plot(r2x,r2y,'lineWidth',1.5)
axis([-d d -d d])

title(['Trayectoria',' para T = ',num2str(T),' s',', con un paso de h = ', num2str(h),' s'])
txt = {['Energía inicial = ', num2str(H_0),],['Energía final = ', num2str(H_f)]};
text(-d+0.2,d-0.4,txt)
xlabel('x [m]')
ylabel('y [m]')
legend([' Masa 1 = ',num2str(m1),' kg'],[' Masa 2 = ',num2str(m2),' kg'])
