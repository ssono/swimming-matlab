function swim = readData(dist, stroke, speed, sensor, swimmer, date)


fname = strcat('~/Dropbox/SwimmingStudy/Database/', string(dist), '/', stroke, '/', speed, '-', sensor, '-', swimmer, '-', date, '.json')
fid = fopen(fname);
if fid == -1, error("file does not exist");end
raw = fread(fid, inf);
str = char(raw');
%'
fclose(fid);
data = jsondecode(str);
swim = data;
