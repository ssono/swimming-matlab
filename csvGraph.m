function csvGraph(sensor, full, cycle, dist, stroke, dive, swimmer, date, fast)

allData = csvread(full, 7, 0);
duration = length(allData);

accData = allData(1:duration, 5:7);
accData = accData.*9.81;
gyrData = allData(1:duration, 2:4);
time = allData(1:duration, 1);
time = time - time(1);

swim = csvSwim(sensor, accData, gyrData, dist, stroke, dive, swimmer, date, fast);

cycleData = csvread(cycle, 7, 0);
cycleDuration = length(cycleData);

cycaccData = cycleData(1:cycleDuration, 5:7);
cycaccData = cycaccData.*9.81;
cycgyrData = cycleData(1:cycleDuration, 2:4);
cyctime = cycleData(1:cycleDuration, 1);
cyctime = time - time(1);

if sensor == 'SA'
cycaccData(1:cycleDuration, 1) = cycaccData(1:cycleDuration, 2) .* -1;
cycaccData(1:cycleDuration, 3) = cycaccData(1:cycleDuration, 3) .* -1;
end

cycle = csvCycle(sensor, cycaccData, cycgyrData, dist, stroke, dive, swimmer, date, fast);

csvAcc(time, accData, stroke, sensor, swimmer, date, dist, fast);

csvFourier(cycaccData(1:cycleDuration, 2), stroke, sensor, swimmer, date, 512, 'Y', fast);
if sensor ~= 'SA'
csvFourier(cycaccData(1:cycleDuration, 1), stroke, sensor, swimmer, date, 512, 'X', fast);
csvFourier(cycaccData(1:cycleDuration, 3), stroke, sensor, swimmer, date, 512, 'Z', fast);
end

csvGraphCyc(cycaccData, stroke, sensor, swimmer, date, 512, fast);
