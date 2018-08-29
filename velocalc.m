function yvelo = velocalc(fileName, start, duration)
[sensorData, header] = rawP5reader({fileName});
acceldat = sensorData.data;
gyrodat = sensorData(2).data;
n = duration;
entries = (start:start+n-1)';
%'

gyrodat = gyrodat.*(2*pi)./(360);

omega = 1/header.baseFrequency;
%set up vectors to track the following
tau = gyrodat(entries, 1);
kappa = gyrodat(entries, 3);
globalVelo = zeros(n, 3);
globalSpeed = 0;
globalAcc = [0 9.81 0];
localAcc = zeros(n, 3);

for i = 1:n
localAcc(i, 1) = acceldat(start+i-1, 1);
localAcc(i, 2) = acceldat(start+i-1, 2);
localAcc(i, 3) = acceldat(start+i-1, 3);
end

localAcc = localAcc.*9.81;

T = [0 1 0];
N = [1 0 0];
B = [0 0 1];

%set initial

for i = 2:n
globalVelo(i:n:2*n+i) = globalVelo(i-1:n:2*n+i-1) + omega.*globalAcc;
globalSpeed = norm(globalVelo(i:n:2*n+i));

prevN = N;
N = N + omega*globalSpeed*(-kappa(i-1)*T+tau(i-1)*B);
T = T + omega*globalSpeed*kappa(i-1)*prevN;
B = B - omega*globalSpeed*tau(i-1)*prevN;

globalAcc = inv([T; N; B;])*(localAcc(i:n:2*n+i)');
globalAcc = globalAcc';
end

yvelo = globalVelo
