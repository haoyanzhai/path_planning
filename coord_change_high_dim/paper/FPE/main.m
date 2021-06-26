clear
clc
close all

tic

[total_obst, l, s, t] = paperobst();
% total_obst = [];
r = 2;
global ub
global lb

ub = 0.13;
lb = 0.03;

total_obst(:, end) = 1;
obst = [];
remain_obst = total_obst;
[obst, remain_obst, ~] = add_obst(s, remain_obst, obst, r);

done = false;
path = [];
start_node = s;
thres = 0.005; % max norm: 0.01, sum 2 norm: 0.3, norm: 0.01

fig_idx = 1;
foldername = 'new';
while ~done
    oplot(obst, remain_obst);hold on;
    % generate graph
    tic
    G = generator(start_node, t, obst, l, thres);
    toc
    
    % moving along the graph
    original_path = shortest_path(G);
    fprintf('original path found\n');
    
%     gplot( G, true, obst, remain_obst); hold on;
%     scatter(start_node(1),start_node(2),150,'rd','filled');hold on;
%     scatter(t(1),t(2),50,'ro','filled');hold on;
%     saveas(gcf, strcat('./pic/', foldername, '/g', int2str(fig_idx), '.png'));
%     waitforbuttonpress;
%     pathplot(original_path, obst, remain_obst);hold on;
%     scatter(start_node(1),start_node(2),150,'rd','filled');hold on;
%     scatter(t(1),t(2),50,'ro','filled');hold on;
%     saveas(gcf, strcat('./pic/', foldername, '/p', int2str(fig_idx), '.png'));
%     waitforbuttonpress;
    fig_idx = fig_idx + 1;
    close all;
    
    [p, obst, remain_obst] = move(original_path, remain_obst, obst, r);
    start_node = p(end, :);
    path = [path; p];
    
%     waitforbuttonpress;
%     pplot(p, obst, remain_obst, true);
%     waitforbuttonpress;
%     close all
    
    done = potential(path(end,:), t) <= 1e-5;
end
% gplot(G, 1, obst, []);hold on;
% scatter(s(1), s(2), 'r*');hold on;
% scatter(t(1), t(2), 'b*');hold on;
toc

% close all
% pathplot(path, obst, remain_obst);hold on;
% scatter(s(1),s(2),150,'rd','filled');hold on;
% scatter(t(1),t(2),50,'ro','filled');hold on;
% saveas(gcf, strcat('./pic/', foldername, '/p', int2str(fig_idx), '.png'));
% waitforbuttonpress;

% close all
% pplot(path, obst, remain_obst, true);
% waitforbuttonpress;

%% 
close all
% load movies/complicated_l_03.mat
load paper_movie/double_r.13.mat

[mp, mo, mr] = movie_generator(path, total_obst, r);
movie(mp, mo, mr, true);

%%
load 'lbotinfl'

close all
rectangle('Pos', [0 0 1 1], 'EdgeColor', [.9 .9 .9], 'FaceColor', [.9 .9 .9]); hold on;

for i = 3 : size(x, 1)-2
    for j = 3 : size(x, 2)-2
        if phi(i,j) || phi(i+1,j) || phi(i-1,j) || phi(i,j+1) || phi(i,j-1)...
                || phi(i+2,j) || phi(i-2,j) || phi(i,j+2) || phi(i,j-2)
            scatter(x(i,j),y(i,j), 20, 'filled', 'MarkerEdgeColor', [.6 .6 .4], 'MarkerFaceColor', [.6 .6 .4]); hold on;
        end
    end
end

gplot(G, true, obst, remain_obst); hold on;
scatter(s(1),s(2),150,'rd','filled');hold on;
scatter(t(1),t(2),50,'ro','filled');hold on;



