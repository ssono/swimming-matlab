sensor = 'SA'

d1 = readData('cycle', 'Free', 'fast', sensor, 'Muir', '06_27');
d2 = readData('cycle', 'Free', 'fast', sensor, 'AWeir', '06_28');
d3 = readData('cycle', 'Free', 'fast', sensor, 'burchill', '07_11');
d4 = readData('cycle', 'Free', 'fast', sensor, 'raab', '07_11');
d5 = readData('cycle', 'Free', 'fast', sensor, 'smoliga', '07_11');
% d6 = readData('cycle', 'Free', 'fast', sensor, 'Bemiller', '07_11');
% d7 = readData('cycle', 'Free', 'fast', sensor, 'Koski', '07_11');
% d8 = readData('cycle', 'Free', 'fast', sensor, 'Murphy', '07_11');

d1x = d1.accData(1:end,1);
d1y = d1.accData(1:end,2);
d1z = d1.accData(1:end,3);

d2x = d2.accData(1:end,1);
d2y = d2.accData(1:end,2);
d2z = d2.accData(1:end,3);

d3x = d3.accData(1:end,1);
d3y = d3.accData(1:end,2);
d3z = d3.accData(1:end,3);

d4x = d4.accData(1:end,1);
d4y = d4.accData(1:end,2);
d4z = d4.accData(1:end,3);

d5x = d5.accData(1:end,1);
d5y = d5.accData(1:end,2);
d5z = d5.accData(1:end,3);

% d6x = d6.accData(1:end,1);
% d6y = d6.accData(1:end,2);
% d6z = d6.accData(1:end,3);
% 
% d7x = d7.accData(1:end,1);
% d7y = d7.accData(1:end,2);
% d7z = d7.accData(1:end,3);
% 
% d8x = d8.accData(1:end,1);
% d8y = d8.accData(1:end,2);
% d8z = d8.accData(1:end,3);

options = fitoptions('smoothingspline');
options.SmoothingParam = 0.2;


dur = linspace(0,100,length(d1.accData));
d1xfit = fit(dur',d1x,'smoothingspline',options);
d1yfit = fit(dur',d1y,'smoothingspline',options);
d1zfit = fit(dur',d1z,'smoothingspline',options);

dur = linspace(0,100,length(d2.accData));
d2xfit = fit(dur',d2x,'smoothingspline',options);
d2yfit = fit(dur',d2y,'smoothingspline',options);
d2zfit = fit(dur',d2z,'smoothingspline',options);

dur = linspace(0,100,length(d3.accData));
d3xfit = fit(dur',d3x,'smoothingspline',options);
d3yfit = fit(dur',d3y,'smoothingspline',options);
d3zfit = fit(dur',d3z,'smoothingspline',options);

dur = linspace(0,100,length(d4.accData));
d4xfit = fit(dur',d4x,'smoothingspline',options);
d4yfit = fit(dur',d4y,'smoothingspline',options);
d4zfit = fit(dur',d4z,'smoothingspline',options);

dur = linspace(0,100,length(d5.accData));
d5xfit = fit(dur',d5x,'smoothingspline',options);
d5yfit = fit(dur',d5y,'smoothingspline',options);
d5zfit = fit(dur',d5z,'smoothingspline',options);

% dur = linspace(0,100,length(d6.accData));
% d6xfit = fit(dur',d6x,'smoothingspline',options);
% d6yfit = fit(dur',d6y,'smoothingspline',options);
% d6zfit = fit(dur',d6z,'smoothingspline',options);
% 
% dur = linspace(0,100,length(d7.accData));
% d7xfit = fit(dur',d7x,'smoothingspline',options);
% d7yfit = fit(dur',d7y,'smoothingspline',options);
% d7zfit = fit(dur',d7z,'smoothingspline',options);
% 
% dur = linspace(0,100,length(d8.accData));
% d8xfit = fit(dur',d8x,'smoothingspline',options);
% d8yfit = fit(dur',d8y,'smoothingspline',options);
% d8zfit = fit(dur',d8z,'smoothingspline',options);

% dx = [d1xfit(linspace(0,100,2000)); d2xfit(linspace(0,100,2000)); d3xfit(linspace(0,100,2000)); d4xfit(linspace(0,100,2000)); d5xfit(linspace(0,100,2000)); d6xfit(linspace(0,100,2000)); d7xfit(linspace(0,100,2000)); d8xfit(linspace(0,100,2000))];
% dy = [d1yfit(linspace(0,100,2000)); d2yfit(linspace(0,100,2000)); d3yfit(linspace(0,100,2000)); d4yfit(linspace(0,100,2000)); d5yfit(linspace(0,100,2000)); d6yfit(linspace(0,100,2000)); d7yfit(linspace(0,100,2000)); d8yfit(linspace(0,100,2000))];
% dz = [d1zfit(linspace(0,100,2000)); d2zfit(linspace(0,100,2000)); d3zfit(linspace(0,100,2000)); d4zfit(linspace(0,100,2000)); d5zfit(linspace(0,100,2000)); d6zfit(linspace(0,100,2000)); d7zfit(linspace(0,100,2000)); d8zfit(linspace(0,100,2000))];
% 
% dur = linspace(0,100,2000);
% dur = [dur dur dur dur dur dur dur dur];


dx = [d2xfit(linspace(0,100,2000)); d3xfit(linspace(0,100,2000)); d4xfit(linspace(0,100,2000)); d5xfit(linspace(0,100,2000))];
dy = [d2yfit(linspace(0,100,2000)); d3yfit(linspace(0,100,2000)); d4yfit(linspace(0,100,2000)); d5yfit(linspace(0,100,2000))];
dz = [d2zfit(linspace(0,100,2000)); d3zfit(linspace(0,100,2000)); d4zfit(linspace(0,100,2000)); d5zfit(linspace(0,100,2000))];

dur = linspace(0,100,2000);
dur = [dur dur dur dur];
options.SmoothingParam = 0.99;
x = fit(dur', dx, 'smoothingspline', options);
y = fit(dur', dy, 'smoothingspline', options);
z = fit(dur', dz, 'smoothingspline', options);

hold on
axis([0 100 -25 25]);
% %plot(d1xfit, 'r');
% plot(d2xfit, 'r');
% plot(d3xfit, 'r');
% plot(d4xfit, 'r');
% plot(d5xfit, 'r');
% % plot(d6xfit, 'r');
% % plot(d7xfit, 'r');
% % plot(d8xfit, 'r');
% 
% %plot(d1yfit, 'g');
% plot(d2yfit, 'g');
% plot(d3yfit, 'g');
% plot(d4yfit, 'g');
% plot(d5yfit, 'g');
% % plot(d6yfit, 'g');
% % plot(d7yfit, 'g');
% % plot(d8yfit, 'g');
% 
% %plot(d1zfit, 'b');
% plot(d2zfit, 'b');
% plot(d3zfit, 'b');
% plot(d4zfit, 'b');
% plot(d5zfit, 'b');
% % plot(d6zfit, 'b');
% % plot(d7zfit, 'b');
% % plot(d8zfit, 'b');

x = plot(x, 'r');
y = plot(y, 'g');
z = plot(z, 'b');
title('SA all');
legend({'x', 'y', 'z'},'Location','northeast');
hold off
