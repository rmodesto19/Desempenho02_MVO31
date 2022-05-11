% 2c)
v = 138.9;
launch_angle = 25*pi/180;
theta = linspace(launch_angle,0,100);

for n = [3.3 3 2.7 2.4]
    r_theta = r(theta,v,n);

    x = r_theta.*sin(theta);
    y = r(0,v,n) - r_theta.*cos(theta)+300;

    plot(x,y)
    hold on
end

lim_y = max(y)*1.05;
lim_x = max(x)*1.05;
axis equal
yline(300,'k--')
text(0.65*lim_x,300+lim_y*0.03,'Altitude de obstáculos')
yline(457.2,'k--')
text(0.02*lim_x,457.2+lim_y*0.03,'Altitude operacional')
legend("n = 3.3", "n = 3", "n = 2.7", ...
    "n = 2.4", "","",...
    'Location','best')
ylabel('Altitude (m)')
xlabel('Posição (m)')
title('Trajetórias críticas de acordo com o fator de carga')

hold off

% 2d)
for n = linspace(2.7,3,30000)
    if abs(r(0,v,n) - r(launch_angle,v,n)*cos(launch_angle)+300-457.2) < 0.001
        n_max = n
    end
end

% Funções utilizadas
function radius = r(angle,vel,n_z)
    g = 9.81;
    radius = vel^2./(g*(n_z-cos(angle)));
end
