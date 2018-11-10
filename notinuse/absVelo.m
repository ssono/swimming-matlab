function absoluteVelo = absVelo(fileName, start, duration)
%zero = zero point


[sensorData, header] = rawP5reader({fileName});
acceldat = sensorData.data;
gyrodat = sensorData(2).data;
entries = (start: start+duration)';
time = entries ./ 128;
duration = duration(1) +1;

%get xyz acceleration data
xacc = acceldat(entries, 1);
yacc = acceldat(entries, 2);
zacc = acceldat(entries, 3);

%get xyz angular velocity
xgyr = gyrodat(entries, 1);
ygyr = gyrodat(entries, 2);
zgyr = gyrodat(entries, 3);

%using trapezoidal integration, get xyz angular displacement
xangDisplacement = cumtrapz(time, xgyr);
yangDisplacement = cumtrapz(time, ygyr);
zangDisplacement = cumtrapz(time, zgyr);


%initiate varible to store rotation quaternion vectors
quats = quaternion(zeros(duration, 4));
totalDisplacement = zeros(duration, 1);

for n = 1:duration
xyzdis = [xangDisplacement(n) yangDisplacement(n) zangDisplacement(n)];

totalDisplacement(n) = norm(xyzdis);
rotAxis = normalize(xyzdis);

newQuat = quaternion(cos(totalDisplacement(n)/2), rotAxis(1)*sin(totalDisplacement(n)/2), rotAxis(2)*sin(totalDisplacement(n)/2), rotAxis(3)*sin(totalDisplacement(n)/2));
quats(n) = newQuat;
end

globalAcc = zeros(duration, 3);

for n = 1:duration
%local acceleration as a quaternion
accQuat = quaternion(0, xacc(n), yacc(n), zacc(n));
%rotational quaternion
rotQuat = quats(n);
quatAsAcc = compact(rotQuat*accQuat*conj(rotQuat));
quatAsAcc = quatAsAcc(2:4);
globalAcc(n:duration:2*duration+n) = quatAsAcc;
end

yprojections = zeros(duration, 1);

%array of yprojections
for n = 1:duration
%mag = norm(globalAcc(n:duration:2*duration+n));
%projy = mag*cos(totalDisplacement(n));
yprojections(n) = globalAcc(n, 2);
end

yprojections(1) = 0;
absoluteVelo = cumtrapz(time, yprojections);
