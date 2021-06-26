clear
clc
close all

r = .05*sqrt(2);
obst = [.45 .00 r 0
        .45 .05 r 0
        .45 .10 r 0
        .45 .15 r 0
        .45 .20 r 0
        .45 .25 r 0
        .45 .30 r 0
        .45 .35 r 0
        .45 .40 r 0
        .45 .60 r 0
        .45 .65 r 0
        .45 .70 r 0
        .45 .75 r 0
        .45 .80 r 0
        .45 .85 r 0
        .45 .90 r 0
        .45 .95 r 0
        .45 1.0 r 0
        .75 .60 r 0
        .75 .65 r 0
        .75 .70 r 0
        .75 .75 r 0
        .75 .80 r 0
        .75 .85 r 0
        .75 .90 r 0
        .75 .95 r 0
        .75 1.0 r 0];

time = 0.005;
x = [];
for i  = .1 : time : .9
    x = [x; i .5];
end
time = 0.005;
for i  = .5 : time : .9
    x = [x; .9 i];
end

[p, o, re] = movie_generator( x, obst, 0.2 );
movie(p, o, re);

% time = 0.02;
% oplot(obst, []); hold on;
% scatter(.1, .5, 150, 'rd', 'filled');
% scatter(.9, .9, 50, 'ro', 'filled');
% for i = .1 : time : .9
%     pos = [i - sqrt(2)/2*r, .5 - sqrt(2)/2*r, sqrt(2)*r, sqrt(2)*r];
%     curv = [1 1];
%     rectangle('Position',pos,'Curvature',curv, 'EdgeColor', 'k');
% end
% for i = .5 : time : .9
%     pos = [.9 - sqrt(2)/2*r, i - sqrt(2)/2*r, sqrt(2)*r, sqrt(2)*r];
%     curv = [1 1];
%     rectangle('Position',pos,'Curvature',curv, 'EdgeColor', 'k');
% end



