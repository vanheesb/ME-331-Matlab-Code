clc;
clear;
alpha= 60;
g=9.8; %m/s^2
DN= 0.15; % Meters
Rho_a= 1.225; %Density kg/m^3
Rho_f=810;
K= 0.2*DN^2*Rho_a;
Area= pi*(DN^2)/4;
%Start with initial Velocity
Vi=16.5; % m/s
Mdot=Area*Rho_f*Vi;
Vx(1)=Vi*cosd(alpha);
Vy(1)=Vi*sind(alpha);
tinc=0.001; %time increment
t=0:tinc:3.21; %.1 second increments
SZ=length(t); %Length Array
X=[0];
Y=[5];
M=1; %Kg Tracking the system fro one small kg
nu_p = 0.80; % effeciency of the pump

for countx=1:(SZ-1)     %%%%    Force      delta T
    Vx(countx+1)=Vx(countx)-(((K*Vx(countx).^2)*tinc)/M);
end

for county=1:(SZ-1)
     if Vy>0 %depending on the direction of forces of drag
        Vy(county+1)=Vy(county)-g*tinc-(((K*Vy(county).^2)*tinc)/M);
     else
         Vy(county+1)=Vy(county)-g*tinc+(((K*Vy(county).^2)*tinc)/M);   
     end
end



for incx=1:(SZ-1)
    X(incx+1)=X(incx)+tinc*Vx(incx);
end

for incy=1:(SZ-1)
    Y(incy+1)=Y(incy)+tinc*Vy(incy);
end

%Real Solution
RY= .5*-g*t.^2+Vi*sind(alpha)*t+5;
RX= Vi*cosd(alpha)*t;
plot(RX,RY,'r');
hold on
plot(X,Y,'b');
legend('No Drag',' With Drag');
title('Drag Vs. No Drag for D_N = 15 cm');
xlabel(' Distance (m)');
ylabel('Height (m)');




%% property calculations
W_p = (Mdot*g*15)/nu_p;
p_m = W_p/Mdot;

