function [ obst, l, s, t ] = obstacle1( )
% obst = [lower phi, upper phi, lower theta, upper theta]

s = [3*pi/16, 0];
t = [2.5*pi/16, 2*pi/4];
% t = [0.4299, 1.8140];
l = 1.8;

k = pi/8;
k1 = pi/16;
obst = [k1 3.7*k1 0.1*k 1.1*k];
%         k1 8*k1 3*pi/2 7*pi/4];
    
% k1    2*k1  11*k 12*k;
%         2*k1  3*k1  0    k;
%         2*k1  3*k1  4*k  5*k;
%         2*k1  3*k1  6*k  9*k;
%         2*k1  3*k1  14*k 15*k;
%         3*k1  4*k1  2*k  3*k;
%         3*k1  4*k1  10*k 11*k;
%         3*k1  4*k1  12*k 13*k;
%         4*k1  5*k1  15*k 16*k;
%         4*k1  5*k1  5*k  6*k;
%         5*k1  6*k1  2*k  3*k;
%         5*k1  6*k1  7*k  8*k;
%         5*k1  6*k1  9*k  11*k;
%         5*k1  6*k1  12*k 13*k;
%         5*k1  6*k1  14*k 15*k;
%         6*k1  7*k1  0    k;
%         6*k1  7*k1  3*k  5*k;
%         6*k1  7*k1  8*k  9*k;
%         6*k1  7*k1  14*k 15*k;
%         7*k1  8*k1  k    2*k;
%         7*k1  8*k1  4*k  6*k;
%         7*k1  8*k1  8*k  9*k;
%         7*k1  8*k1  10*k 11*k];

end

