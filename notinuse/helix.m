points = 10000;

%local x
Tacc = zeros(points, 1);
%local y
Nacc = zeros(points, 1);
%local z
Bacc = zeros(points, 1);
tgyr = zeros(points, 1);
ngyr = zeros(points, 1);
bgyr = zeros(points, 1);

%scalar projection a onto b = dot(a, b)/norm(b)
%
for n = 1:points
a = [3*sin((n-1)/256) 0 3*cos((n-1)/256)];
T = [-0.6*sin((n-1)/256) 0.8 0.6*cos((n-1)/256)];
N = [-cos((n-1)/256)*2^(-0.5) 0 -sin((n-1)/256)*2^(-0.5)];
B = [0.8*sin((n-1)/256)*2^(-0.5) -0.6*2^(-0.5) -0.8*cos((n-1)/256)*2^(-0.5)];
Tacc(n) = dot(a, T)/norm(T);
Nacc(n) = dot(a, N)/norm(N);
Bacc(n) = dot(a, B)/norm(B);
tgyr(n) = 0.6*2^(-0.5);
ngyr(n) = 0;
bgyr(n) = 0.8;
end

time = (1:points)';
time = (time-1)./128;

tangDisplacement = cumtrapz(time, tgyr);
nangDisplacement = cumtrapz(time, ngyr);
bangDisplacement = cumtrapz(time, bgyr);

initAcc = zeros(points, 3);

for i = 1:points
%angular displacement at that point in time
t = tangDisplacement(i);
n = nangDisplacement(i);
b = bangDisplacement(i);

rotMatrix = zeros(3);
%rows of the rotation matrix;
rotMatrix(1:3:7) = [cos(n)*cos(b) sin(t)*sin(n)*cos(b)-cos(t)*sin(b) cos(t)*sin(n)*cos(b)+sin(t)*sin(b)];
rotMatrix(2:3:8) = [cos(n)*sin(b) sin(t)*sin(n)*sin(b)+cos(t)*cos(b) cos(t)*sin(n)*sin(b)-sin(t)*cos(b)];
rotMatrix(3:3:9) = [-sin(n) sin(t)*cos(n) cos(t)*cos(n)];



initAcc(i:points:2*points+i) = [Tacc(i) Nacc(i) Bacc(i)] * rotMatrix;
end

globalAcc = zeros(points, 3);
initToGlobal = zeros(3);


%initial fram axes
T0 = [-0.6*sin(0) 0.8 0.6*cos(0)];
N0 = [-cos(0)*2^(-0.5) 0 -sin(0)*2^(-0.5)];
B0 = [0.8*sin(0)*2^(-0.5) -0.6*2^(-0.5) -0.8*cos(0)*2^(-0.5)];

%angle between initial frame and global
%  0 -.8 .6
%  0  .6 .8
% -1   0  0
xt = acos(dot([1 0 0], T0)/norm(T0));
yn = acos(dot([0 1 0], N0)/norm(N0));
zb = acos(dot([0 0 1], B0)/norm(B0));

initToGlobal(1:3:7) = [cos(yn)*cos(zb) sin(xt)*sin(yn)*cos(zb)-cos(xt)*sin(zb) cos(xt)*sin(yn)*cos(zb)+sin(xt)*sin(zb)];
initToGlobal(2:3:8) = [cos(yn)*sin(zb) sin(xt)*sin(yn)*sin(zb)+cos(xt)*cos(zb) cos(xt)*sin(yn)*sin(zb)-sin(xt)*cos(zb)];
initToGlobal(3:3:9) = [-sin(yn) sin(xt)*cos(yn) cos(xt)*cos(yn)];


globalAcc = initAcc * initToGlobal;

yacc = globalAcc(1:points, 2);
velo = cumtrapz(time, yacc);

hold on
plot(time, Tacc, 'green');
plot(time, Nacc, 'red');
plot(time, Bacc, 'cyan');
plot(time, velo, 'black');
hold off
