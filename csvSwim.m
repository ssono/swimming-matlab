function swim = csvSwim(sensor, accData, gyrData, dist, stroke, dive, swimmer, date, fast)

swim = struct;
swim.accData = accData;
swim.gyrData = gyrData;
swim.dive = dive;
swim.dist = dist;
swim.stroke = stroke;
swim.swimmer = swimmer;
swim.date = date;
swim.sensor = sensor;
swim.isFast = fast;

jswim = jsonencode(swim);
speed = "slow";
if fast
speed = "fast";
end
fname = strcat('~/Dropbox/SwimmingStudy/Database/', string(dist), '/', stroke, '/', speed, '-', sensor, '-', swimmer, '-', date, '.json');
fid = fopen(fname, 'w');

if fid == -1
edit(fname);
fid = fopen(fname, 'w');
end
fwrite(fid, jswim, 'char');
fclose(fid);
