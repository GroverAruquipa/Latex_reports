    % INTELLIGENT SYSTEMS LABORATORY 1
clear all 
close all
clc
% Parameters from the model
Ra=10
Ta=0.01
Ke=0.05
Km=Ke
% j=var
%% Case 1
J=0.5E-5
Tm=J*Ra/(Ke*Km)% 1
% Transfer function
DC_motor=tf([1/Ke],[Tm*Ta Tm 1])
figure(1);
nyquist(DC_motor);hold on;
figure(2);
bode(DC_motor,{1, 10000}); grid on; hold on;
Tend= 0.2;
figure(3);
step(DC_motor, Tend); grid on; hold on;
figure(4)
impulse(DC_motor, Tend); grid on; hold on;

%% Case 2
J=0.25E-5
Tm=J*Ra/(Ke*Km)% 1
% Transfer function
DC_motor=tf([1/Ke],[Tm*Ta Tm 1])
figure(1);
nyquist(DC_motor);hold on;
figure(2);
bode(DC_motor,{1, 10000}); grid on; hold on;
Tend= 0.2;
figure(3);
step(DC_motor, Tend); grid on; hold on;
figure(4)
impulse(DC_motor, Tend); grid on; hold on;
%% Case3
J=1.0E-5
Tm=J*Ra/(Ke*Km)% 1
% Transfer function
DC_motor=tf([1/Ke],[Tm*Ta Tm 1])
figure(1);
nyquist(DC_motor);hold on;
legend('J1','J2','J3')
figure(2);
bode(DC_motor,{1, 10000}); grid on; hold on;
Tend= 0.2;
legend('J1','J2','J3')
figure(3);
step(DC_motor, Tend); grid on; hold on;
legend('J1','J2','J3')
figure(4)
impulse(DC_motor, Tend); grid on; hold on;
legend('J1','J2','J3')

%% Fuzzy controller
figure()
step=0.01
e= 0:step:50
slow=trapmf(e, [-18.75 -2.083 2.083 18.75])
righ=trimf(e, [4.167 25 45.83])
high=trapmf(e,  [31.25 47.92 52.08 68.75])
 plot(e,slow,e, righ, e, high, 'LineWidth', 5)
set(gca,'FontSize',18)
legend('slow','righ','high')
xlabel('Velocity'), ylabel('\mu(Error)')
title('Semantic error from velocity')
grid on
%%
% semantic action control
figure()
v= 0:step:5

down=trapmf(v,  [-1.875 -0.2083 0.2083 1.875])
nc=trimf(v,  [0.4167 2.5 4.583])
up=trapmf(v,   [3.125 4.792 5.208 6.875])
 plot(v,down,v,nc, v, up, 'LineWidth', 5)
set(gca,'FontSize',18)
legend('Down','NC','UP')
xlabel('Voltage'), ylabel('\mu(Error)')
title('Semantic error to the action control')
grid on
%%
figure
e0=9 % error read
n=find(e==e0);

plot(e0,slow(n),'*',e0, righ(n),'*', e0, high(n),'*')
% Fuzfification
B1=min(up,slow(n))

B2=min(nc,righ(n))

B3=min(down,high(n))

B=max(B1,max(B2,B3))
figure()
plot(v,B,'LineWidth',5)
% Defuzzification
vo=defuzz(v,B,'centroid')
%figure()
hold on
grid on
title('Control curve')
xlabel('Voltage')
ylabel('Velocity')
plot(vo*ones(1,3),[0 0.5 1], 'r', 'LineWidth',5)

%%
controller
fig = get_param('controller','Handle');
saveas(fig,'controller','png');

%%
clear all; close all; clc;
%%
% CASE MOTOR 1
% EC90-110149
Ra1 = 9.09; % Terminal resistance 
La1 = 0.585; % Terminal inductance mH
Ke1 = 13.9e-3; % invers of Speed constant v/rad/s
Km1 = Ke1; % Torque constant Nm/A
J1 = 4.2e-7; % Rotor inertia kgm^2 
Ta1 = La1/Ra1; % Mechanical time constant s
Tm1 = J1*Ra1/(Ke1*Km1); % Mechanical time constant s
%%

%% Parameters of EC and DC motors from maxon motor Co.
% A-max 22 ?22 mm, Graphite Brushes, 6 Watt
% EC 90 flat ?90 mm, brushless, 260 Watt EC90-110150
Ra2 = 14; % Terminal resistance 
La2 = 0.891; % Terminal inductance mH
Ke2 = 17.1e-3; % invers of Speed constant v/rad/s
Km2 = Ke2; % Torque constant Nm/A
J2 = 4.13e-7; % Rotor inertia kgm^2 
Ta2 = La2/Ra2; % Mechanical time constant s
Tm2 = J2*Ra2/(Ke2*Km2); % Mechanical time constant s

%%
% CASE MOTOR 3
% EC90-110152
Ra3 = 33.3; % Terminal resistance 
La3 = 2.1; % Terminal inductance mH
Ke3 = 26.2e-3; % invers of Speed constant v/rad/s
Km3 = Ke3; % Torque constant Nm/A
J3 = 4.09e-7; % Rotor inertia kgm^2 
Ta3 = La3/Ra3; % Mechanical time constant s
Tm3 = J3*Ra3/(Ke3*Km3); % Mechanical time constant s

%%
DC_Motor1 = tf([1/Ke1], [Tm1*Ta1 Tm1 1])
DC_Motor2 = tf([1/Ke2], [Tm2*Ta2 Tm2 1])
DC_Motor3 = tf([1/Ke3], [Tm3*Ta3 Tm3 1])

%% graphs
% Frequency characteristics
figure('Name','Nyquist-graph');
title('Nyquist graph')
nyquist(DC_Motor1);
hold on 
nyquist(DC_Motor2);
nyquist(DC_Motor3);
legend('EC90-110149', 'EC90-110150','EC90-110152')
figure('Name','Bode-graph');
title('Bode graph')
bode(DC_Motor1,{10, 1000});
hold on
bode(DC_Motor2,{10, 1000});
bode(DC_Motor3,{10, 1000});
legend('EC90-110149', 'EC90-110150', 'EC90-110152')

grid on;
 % Step responses
figure('Name','Step-Response');
Tend = 0.7;
title('Step Response')
step(DC_Motor1, Tend); 
hold on
step(DC_Motor2, Tend); 
step(DC_Motor3, Tend); 
legend('EC90-110149', 'EC90-110150', 'EC90-110152')

grid on;
figure('Name','Impulse-response');
title('Impulse response')
impulse(DC_Motor1, Tend);
hold on
impulse(DC_Motor2, Tend);
impulse(DC_Motor3, Tend);
legend('EC90-110149', 'EC90-110150', 'EC90-110152')

grid on;




















