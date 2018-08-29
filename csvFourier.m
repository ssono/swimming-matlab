function csvFourier(data, stroke, sensor, swimmer, date, freq, orientation, fast)


duration = length(data);
f = fft(data);
f = abs(f/duration);
f = f(1:duration/2);
hz = freq*(1:duration/2)/duration;

ax = [0 25 0 6];

%set correct axis. SA has lower magnitude
if sensor == 'SA'
ax = [0 25 0 1.5];
end

%set color x = red, y=green, z=blue
color = 'r';
if orientation == 'y' || orientation == 'Y'
color = 'g';
elseif orientation == 'z' || orientation == 'Z'
color = 'b';
end

speed = "slow";
if fast
speed = "fast";
end

name = strcat(swimmer, {' '}, sensor, {' '}, speed, stroke, {' '}, orientation)

hold on
xlabel('Hz');
ylabel('magnitude');
axis(ax);
plot(hz, f, color);
title(name);
hold off

name = strcat(swimmer, '_', sensor, '_', speed, '_', stroke, '_', orientation)
fname = strcat('~/Dropbox/SwimmingStudy/Daily_Notes/', date, '/images/fft/', name, '.jpg');
saveas(gcf, fname);
close(gcf);
