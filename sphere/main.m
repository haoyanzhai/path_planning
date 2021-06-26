clear
clc
close all

tic

r = 1.0;
too_close = 0.2;

[total_obst, l, s, t] = obstacle();
obst = [];
remain_obst = total_obst;
[obst, remain_obst, ~] = add_obst(s, remain_obst, obst, r);

done = false;
path = [];
start_node = s;
thres = 0.7;

fig_idx = 1;
foldername = 'new';
while ~done
%     oplot(obst, remain_obst);hold on;
    % generate graph
    oplot(obst, remain_obst, 1);
    tic
    G = generate(start_node, t, obst, l, thres, too_close);
    toc
    
    % moving along the graph
    original_path = shortest_path(G);
    fprintf('original path found\n');
    
    gplot( G, true, obst, remain_obst); hold on;
    [cx, cy] = pt_drawer_pre(start_node);
    scatter(cx,cy,150,'rd','filled');hold on;
    [cx, cy] = pt_drawer_pre(t);
    scatter(cx,cy,50,'ro','filled');hold on;
%     saveas(gcf, strcat('./pic/', foldername, '/g', int2str(fig_idx), '.png'));
    waitforbuttonpress;
    pathplot(original_path, obst, remain_obst);hold on;
    [cx, cy] = pt_drawer_pre(start_node);
    scatter(cx,cy,150,'rd','filled');hold on;
    [cx, cy] = pt_drawer_pre(t);
    scatter(cx,cy,50,'ro','filled');hold on;
%     saveas(gcf, strcat('./pic/', foldername, '/p', int2str(fig_idx), '.png'));
%     waitforbuttonpress;
    fig_idx = fig_idx + 1;
    waitforbuttonpress;
    close all;
    
    [p, obst, remain_obst] = move(original_path, remain_obst, obst, r);
    start_node = p(end, :);
%     waitforbuttonpress
    path = [path; p];
    path
    
%     waitforbuttonpress;
%     pplot(p, obst, remain_obst, true);
    waitforbuttonpress;
%     close all
    
    done = potential(path(end,:), t) <= 1e-5;
end
% gplot(G, 1, obst, []);hold on;
% scatter(s(1), s(2), 'r*');hold on;
% scatter(t(1), t(2), 'b*');hold on;
toc

%%
% close all
pathplot(path, obst, remain_obst);hold on;
[cx, cy] = pt_drawer_pre(s);
scatter(cx,cy,150,'rd','filled');hold on;
[cx, cy] = pt_drawer_pre(t);
scatter(cx,cy,50,'ro','filled');hold on;
% saveas(gcf, strcat('./pic/', foldername, '/p', int2str(fig_idx), '.png'));
% waitforbuttonpress;

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







