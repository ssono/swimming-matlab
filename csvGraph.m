function csvGraph(sensor, full, cycle, dist, stroke, dive, swimmer, date, fast)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pulls data out of csv and formats a time vector to go with it. FUll swim
allData = csvread(full, 7, 0);
duration = length(allData);
accData = allData(1:duration, 5:7);
accData = accData.*9.81;
gyrData = allData(1:duration, 2:4);
time = allData(1:duration, 1);
time = time - time(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%flips z on all and x on left
%if sensor == 'SA'
%accData(1:duration,3) = accData(1:duration,3) - 19.62
%end
%if sensor == 'LH'
%accData(1:duration, 1) = accData(1:duration,1) .* -1
%end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Saves into database
swim = csvSwim(sensor, accData, gyrData, dist, stroke, dive, swimmer, date, fast);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%reads cycle data, makes time vector for cycle data
 cycleData = csvread(cycle, 7, 0);
 cycleDuration = length(cycleData);

 cycaccData = cycleData(1:cycleDuration, 5:7);
 cycaccData = cycaccData.*9.81;
 cycgyrData = cycleData(1:cycleDuration, 2:4);
 cyctime = cycleData(1:cycleDuration, 1);
 cyctime = time - time(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%flips direction of z on all and x on left
%if sensor == 'SA'
%cycaccData(1:cycleDuration,3) = cycaccdata(1:cycleDuration,3) - 19.62
%end
%if sensor == 'LH'
%cycaccData(1:cycleDuration, 1) = cycaccData(1:cycleDuration,1) .* -1
%end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%saves cycle to database
cycle = csvCycle(sensor, cycaccData, cycgyrData, dist, stroke, dive, swimmer, date, fast);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 csvAcc(time, accData, stroke, sensor, swimmer, date, dist, fast);

 csvFourier(cycaccData(1:cycleDuration, 2), stroke, sensor, swimmer, date, 512, 'Y', fast);
 if sensor ~= 'SA'
 csvFourier(cycaccData(1:cycleDuration, 1), stroke, sensor, swimmer, date, 512, 'X', fast);
 csvFourier(cycaccData(1:cycleDuration, 3), stroke, sensor, swimmer, date, 512, 'Z', fast);
 end

 csvGraphCyc(cycaccData, stroke, sensor, swimmer, date, 512, fast);
