function run()
angles = -85:1:0;
Velocity = 18360 * 1000 / 60 / 60;
MaxTemp = zeros(1,length(angles));
MaxAcc = zeros(1,length(angles));
Vf = zeros(1,length(angles));
dX = zeros(1,length(angles));
C_T = 1;
C_A = 1;
C_Vf = 1;
C_x = 1;

for i = 1:length(angles)
    disp([angles(i)]);
    [MaxTemp(i), MaxAcc(i),Vf(i),dX(i)] = BaseScript(angles(i),Velocity,0);
    MaxTemp(i) = C_T * MaxTemp(i);
    MaxAcc(i) = C_A * MaxAcc(i);
    Vf(i) = C_Vf * Vf(i);
    dX(i) = C_x * dX(i);
end

hold on
plot(angles, MaxTemp);
xlabel('Angle from Horizontal (degrees)');
ylabel('Max Temperature (degrees Celcius)');
title('Temperature');


p = polyfit(angles,MaxTemp,15);
nTemp = polyval(p,angles);
plot(angles, nTemp);

figure()
hold on
plot(angles,MaxAcc, 'b');
xlabel('Angle from Horizontal (degrees)');
ylabel('Max Acceleration (m/s^2)');
title('Acceleration');

w = polyfit(angles,MaxAcc,15);
nAcc = polyval(w,angles);
plot(angles, nAcc,'r');
figure()

plot(angles,Vf);
xlabel('Angle from Horizontal (degrees)');
ylabel('Velocity at Parachute Opening (m/s)');
title('Final Velocity');
figure()

plot(angles,dX);
xlabel('Angle from Horizontal (degrees)');
ylabel('horizontal Displacement (m)');
title('horizontalDisplacement');
figure()

hold on
quantity = MaxTemp.*MaxAcc.*Vf.*dX;
plot(angles, quantity,'b');
plot(angles, nTemp.*nAcc.*Vf.*dX,'r');

title('Product Plot')
xlabel('Angle from Horizontal (degrees)');
end