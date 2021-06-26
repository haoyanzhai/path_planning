function G = generator( s, t, obst, l, thres, remain_obst )
fprintf('new round\n');
tree = bst(pt(s));
E = [eye(length(s))*l; -eye(length(s))*l];

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
%         fprintf('%.5f, %d\n', minp, size(G.x, 1));
        
        %%%%%% scatter pts %%%%%%%%%%%%%
%         y = reshape(G.x(idx,:), 2, [])';
%         scatter(y(:,1),y(:,2),'ro'); hold on;
% %         draw_potential_lvl_curve(G.x(1,:));
%         pause(0.1);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % check if all pts have generated pts
        if minp == Inf
            fail = true;
            break;
        end
        new_pts = repmat(G.x(idx, :), length(E), 1) + E; % get newly generated pts
        scatter(new_pts(:,1),new_pts(:,2),'r','filled');hold on;
        pause(0.05);
%         waitforbuttonpress
        
        infeasible = false(size(new_pts, 1), 1);
        for i = 1 : size(E, 1)
            if i > size(s, 2)
                pm = false;
                index = i - size(s, 2);
            else
                index = i;
                pm = true;
            end
            if mod(i, 2) == 0
                xy = false;
            else
                xy = true;
            end
            infeasible(i) = feasible(new_pts(i,:), G.x(idx,:), obst, ceil(index/2), l, xy, pm);
        end
        new_pts(infeasible, :) = []; % remove infeasible pts
        
        fail_array = false(size(new_pts, 1), 1);
        for i = 1 : length(fail_array)
            [tree, fail_array(i)] = tree.insert(pt(new_pts(i, :)));
        end
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
%     y = reshape(G.x(idx,:), 2, [])';
%     axis off;
%     set(gcf,'color','w');
% %     rectangle('Pos', [0 0 1 1], 'EdgeColor', 'b');
%     scatter(y(:,1),y(:,2),'b'); hold on;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % check if newly generated pts are close enough to terminal
    if pt_chosen_complete
        % calc the distance
        close_to_t = potential(new_pts, t) <= thres;
        G.n = G.n + size(new_pts, 1);
        if sum(close_to_t) > 0
            index = find(close_to_t) + G.n - size(new_pts, 1);
            for i = 1 : length(index)
                if ~(final_move_block(G.x(index(i), :), G.x(1, :), obst)...
                     || move_block(G.x(index(i), :), G.x(1, :), obst))
                    % check if two pts are blocked by obst
                    G.idx{1} = [G.idx{1}, index(i)];
                    G.idx{index(i)} = [G.idx{index(i)}, 1];
                    connected = true;
                    break;
                end
            end
        end
    end
    
    
    gplot(G, true, obst, remain_obst);
% %         draw_potential_lvl_curve(G.x(1,:));
    pause(0.05);
    
    % terminate if the algorithm fails
    if fail
        error('The algorithm failed')
    end
end

end

