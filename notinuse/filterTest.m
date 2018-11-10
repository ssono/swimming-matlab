function filterTest(dist, stroke, sensor, swimmer, date, freq)

swim = readData(dist, stroke, sensor, swimmer, date);
data = swim.accFftData;
duration = length(data);
entries = (1:duration)';
%'
time = (entries-1)./freq

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%SPLINE FITS
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

ymag = 50;
if sensor == 'SA'
ymag = 30;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%FOURIER

fx = fft(xdat);
fy = fft(ydat);
fz = fft(zdat);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%FILTERS
newfx = zeros(length(fx), 1);
newfx(1:10) = fx(1:10);
fx = newfx;
newfy = zeros(length(fy), 1);
newfy(1:10) = fy(1:10);
fy = newfy;
newfz = zeros(length(fz), 1);
newfz(1:10) = fz(1:10);
fz = newfz;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INVERSE FFT
ifx = ifft(fx);
ify = ifft(fy);
ifz = ifft(fz);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%GRAPH IT
name = strcat(swimmer, {' '} ,sensor, {' '}, string(dist), stroke);

hold on
axis([0,(duration-1)/freq, -ymag, ymag]);
x = plot(xfit);
set(x, 'Color', [0.4 0.6, 0.8]);
y = plot(yfit);
set(y, 'Color', 'black');
z = plot(zfit);
set(z, 'Color', [0 0.8 0.3]);
title(strcat([name ' spline']));
xlabel("seconds (s)");
ylabel("acceleration m/s^2");
legend({'x', 'y', 'z'},'Location','northeast');
hold off


figure
hold on
axis([0, (duration-1)/freq, -ymag, ymag]);
ix = plot(time, ifx);
set(ix, 'Color', [0.4 0.6, 0.8]);
iy = plot(time, ify);
set(iy, 'Color', 'black');
iz = plot(time, ifz);
set(iz, 'Color', [0 0.8 0.3]);
xlabel("seconds (s)");
ylabel("acceleration m/s^2");
legend({'ix', 'iy', 'iz'},'Location','northeast');
title(strcat([name ' filter']));
hold off
