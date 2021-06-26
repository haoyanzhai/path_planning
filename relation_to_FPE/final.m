clear
clc
close all

tic

[total_obst, l, s, t] = obstacle1();
[total_obst, l, s, t] = ob();
[total_obst, l, s, t] = obst_control_paper();

% total_obst = [];

oplot(total_obst, [], 1);
% waitforbuttonpress

% [total_obst, l, s, t] = comb_obst1();
r = 0.2;
global ub
global lb

ub = 0.5;
lb = 0.03;

% total_obst(:, end) = 1;
obst = total_obst;
remain_obst = [];

thres = 0.001; % max norm: 0.01, sum 2 norm: 0.3, norm: 0.01

oplot(obst, remain_obst); hold on;
% generate graph
tic
G = generator_all(s, t, obst, l, thres);
toc

% G = gridize(G, l);

% comb_obst1 compare
% tmp = G.idx{139};
% tmp(3) = [];
% G.idx{139} = tmp;
% 
% tmp = G.idx{176};
% tmp(1) = [];
% G.idx{176} = tmp;


G.p = potential(G.x, t);
G.d = G.idx;
G.d{1} = ones(size(G.idx{1}));
for i = 2 : length(G.idx)
    idx = G.idx{i};
    tmp = G.d{i};
    for j = 1 : length(idx)
        p1 = G.p(i);
        p2 = G.p(idx(j));
        if p1 > p2
            base_idx = i;
            base = G.x(i,:);
            targ = G.x(idx(j),:);
        else
            base_idx = idx(j);
            targ = G.x(i,:);
            base = G.x(idx(j),:);
        end
        
        v = G.x(1,:) - base;
        u = targ - base;
        value = (u*v') / (norm(u)*norm(v));
        
        neighbor = G.idx{base_idx};
        neighbor = neighbor(G.p(neighbor) < G.p(base_idx));
        ttttt = [];
        for k = 1 : length(neighbor)
            if neighbor(k) ~= targ
                w = G.x(neighbor(k), :) - base;
                ttttt = [ttttt (w*v') / (norm(w)*norm(v))];
            end
        end
%         waitforbuttonpress
        if value >= max(ttttt)
            tmp(j) = 1;
        else
            tmp(j) = 0;
        end
    end
    G.d{i} = tmp;
end

tmp_idx = G.idx{1};
tmp_d = ones(1, length(tmp_idx));
G.d{1} = tmp_d;
for i = 1 : length(tmp_idx)
    iii = G.idx{tmp_idx(i)};
    m = find(iii == 1);
    jjj = G.d{tmp_idx(i)};
    jjj(m) = 1;
    G.d{tmp_idx(i)} = jjj;
end

%%
close all
gplot(G, 1, obst, remain_obst);

%%
phi = zeros(G.n, 1);
phi(2) = 1;
current = 2;
grad_or_diff = 1;
iter = 1;
oplot(obst, []);hold on;
[x, y] = meshgrid(0 : 0.01 : 1);
x0 = ones(size(x)) * G.x(1,1);
y0 = ones(size(x)) * G.x(1,2);
z = (x-x0).^2+(y-y0).^2;
contour(x,y,z, 80);
% grad_or_diff = check(G, current);
while phi(1,end) < 1
    grad_or_diff
    if grad_or_diff == 1 % if gradient
        [tphi, idx, rho] = evolve_grad(G, current);
        grad_or_diff = 0;
    else % diffusion
        [tphi, idx] = evolve_diffusion(G, current, phi(:,end), obst);
        grad_or_diff = 1;
    end
    current = idx;
    G.x(current,:)
    iter = iter + 1;
    phi = [phi, phi(:,end)|tphi];
%     waitforbuttonpress
end

%%
close all
topf = 0.001;

close all
figure(2);
gplot(G, 1, obst, remain_obst);
for i = 1 : size(phi,2)
    i
    heat(G, phi(:,i), topf, false);
    pause(0.01);
    waitforbuttonpress
end

%%
close all
figure(3)
oplot(obst, remain_obst);hold on;
[x, y] = meshgrid(0 : 0.01 : 1);
x0 = ones(size(x)) * t(1);
y0 = ones(size(x)) * t(2);
z = (x-x0).^2+(y-y0).^2;
contour(x,y,z, 80);
grid on;

G_partial = generator(s, t, obst, l, thres);

%%
figure(3);
[x, y] = meshgrid(0 : 0.01 : 1);
x0 = ones(size(x)) * t(1);
y0 = ones(size(x)) * t(2);
z = sqrt((x-x0).^2+(y-y0).^2);

% rectangle('Pos', [0 0 1 1], 'EdgeColor', [.9 .9 .9], 'FaceColor', [.9 .9 .9]);hold on;
contour(x,y,z, 50);hold on;
% oplot(obst, remain_obst, 1);hold on;
gplot(G_partial, 1, obst, remain_obst);
scatter(s(1), s(2), 60, 'rd', 'filled'); hold on;
scatter(t(1), t(2), 60, 'ro', 'filled'); hold on;
%%
figure(4);
topf = 0.001;
gplot(G, 1, obst, remain_obst)
heat(G, phi(:,end), topf, false);
scatter(s(1), s(2), 60, 'rd', 'filled'); hold on;
scatter(t(1), t(2), 60, 'ro', 'filled'); hold on;
%% final plot
close all
f = phi(:,end);
rectangle('Pos', [0 0 1 1], 'EdgeColor', [.9 .9 .9], 'FaceColor', [.9 .9 .9]);
for i = 1 : length(f)
    if f(i) > 0
        pos = [G.x(i,1)-l, G.x(i,2)-l, 2*l, 2*l];
        rectangle('Pos', pos, 'EdgeColor', [.7 .7 .7], 'FaceColor', [.7 .7 .7]); hold on;
%         waitforbuttonpress
    end
end
axis([0 1 0 1]);
x = G_partial.x;
scatter(x(:,1), x(:,2), 30, 'bo', 'filled');hold on;
for i = 1 : G_partial.n
    idx = G_partial.idx{i};
    for j = 1 : length(idx)
        plot([x(i, 1), x(idx(j), 1)], [x(i, 2), x(idx(j), 2)], 'b-', 'LineWidth', 1.7); hold on;
    end
end


for i = 1 : size(obst, 1)
    x = obst(i, 1);
    y = obst(i, 2);
    r = obst(i, 3);
    if obst(i, 4) == 1
        pos = [x - r, y - r, 2 * r, 2 * r];
        curv = [1 1];
    else
        pos = [x - sqrt(2)/2*r, y - sqrt(2)/2*r, sqrt(2)*r, sqrt(2)*r];
        curv = [0 0];
    end
    rectangle('Position',pos,'Curvature',curv, 'FaceColor', [.3 .3 .3], 'EdgeColor', [.3 .3 .3]);
end
scatter(G.x(2,1), G.x(2,2), 40, 'rd', 'filled');hold on;
scatter(G.x(1,1), G.x(1,2), 40, 'ro', 'filled');hold on;
axis([0 1 0 1]);
axis off;
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];




