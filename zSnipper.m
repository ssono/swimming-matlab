function xSnipper(start, stop, filename, newfilename, sensor)

% Takes beginning and endpoints of graph
% Takes filename for full swim and desired name for snip file
% Takes sensor as a two length string

%if start and stop are within 1-total number of points it will graph whole
%swim. Otherwise, it will graph your selection.
%After the graph you will be asked if you want to save the new file.
%Example call: snipper(8000, 00, 'alons_LH_fast_full.csv', 'alons_LH_fast_snip.csv', 'LH');

allData = csvread(filename, 7, 0);
size(allData)
duration = length(allData);
accData = allData(1:duration, 5:7);
gyrData = allData(1:duration, 2:4);
time = allData(1:duration, 1);
time = time - time(1);



if ((start >= 1 && start <= duration) && (stop >= 1 && stop <= duration))
  skip = 1;
  if stop - start >= 5000
    skip = ceil((stop-start)/5000);
  end
  points = (start:skip:stop)';%'
  accData = accData(start:skip:stop, 1:3);
  gyrData = allData(start:skip:stop, 1:3);
  length(points)
  length(accData)
else
  skip = 1;
  if duration >= 5000
    skip = ceil(duration/5000)
  end
  start = 1;
  stop = duration;
  points = (1:skip:duration)';%'
  accData = accData(start:skip:stop, 1:3);
  gyrData = allData(start:skip:stop, 1:3);
end
displayedPoints = strcat('start: ', string(start), ', end: ', string(stop), ' out of ', string(duration))


xdat = accData(1:length(accData), 1);
ydat = accData(1:length(accData), 2);
zdat = accData(1:length(accData), 3);



options = fitoptions('smoothingspline');
options.SmoothingParam = .1/length(points);
zfit = fit(points, zdat, 'smoothingspline', options);


ymag = 6;
ymin = -6;
if sensor == 'SA'
ymag = .4;
ymin = -.4;
end


figure, clf
grid on
grid minor
axis([start stop ymin ymag]);
hold on
title(displayedPoints);
z = plot(zfit);
set(z, 'Color', [0 0 1]);
zero = plot(points, zeros(1,length(points)));
set(zero, 'Color', 'black');

hold off
legend({'z', 'zero'},'Location','northeast');


saving = input('would you like to save this as a csv file? (y/n)\n', 's');

if saving == 'y' || saving == 'Y'
newLength = stop + 1 - start;
newCsv = zeros(newLength,7);
newCsv(1:newLength,1:7) = allData(start:stop, 1:7);
homeDir = which(filename);
pathToDir = strsplit(homeDir, '/');
pathToDir = pathToDir(1:length(pathToDir)-1);
pathToDir(length(pathToDir)+1) = {newfilename};
newPath = strjoin(pathToDir, '/');
csvwrite(newPath, newCsv, 7 ,0);
end
