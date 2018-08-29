function fourierVis(fileName, start, duration, name)
[sensorData, header] = rawP5reader({fileName});
accelData = sensorData.data;

xdat = accelData(start:start+duration-1, 1);
ydat = accelData(start:start+duration-1, 2);
zdat = accelData(start:start+duration-1, 3);

fx = fft(xdat);
fx = abs(fx/duration);
fx = fx(1:duration/2);

fy = fft(ydat);
fy = abs(fy/duration);
fy = fy(1:duration/2);

fz = fft(zdat);
fz = abs(fz/duration);
fz = fz(1:duration/2);

freq = (1:duration/2)/header.baseFrequency;

hold on
axis([0 0.2 0 1])
%plot(freq, fx, 'r');
%plot(freq, fy, 'g');
plot(freq, fz, 'b');
%legend({'fx'},'Location','northeast');
%legend({'fy'},'Location','northeast');
legend({'fz'},'Location','northeast');
title(name);
hold off
