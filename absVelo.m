function v = absVelo(acceldat, gyrodat, zero)
%acceldat = sensorData.data
%gyro = sensorData(2).data
%zero = zero point
entries = (zero: length(acceldat))';
time = entries ./ 128;

xacc = acceldat(entries, 1);
yacc = acceldat(entries, 2);
zacc = acceldat(entries, 3);

xgyr = gyrodat(entries, 1);
ygyr = gyrodat(entries, 2);
zgyr = gyrodat(entries, 3);


xangDisplacement = cumtrapz(xgyr);
yangDisplacement = cumtrapz(ygyr);
zangDisplacement = cumtrapz(zgyr);
