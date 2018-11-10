function basic(sensor, snip, t)

allData = csvread(snip, 7, 0);
duration = length(allData);

accData = allData(1:duration, 5:7);
accData = accData.*9.81;

entries = (1:duration)';
%'
time = (entries-1)./512;

xdat = accData(entries, 1);
ydat = accData(entries, 2);
zdat = accData(entries, 3);

options = fitoptions('smoothingspline');
options.SmoothingParam = .05;
time = time.*(100/time(length(time)));
xfit = fit(time, xdat, 'smoothingspline', options);
yfit = fit(time, ydat, 'smoothingspline', options);
zfit = fit(time, zdat, 'smoothingspline', options);
ymag = 60;
if sensor == 'SA'
ymag = 30;
end


hold on
axis([0, 100, -ymag, ymag]);
title(t);
x = plot(xfit);
set(x, 'Color', [1 0 0]);
y = plot(yfit);
set(y, 'Color', 'black');
z = plot(zfit);
set(z, 'Color', [0 0 1]);

ylabel("acceleration m/s^2");
legend({'x', 'y', 'z'},'Location','northeast');
%legend({'y'}, 'Location', 'northeast');
hold off
fname = strcat('~/pullouts/', t, '.jpeg')
saveas(gcf, fname);
close(gcf);
