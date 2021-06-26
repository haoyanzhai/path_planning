clear
clc
close all

tic

% [total_obst, l, s, t] = comb_obst1();
% [total_obst, l, s, t] = obstacle2();
[total_obst, l, s, t] = obstacle3();
% total_obst = [];
r = 2;

global ub
global lb

ub = 0.13;
lb = 0.03;

total_obst(:, end) = 1;
obst = [];
remain_obst = total_obst;
% obst = total_obst;
% remain_obst = [];
[obst, remain_obst, ~] = add_obst(s, remain_obst, obst, r);

done = false;
path = [];
start_node = s;
thres = 0.07; % max norm: 0.01, sum 2 norm: 0.3, norm: 0.01

while ~done
    oplot(obst, remain_obst); hold on;
    % generate graph
    tic
    G = generator(start_node, t, obst, l, thres);
    toc
    
    % moving along the graph
    original_path = shortest_path(G);
    fprintf('original path found\n');
    
    waitforbuttonpress;
    gplot( G, true, obst, remain_obst); hold on;
    scatter(s(1), s(2), 150, 'rd', 'filled');hold on;
    scatter(t(1), t(2), 50, 'ro', 'filled');hold on;
    
    [p, obst, remain_obst] = move(original_path, remain_obst, obst, r);
    start_node = p(end, :);
    path = [path; p];
    done = potential(path(end,:), t) <= 1e-5;
end

toc

% close all
% pathplot(path, obst, remain_obst);
% waitforbuttonpress;

% close all
% pplot(path, obst, remain_obst, true);
% waitforbuttonpress;

%% 
close all
load movies/complicated_l_03.mat
[mp, mo, mr] = movie_generator(path, total_obst, r);
movie(mp, mo, mr, true);







