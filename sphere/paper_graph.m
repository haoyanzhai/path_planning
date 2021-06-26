clear
clc
close all

tic

r = 0.3;

[total_obst, l, s, t] = obstacle1();
obst = total_obst;
remain_obst = [];
too_close = 1;
% remain_obst = total_obst;
% [obst, remain_obst, ~] = add_obst(s, remain_obst, obst, r);

done = false;
path = [];
start_node = s;
thres = 1.5;

fig_idx = 1;
foldername = 'new';
while ~done
    oplot(obst, remain_obst, 1);hold on;
    % generate graph
    tic
    G = generate(start_node, t, obst, l, thres, too_close);
    toc
    
    % moving along the graph
    original_path = shortest_path(G);
    fprintf('original path found\n');
    
    gplot( G, true, obst, remain_obst); hold on;
%     scatter(start_node(1),start_node(2),150,'rd','filled');hold on;
%     scatter(t(1),t(2),50,'ro','filled');hold on;
%     saveas(gcf, strcat('./pic/', foldername, '/g', int2str(fig_idx), '.png'));
%     waitforbuttonpress;
%     pathplot(original_path, obst, remain_obst);hold on;
%     scatter(start_node(1),start_node(2),150,'rd','filled');hold on;
%     scatter(t(1),t(2),50,'ro','filled');hold on;
%     saveas(gcf, strcat('./pic/', foldername, '/p', int2str(fig_idx), '.png'));
%     waitforbuttonpress;
%     fig_idx = fig_idx + 1;
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
close all
% pathplot(path, obst, remain_obst);hold on;
oplot(obst,[],1);
gplot(G,1,obst,[]);
[cx, cy] = pt_drawer_pre(G.x(2,:));
scatter(cx, cy, 70, 'rd', 'filled'); hold on;
[cx, cy] = pt_drawer_pre(G.x(1,:));
scatter(cx, cy, 70, 'rd', 'filled');;
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



%%
oplot(obst, remain_obst, 1);hold on;
gplot(G,1,obst,[]);
[cx, cy] = pt_drawer_pre(G.x(2,:));
scatter(cx, cy, 20, 'rd', 'filled'); hold on;
[cx, cy] = pt_drawer_pre(G.x(1,:));
scatter(cx, cy, 20, 'rd', 'filled');
pause(.1);
waitforbuttonpress



