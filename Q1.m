% 1a)
h = 10000; % Altere o valor da altura desejada
[rho,P,T] = atmosferaISA(h);
rho, P, T

% 1b)
h = 11000; % Altere o valor da altura desejada
dT = 0; % Altere o valor da temperatura desejada
[rho,P,T] = atmosferaISA(h,dT);
rho, P, T

% Gráficos 1b)
x = linspace(0, 20000, 2000);
rho1 = zeros(2000,1);
P1 = zeros(2000,1);
T1 = zeros(2000,1);
for i = 1:2000
    [rho1(i),P1(i),T1(i)] = atmosferaISA(x(i),dT);
end
plot(x,rho1,'b')
hold on
plot([0, h],[rho, rho],'k--')
plot([h, h],[0, rho],'k--')
plot(h,rho, 'r.', 'MarkerSize', 20)
title('Density (kg/m3) v. Altitude (m)')
ylabel('Density (kg/m3)')
xlabel('Altitude (m)')
hold off

figure()

plot(x,P1,'b')
hold on
plot([0, h],[P, P],'k--')
plot([h, h],[0, P],'k--')
plot(h,P, 'r.', 'MarkerSize', 20)
title('Pressure (Pa) v. Altitude (m)')
ylabel('Pressure (Pa)')
xlabel('Altitude (m)')
hold off

figure()

%  1c)
p = 101325; % Altere o valor da pressão desejada
Zp = altitudePressao(p);
Zp

% 1d)
p = 101325; % Altere o valor da pressão desejada
p0 = 101325; % Altere o valor da pressão desejada
Zp = altitudePressao(p,p0);
Zp

% Gráficos 1d)
x = linspace(1e3,101325,1000);
y = linspace(1e3,90000,1000);
Zp1 = zeros(1000,1);
Zp2 = zeros(1000,1);
for i = 1:1000
    [Zp1(i)] = altitudePressao(x(i),101325);
    [Zp2(i)] = altitudePressao(y(i),90000);
end
plot(x,Zp1,'r','LineWidth',1)
xlabel('Pressure (Pa)')
ylabel('Altitude (m)')
title('Altitude (m) v. Pressure (Pa)')
hold on
plot(y,Zp2,'b','LineWidth',1)
legend('p0 = 101325 Pa', 'p0 = 90000 Pa')
hold off

% Funções utilizadas
function [dens, press, temp] = atmosferaISA(height, varargin)
    if nargin < 2
        dT = 0;
    else
        dT = varargin{1};
    end
    T0 = 288.15 + dT;

    P0 = 101325;
    M = 0.02897;
    R = 8.314;
    L = -0.0065;
    g = 9.81;

    if height <= 11000
        temp = T0 + L*height;
        press = P0 * (temp/T0).^(-g*M/(R*L));
    elseif height <= 20000
        temp = T0 + L*11000;
        press = P0 * (temp/T0).^(-g*M/(R*L));
        press = press * exp(-g*M*(height-11000)/(R*temp));
    else
        temp = nan;
        press = nan;
    end

    dens = (press*M)/(R*temp);
end

function [h] = altitudePressao(p, varargin)
    if nargin < 2
        p0 = 101325;
    else
        p0 = varargin{1};
    end

    T0 = 288.15;
    M = 0.02897;
    R = 8.314;
    L = -0.0065;
    g = 9.81;

    [~,p1,~] = atmosferaISA(11000);
    [~,p2,~] = atmosferaISA(20000);
    if p > p1
        h = T0/L*((p0/p)^(R*L/(g*M))-1);
    elseif p > p2
        T0 = 216.65;
        h = log(p1*p0/(p*101325)) * R*T0/(M*g)+11000;
    else
        h = nan;
    end
end