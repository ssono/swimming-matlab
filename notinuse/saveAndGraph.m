function saveAndGraph(fileName, start, swimend, fourierstart, fourierend, dist, stroke, dive, swimmer, date, sensor)

[sensorData, header] = rawP5reader({fileName});

freq = header.baseFrequency
rawdur = swimend-start;
rawdur = rawdur * freq;
rawfdur = fourierend-fourierstart;
rawfdur = rawfdur * freq;

start = int64(freq*start);
duration = int64(rawdur);
fourierstart = int64(freq*fourierstart);
fourierdur = int64(rawfdur)

swim = saveData(fileName, start, duration, fourierstart, fourierdur, dist, stroke, dive, swimmer, date, sensor);


fftd = length(swim.accFftData);
fftduration = (1:fftd)';
%'

saveFourier(swim.accFftData(fftduration, 2), stroke, sensor, swimmer, date, freq, 'Y');
if sensor ~= 'SA'
saveFourier(swim.accFftData(fftduration, 1), stroke, sensor, swimmer, date, freq, 'X');
saveFourier(swim.accFftData(fftduration, 3), stroke, sensor, swimmer, date, freq, 'Z');
end

d = length(swim.accData);
duration = (1:d)';
%'

saveAcc(swim.accData(duration, 1:3), stroke, sensor, swimmer, date, freq, dist);
close(gcf);
saveCycles(swim.accFftData, stroke, sensor, swimmer, date, freq, dist);
