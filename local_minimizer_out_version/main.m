clear
clc
close all

tic

% [total_obst, l, s, t] = comb_obst1();
[total_obst, l, s, t] = obstacle2();
total_obst(:,end) = 1;
r = 0.025;
obst = [.725 .300 3.5*r 0;
        .725 .350 3*r 0;
        .725 .425 r 0;
        .725 .450 r 0;
        .725 .475 r 0;
        .725 .500 r 0;
        .725 .525 r 0;
        .725 .550 r 0;
        .725 .575 r 0;
        .725 .600 r 0;
        
        .680 .425 r 0;
        .680 .450 r 0;
        .680 .475 r 0;
        .680 .500 r 0;
        .680 .525 r 0;
        .680 .550 r 0;
        .680 .575 r 0;
        .680 .600 r 0;

        .825 .575 2.5*r 0;
        
        .575 1.00 r 0;
        .575 .975 r 0;
        .575 .950 r 0;
        .575 .925 r 0;
        .575 .900 r 0;
        .575 .875 r 0;
        .575 .850 r 0;
        .575 .825 r 0;
        .575 .800 r 0;
        .575 .675 r 0;
        .575 .650 r 0;
        .575 .625 r 0;
        .575 .600 r 0;
        .575 .575 r 0;
        .575 .550 r 0;
        .575 .525 r 0;
        .575 .500 r 0;
        .575 .475 r 0;
        .575 .450 r 0;
        .575 .425 r 0;
        .575 .400 r 0;
        .425 .200 4*r 0;
        .500 .500 r 0;
        .750 .950 .05 0;
        .850 .750 .05 0;
%         .425 .100 r 0;
        .425 .300 r 0;
        .425 .325 r 0;
        .425 .350 r 0];

remain_obst = [.125 .000 r 0;
        .425 .100 r 0;
        .125 .025 r 0;
        .125 .050 r 0;
        .125 .075 r 0;
        .125 .100 r 0;
        .125 .125 r 0;
        .125 .150 r 0;
        .125 .175 r 0;
        .125 .200 r 0;
        .125 .225 r 0;
        .125 .250 r 0;
        .125 .275 r 0;
        .675 .075 3*r 0;
        .000 .700 r 0;
        .025 .700 r 0;
        .050 .700 r 0;
        .075 .700 r 0;
        .350 .600 2*r 0;
        .450 .850 2*r 0;
        
        .100 .425 r 0;
        .100 .475 2*r 0;
        .125 .525 r 0;
        
        .125 .300 r 0;
        .275 1.00 r 0;
        .275 .975 r 0;
        .275 .950 r 0;
        .275 .925 r 0;
        .275 .900 r 0;
        .275 .875 r 0;
        .275 .850 r 0;
        .275 .825 r 0;
        .275 .675 r 0;
        .275 .650 r 0;
        .275 .625 r 0;
        .275 .600 r 0;
        .275 .575 r 0;
        .275 .550 r 0;
        .275 .525 r 0;
        .275 .500 r 0;
        .275 .475 r 0;
        .275 .450 r 0;
        .275 .425 r 0;
        .275 .400 r 0;
        .275 .375 r 0];
obst(:,end) = 1;
remain_obst(:,end) = 1;
% [total_obst, l, s, t] = random_obst3();
% total_obst = [];
% r = 0.2;
r = 0.13;
% r = 0.2;
global ub
global lb

ub = 0.13;
lb = 0.03;

% total_obst(:, end) = 1;
% obst = [];
% remain_obst = total_obst;
% [obst, remain_obst, ~] = add_obst(s, remain_obst, obst, r);


done = false;
path = [];
start_node = s;
thres = 0.2; % max norm: 0.01, sum 2 norm: 0.3, norm: 0.01

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
%     fig_idx = fig_idx + 1;
%     waitforbuttonpress;
    close all;
    
    [p, obst, remain_obst] = move(original_path, remain_obst, obst, r);
    
    G.n
    size(G.x, 1)
    waitforbuttonpress
    
    start_node = p(end, :);
%     waitforbuttonpress
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
% load paper_movie/double_r.13.mat

[mp, mo, mr] = movie_generator(path, total_obst, r);
movie(mp, mo, mr, true);







