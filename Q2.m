% 2c)
range = 1.6 + 0.2*[1:4];
for n = range
    f2 = @(t, pos)fun(t, pos, n);
    [t, pos] = ode45(f2,[0 8],[0 457.2 -deg2rad(25)]);
    
    p = plot(pos(:,1),pos(:,2));
    hold on
end
yline(300,'k--')
text(20,310,'Altitude de obstáculos')
yline(457.2,'k--')
text(20,467.2,'Altitude operacional')
ylim([200,500])
legs = [string("n = " + range) '' ''];
legend(legs,"Location","best")
ylabel("Altura")
xlabel("Distância")
title("Trajetória crítica de acordo com o fator de carga")
hold off

% 2d)
for n = linspace(2,2.2,1000)
    f2 = @(t, pos)fun(t, pos, n);
    [t, pos] = ode45(f2,[0 8],[0 457.2 -deg2rad(25)]);
    if abs(min(pos(:,2)) - 300) < 0.01
        n
    end
end

% Funções utilizadas
function pos_P = fun(~, pos, n)
    g = 9.8; v = 138.9;
    gamma = pos(3);
    pos_P = [v.*cos(gamma) v.*sin(gamma) g*(n-cos(gamma))/v]';
end

