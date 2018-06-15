[sensorData, header] = rawP5reader({'2LF848.BIN'});
acc = sensorData.data;
t = (1:length(acc))';
time = t ./ 128;
ydat = acc(t, 2);
ydat = ydat - 0.07;
options = fitoptions('smoothingspline');
options.SmoothingParam = 0.999
yfit = fit(time, ydat, 'smoothingspline', options);


%plot(time, ydat);
plot(yfit);

int = integrate(yfit, time, 1/128);
plot(time, int);

