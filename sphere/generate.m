function G = generate( s, t, obst, l, thres, too_close )

fprintf('new round\n');

G.x = [t; s];
G.p = potential(G.x, t);
G.n = 2;
G.idx{1} = [];
G.idx{2} = [];
G.p(1) = Inf;

connected = false;

while ~connected
    pt_chosen_complete = false;
    fail = false;
    while ~pt_chosen_complete
        
        [minp, idx] = min(G.p); % get the lowest potential pt amoung all can use pts
        fprintf('%.5f, %d\n', minp, size(G.x, 1));
        
        % check if all pts have generated pts
        if minp == Inf
            fail = true;
            break;
        end
        new_pts = geo(G.x(idx, :), l); % get newly generated pts
        
%         gplot(G,1,obst,[]);
%         
        [cx, cy] = pt_drawer_pre(new_pts);
        scatter(cx, cy, 50, 'ro', 'filled');hold on;
        pause(0.01);
%         
%         for kkkkk = 1 : size(new_pts,1)
%             sss = step(G.x(idx,:), new_pts(kkkkk,:), 100);
%             [cx, cy] = pt_drawer_pre(sss);
%             plot(cx, cy, 'b-', 'LineWidth', 1.5); hold on;
%         end
%         pause(0.01);
%         [cx, cy] = pt_drawer_pre(G.x(2,:));
%         scatter(cx, cy, 70, 'rd', 'filled'); hold on;
%         [cx, cy] = pt_drawer_pre(G.x(1,:));
%         scatter(cx, cy, 70, 'rd', 'filled');
%         waitforbuttonpress
        
        % path infeasible
        infeasible = path_infeasible(G.x(idx,:), new_pts, obst);
%         infeasible
        new_pts(infeasible, :) = []; % remove infeasible pts
        
        % already exists
        fail_array = already_exist(new_pts, G.x, too_close);
%         fail_array
        new_pts(fail_array, :) = []; % remove pts on the original ones
        
        % add new pts if any
        G.p(idx) = Inf;
        if size(new_pts, 1) ~= 0
            new_pts_shape = size(new_pts, 1);
            pt_chosen_complete = true;
            G.p = [G.p; potential(new_pts, t)];
            G.x = [G.x; new_pts];
            for i = G.n+1 : G.n+new_pts_shape
                G.idx{idx} = [G.idx{idx}, i];
                G.idx{i} = idx;
            end
        end
    end
    
    %%%%%% scatter pts %%%%%%%%%%%%%
    y = reshape(G.x(idx,:), 2, [])';
    axis off;
    set(gcf,'color','w');
%     rectangle('Pos', [-1 -1 2 2], 'EdgeColor', 'b', 'Curvature', [1 1]);
    [cx, cy] = pt_drawer_pre(y);
    scatter(cx, cy,'b'); hold on;
    
    
%     s = step(x(i,:), x(idx(j),:), n);
%     [cx, cy] = pt_drawer_pre(s);
%     plot(cx, cy, 'b-', 'LineWidth', 0.5); hold on;
    
    
%     waitforbuttonpress
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    gplot(G,1,obst,[]);
    [cx, cy] = pt_drawer_pre(G.x(2,:));
    scatter(cx, cy, 70, 'rd', 'filled'); hold on;
    [cx, cy] = pt_drawer_pre(G.x(1,:));
    scatter(cx, cy, 70, 'rd', 'filled');
    pause(.01);
%     waitforbuttonpress
    
    % check if newly generated pts are close enough to terminal
    if pt_chosen_complete
        % calc the distance
        close_to_t = potential(new_pts, t) <= thres;
        G.n = G.n + size(new_pts, 1);
        if sum(close_to_t) > 0
            index = find(close_to_t) + G.n - size(new_pts, 1);
            for i = 1 : length(index)
                G.idx{1} = [G.idx{1}, index(i)];
                G.idx{index(i)} = [G.idx{index(i)}, 1];
                connected = true;
                break;
            end
        end
    end
    
    % terminate if the algorithm fails
    if fail
        error('The algorithm failed');
    end
end

end






















function s = step(x1, x2, n)

lambda = (0 : 1/n : 1)';

for i = 1 : size(x1,1)
    if abs(x1(i,2)-x2(i,2))>pi
        x2(i,2) = x2(i,2) - 2*pi;
    end
end

s = [(1-lambda)*x1(:,1)+lambda*x2(:,1), (1-lambda)*x1(:,2)+lambda*x2(:,2)];

end






