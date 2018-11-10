function saveCycles(data, stroke, sensor, swimmer, date, freq, dist)

duration = length(data);
entries = (1:duration)';
%'
time = (entries-1)./freq;

xdat = data(entries, 1);
ydat = data(entries, 2);
zdat = data(entries, 3);

xdat = xdat.*9.81;
ydat = ydat.*9.81;
zdat = zdat.*9.81;

options = fitoptions('smoothingspline');
options.SmoothingParam = .99;
xfit = fit(time, xdat, 'smoothingspline', options);
yfit = fit(time, ydat, 'smoothingspline', options);
zfit = fit(time, zdat, 'smoothingspline', options);

ymag = 80;
if sensor == 'SA'
ymag = 30;
end

gname = strcat(swimmer, {' '} ,sensor, {' '}, string(dist), stroke, {' '}, 'Cycles');

hold on
axis([0, duration/freq, -ymag, ymag]);
title(gname);
x = plot(xfit);
set(x, 'Color', [0.4 0.6, 0.8]);
y = plot(yfit);
set(y, 'Color', 'black');
z = plot(zfit);
set(z, 'Color', [0 0.8 0.3]);

ylabel("acceleration m/s^2");

legend({'x', 'y', 'z'},'Location','northeast');
hold off

name = strcat(swimmer, '_', sensor, '_', string(dist), stroke, '_cycles');
fname = strcat('~/Dropbox/SwimmingStudy/Daily_Notes/', date, '/images/acc/', name, '.jpg');
saveas(gcf, fname);
close(gcf);

options = fitoptions('smoothingspline');
options.SmoothingParam = .05;
time = time.*(100/time(length(time)));
xfit = fit(time, xdat, 'smoothingspline', options);
yfit = fit(time, ydat, 'smoothingspline', options);
zfit = fit(time, zdat, 'smoothingspline', options);

gname = strcat(swimmer, {' '} ,sensor, {' '}, string(dist), stroke, {' '}, 'normalized cycles');

hold on
axis([0, 100, -ymag, ymag]);
title(gname);
x = plot(xfit);
set(x, 'Color', [0.4 0.6, 0.8]);
y = plot(yfit);
set(y, 'Color', 'black');
z = plot(zfit);
set(z, 'Color', [0 0.8 0.3]);

ylabel("acceleration m/s^2");

legend({'x', 'y', 'z'},'Location','northeast');
hold off

name = strcat(swimmer, '_', sensor, '_', string(dist), stroke, '_normcycles');
fname = strcat('~/Dropbox/SwimmingStudy/Daily_Notes/', date, '/images/acc/', name, '.jpg');
saveas(gcf, fname);
