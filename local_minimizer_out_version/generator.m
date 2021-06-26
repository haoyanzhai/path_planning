function G = generator( s, t, obst, l, thres )
fprintf('new round\n');
tree = bst(pt(s));
E = [eye(length(s))*l; -eye(length(s))*l];

G.x = [t; s];
G.p = potential(G.x, t);
G.n = 2;
G.idx{1} = [];
G.idx{2} = [];
G.p(1) = Inf;
assign_s_idx = -1;

connected = false;
while ~connected
    pt_chosen_complete = false;
    fail = false;
    while ~pt_chosen_complete
        
        if assign_s_idx == -1
            [minp, idx] = min(G.p); % get the lowest potential pt amoung all can use pts
            fprintf('%.5f, %d\n', minp, size(G.x, 1));

            % check if all pts have generated pts
            if minp == Inf
                fail = true;
                break;
            end
        else
            idx = assign_s_idx;
            assign_s_idx = -1;
        end
        new_pts = repmat(G.x(idx, :), length(E), 1) + E; % get newly generated pts
%         hold on;scatter(new_pts(:,1),new_pts(:,2));hold on;
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
%         waitforbuttonpress
        
        fail_array = false(size(new_pts, 1), 1);
        for i = 1 : length(fail_array)
            [tree, fail_array(i)] = tree.insert(pt(new_pts(i, :)));
        end
        new_pts(fail_array, :) = []; % remove pts on the original ones
        
        % add new pts if any
        G.p(idx) = Inf;
        if size(new_pts, 1) ~= 0
            new_pts_shape = size(new_pts, 1);
            
            new_potential = potential(new_pts, t);
            current_potential = potential(G.x(idx, :), t);
            
            pt_chosen_complete = true;
            
            if sum(new_potential < current_potential) > 0 || minp <= 0.4
                G.p = [G.p; new_potential];
                G.x = [G.x; new_pts];
                for i = G.n+1 : G.n+new_pts_shape
                    G.idx{idx} = [G.idx{idx}, i];
                    G.idx{i} = idx;
                end
            else
                [G, assign_s_idx] = local_minimizer_out(G, G.x(idx, :), t, obst, l, thres);
                new_pts = [];
                fprintf('over\n');
                G.n
            end
        end
    end
    
    %%%%%% scatter pts %%%%%%%%%%%%%
    y = reshape(G.x(idx,:), 2, [])';
    axis off;
    set(gcf,'color','w');
    rectangle('Pos', [0 0 1 1], 'EdgeColor', 'b');
    scatter(y(:,1),y(:,2),'b'); hold on;
%         draw_potential_lvl_curve(G.x(1,:));
    pause(0.01);
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
    
    % terminate if the algorithm fails
    if fail
        error('The algorithm failed')
    end
end

end

