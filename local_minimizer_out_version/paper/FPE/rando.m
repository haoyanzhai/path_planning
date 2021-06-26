function [ obst ] = rando( )
clc

n = 70;
r = 0.13;
rr = r - 0.05;

obst = rand(n, 2);

obst = [obst rand(n, 1) * rr ones(n, 1)];

o = obstacle1();

obst = [o; obst];

close all
oplot(obst, []);

end

