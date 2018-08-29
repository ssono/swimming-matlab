function saveAcc(time, data, stroke, sensor, swimmer, date, dist, fast)

duration = length(data);
entries = (1:duration)';
%'

xdat = data(entries, 1);
ydat = data(entries, 2);
zdat = data(entries, 3);


options = fitoptions('smoothingspline');
options.SmoothingParam = .99;
xfit = fit(time, xdat, 'smoothingspline', options);
yfit = fit(time, ydat, 'smoothingspline', options);
zfit = fit(time, zdat, 'smoothingspline', options);

ymag = 60;
if sensor == 'SA'
ymag = 30;
end

speed = "slow";
if fast
speed = "fast";
end

name = strcat(swimmer, {' '} ,sensor, {' '}, speed, string(dist), stroke);

hold on
axis([0, time(end), -ymag, ymag]);
title(name);
x = plot(xfit);
set(x, 'Color', [0.4 0.6, 0.8]);
y = plot(yfit);
set(y, 'Color', 'black');
z = plot(zfit);
set(z, 'Color', [0 0.8 0.3]);

xlabel("seconds (s)");
ylabel("acceleration m/s^2");

legend({'x', 'y', 'z'},'Location','northeast');
hold off

name = strcat(swimmer, '_', sensor, '_',speed, string(dist), stroke);
fname = strcat('~/Dropbox/SwimmingStudy/Daily_Notes/', date, '/images/acc/', name, '.jpg');
saveas(gcf, fname);
close(gcf);
