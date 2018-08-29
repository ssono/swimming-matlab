function newGraph(fileName, start, duration, ymag, gname)

%Everything is in seconds
[sensorData, header] = rawP5reader({fileName});
accelData = sensorData.data;

time = (start:start+duration)';
%'
entries = (start:start+duration);
xdat = accelData(start:start+duration, 1);
ydat = accelData(start:start+duration, 2);
zdat = accelData(start:start+duration, 3);

%time = time./ header.baseFrequency;
xdat = xdat.*9.81;
ydat = ydat.*9.81;
zdat = zdat.*9.81;

%yvelo = velocalc(fileName, start, duration);
%yvelo;

options = fitoptions('smoothingspline');
options.SmoothingParam = .001;
%.005 for a 50
%.01 for a snap
xfit = fit(time, xdat, 'smoothingspline', options);
yfit = fit(time, ydat, 'smoothingspline', options);
zfit = fit(time, zdat, 'smoothingspline', options);

hold on
axis([start, start+duration, -ymag, ymag]);
title(gname);
x = plot(xfit);
set(x, 'Color', [0.4 0.6, 0.8]);
y = plot(yfit);
set(y, 'Color', 'black');
z = plot(zfit);
set(z, 'Color', [0 0.8 0.3]);

xlabel("seconds from start");
ylabel("acceleration (m/s^2)");
% v = plot(time(1:duration), yvelo(1:duration, 1));
% set(v, 'Color', 'red');
% v = plot(time(1:duration), yvelo(1:duration, 2));
% set(v, 'Color', 'cyan');
% v = plot(time(1:duration), yvelo(1:duration, 3));
% set(v, 'Color', 'yellow');


%total = plot(start:start+duration, totalacc(start:start+duration), 'r');
legend({'x', 'y', 'z'},'Location','northeast');
hold off
