% Initialization
close all
clear
clc
% Load parameters
load('uas_parameters.mat');
load('uas_thrust_constants.mat');
load('hoop_pos.mat');
% p1 = 11.8;
% p2 = -11.6;

% Trajectory generation
% HOOP POSITION
start = [0; -2; 0.3];
end_ = [0; -2; 0];
offset1 = [0.11; 0; 0.08];
offset2 = [0.0155; -0.06; 0.06];
offset3 = [0; -0.01; 0.07];
offset4 = [-0.04; -0.06; 0.08];

% TIME
% knots = [0 3 8 13 18 23];
knots = [0 5 10 15 20 25 30];

% WAYPOINT
waypoints = cell(1,6);
waypoints{1} = start;
waypoints{2} = p_h1 + offset1;
waypoints{3} = p_h2 + offset2;
waypoints{4} = p_h3 + offset3;
waypoints{5} = p_h4 + offset4;
waypoints{6} = end_;

% Fix this...
offset = [0; 0; 0.07];
order = 10;
% corridors.times = [4.5 9.5 14.5 19.5 24.5 28.5];
corridors.times = [2.5 7.5 12.5 17.5 22.5 24];
corr_1 = [1.8; -0.5; 1.33] + offset;
corr_2 = [-1.4; -0.5; 1.33] + offset;
corr_3 = [-1.4; -3.7; 1.2] + offset;
corr_4 = [1.8; -3.7; 1.25] + offset;
corr_5 = corr_1;
corr_6 = [0; -2; 1] + offset;

delta = 0.3;
corridors.x_lower = [corr_1(1) corr_2(1) corr_3(1) corr_4(1) corr_5(1) corr_6(1)] - delta;
corridors.x_upper = [corr_1(1) corr_2(1) corr_3(1) corr_4(1) corr_5(1) corr_6(1)] + delta;
corridors.y_lower = [corr_1(2) corr_2(2) corr_3(2) corr_4(2) corr_5(2) corr_6(2)] - delta;
corridors.y_upper = [corr_1(2) corr_2(2) corr_3(2) corr_4(2) corr_5(2) corr_6(2)] + delta;
corridors.z_lower = [corr_1(3) corr_2(3) corr_3(3) corr_4(3) corr_5(3) corr_6(3)] - delta;
corridors.z_upper = [corr_1(3) corr_2(3) corr_3(3) corr_4(3) corr_5(3) corr_6(3)] + delta;

% ...until here
make_plots = 1;
poly_traj = uas_minimum_snap(knots, order, waypoints, corridors, make_plots);