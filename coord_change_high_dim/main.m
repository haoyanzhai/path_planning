clear
clc
close all

tic

[total_obst, l, s, t] = comb_obst1();
[total_obst, l, s, t] = obstacle2();
% [total_obst, l, s, t] = random_obst3();
% [total_obst, l, s, t] = obstacle20();
% [total_obst, l, s, t] = obst_control_paper();
% total_obst = [];
% r = 0.2;
r = 0.13;
global ub
global lb

ub = 0.5;
lb = 0.03;

total_obst(:, end) = 1;
obst = [];
remain_obst = total_obst;
[obst, remain_obst, ~] = add_obst(s, remain_obst, obst, r);

done = false;
path = [];
start_node = s;
thres = 0.03; % max norm: 0.01, sum 2 norm: 0.3, norm: 0.01

fig_idx = 1;
foldername = '1';
tic
while ~done
    clf('reset');
    oplot(obst, remain_obst);hold on;
    % generate graph
%     tic
    G = generator(start_node, t, obst, l, thres, remain_obst);
%     toc
    
    % moving along the graph
    original_path = shortest_path(G);
    fprintf('original path found\n');
    
%     gplot( G, true, obst, remain_obst); hold on;
%     scatter(original_path(:,1),original_path(:,2), 'ro', 'filled');
%     scatter(start_node(1),start_node(2),150,'rd','filled');hold on;
%     scatter(t(1),t(2),50,'ro','filled');hold on;
%     saveas(gcf, strcat('./pic/', foldername, '/g', int2str(fig_idx), '.pdf'));
%     waitforbuttonpress;
    pathplot(original_path, obst, remain_obst);hold on;
    pause(2);
%     scatter(start_node(1),start_node(2),150,'rd','filled');hold on;
%     scatter(t(1),t(2),50,'ro','filled');hold on;
%     saveas(gcf, strcat('./pic/', foldername, '/p', int2str(fig_idx), '.pdf'));
%     waitforbuttonpress;
    fig_idx = fig_idx + 1;
%     waitforbuttonpress;
%     close all;
    
    [p, obst, remain_obst] = move(original_path, remain_obst, obst, r);
    start_node = p(end, :);
%     waitforbuttonpress
    path = [path; p];
    
%     waitforbuttonpress;
%     figure(2);
%     gplot(G, true, obst, remain_obst);
%     figure(3);
%     pathplot(p, obst, remain_obst);
%     waitforbuttonpress;
%     close all
    
    done = potential(path(end,:), t) <= 1e-5;
end
% gplot(G, 1, obst, []);hold on;
% scatter(s(1), s(2), 'r*');hold on;
% scatter(t(1), t(2), 'b*');hold on;
toc

%%
close all
pathplot(path, obst, remain_obst);hold on;
scatter(s(1),s(2),150,'rd','filled');hold on;
scatter(t(1),t(2),50,'ro','filled');hold on;
saveas(gcf, strcat('./pic/', foldername, '/p', int2str(fig_idx), '.pdf'));
waitforbuttonpress;

% close all
% pplot(path, obst, remain_obst, true);
% waitforbuttonpress;

%%
close all
% load movies/complicated_l_03.mat
% load paper_movie/double_r.13.mat

[mp, mo, mr] = movie_generator(path, total_obst, r);
length(mp)
%%
close all
movie(mp, mo, mr, true, reshape(t, 2, [])');


%%





