function swim = saveData(fileName, start, duration, fourierstart, fourierdur, dist, stroke, dive, swimmer, date, sensor)

%Save data snippet as structure
%Example saveData('1LF848.BIN', 470000, 12800, 473436, 1721, 50, 'Free', true, 'Oliver', '06_22', 'SA')

[sensorData, header] = rawP5reader({fileName});

accelData = sensorData.data;
gyroData = sensorData(2).data;
snippet = [start:start+duration];
fftSnippet = [fourierstart:fourierstart+fourierdur];


swim = struct;
swim.accData = accelData(snippet, 1:3);
swim.gyrData = gyroData(snippet, 1:3);
swim.dive = dive;
swim.dist = dist;
swim.stroke = stroke;
swim.swimmer = swimmer;
swim.date = date;
swim.accFftData = accelData(fftSnippet, 1:3);
swim.gyrFftData = gyroData(fftSnippet, 1:3);
swim.sensor = sensor;


jswim = jsonencode(swim);

fname = strcat('~/Dropbox/SwimmingStudy/Database/', string(dist), '/', stroke, '/', sensor, '-', swimmer, '-', date, '.json');
fid = fopen(fname, 'w');

if fid == -1
edit(fname);
fid = fopen(fname, 'w');
end
fwrite(fid, jswim, 'char');
fclose(fid);
