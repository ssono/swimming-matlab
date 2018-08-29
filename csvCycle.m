function cycle = csvCycle(sensor, accData, gyrData, dist, stroke, dive, swimmer, date, fast)

cycle = struct;
cycle.accData = accData;
cycle.gyrData = gyrData;
cycle.dive = dive;
cycle.dist = dist;
cycle.stroke = stroke;
cycle.swimmer = swimmer;
cycle.date = date;
cycle.sensor = sensor;
cycle.isFast = fast;

jcyc = jsonencode(cycle);
speed = "slow";
if fast
speed = "fast";
end
fname = strcat('~/Dropbox/SwimmingStudy/Database/cycle/', stroke, '/', speed, '-', sensor, '-', swimmer, '-', date, '.json');
fid = fopen(fname, 'w');

if fid == -1
edit(fname);
fid = fopen(fname, 'w');
end
fwrite(fid, jcyc, 'char');
fclose(fid);
