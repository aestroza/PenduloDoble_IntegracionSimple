%% Elegir el sistema a simular (los largos se eligen en Pendulo_doble.m)
h = 0.0001;
T = 6;
[t,r1x,r1y,r2x,r2y,d,m1,m2,l1,l2,H] = Pendulo_Doble(h,T,1,1.5);

%% Jugar con esto y ver las variables en el Workspace hasta obtener lo deseado
n = ceil(T/h);
fps = 60;
framespara50fps = fps*T ;
j=zeros(1,framespara50fps);
for k = 0 : framespara50fps-1 %no muestra el ultimo frame equivalente a tiempo T
    index = k*(2/(100*h)) + 1;
    j(k+1) = t(index) ;
    t_k = j(k+1);
end
j