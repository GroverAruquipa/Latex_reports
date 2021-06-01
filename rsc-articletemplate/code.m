clear all; close all; clc;

%% Parameters of EC and DC motors from maxon motor Co.
% A-max 22 ?22 mm, Graphite Brushes, 6 Watt
% EC 90 flat ?90 mm, brushless, 260 Watt
Ra = 14; % Terminal resistance 
La = 0.891; % Terminal inductance mH
Ke = 17.1e-3; % invers of Speed constant v/rad/s
Km = Ke; % Torque constant Nm/A
J = 4.13e-7; % Rotor inertia kgm^2 
Ta = La/Ra; % Mechanical time constant s
Tm = J*Ra/(Ke*Km); % Mechanical time constant s
%% Transfer function
DC_Motor = tf([1/Ke], [Tm*Ta Tm 1])
%% graphs
% Frequency characteristics
figure(1);
nyquist(DC_Motor);
figure(2);
bode(DC_Motor,{10, 1000}); 
grid on;
 % Step responses
figure(3);
Tend = 0.2;
step(DC_Motor, Tend); 
grid on;
figure(4);
impulse(DC_Motor, Tend); 
grid on;
