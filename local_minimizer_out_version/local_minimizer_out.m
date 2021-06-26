function [ G1, assign_s_idx ] = local_minimizer_out( G1, s, t, obst, l, thres )
fprintf('local out\n');

E = [repmat(eye(2)*l, 1, length(s)/2); -repmat(eye(2)*l, 1, length(s)/2)];
tree = bst(pt(s));
G.x = [t; s];
G.p = potential(G.x, t);
G.n = 2;
G.idx{1} = [];
G.idx{2} = [];
G.p(1) = Inf;
gap = G1.n - 2;
thre_p = G.p(2);
% continuous_de = 0;

connected = false;
while ~connected
    pt_chosen_complete = false;
    fail = false;
    while ~pt_chosen_complete
        
        [minp, idx] = min(G.p); % get the lowest potential pt amoung all can use pts
        fprintf('%.5f, %d\n', minp, size(G.x, 1));
        
        %%%%%% scatter pts %%%%%%%%%%%%%
%         y = reshape(G.x(idx,:), 2, [])';
%         scatter(y(:,1),y(:,2),'b'); hold on;
% %         draw_potential_lvl_curve(G.x(1,:));
%         pause(0.01);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % check if all pts have generated pts
        if minp == Inf
            fail = true;
            break;
        end
        
        if (minp < thre_p)
            G1.n
            size(G1.x, 1)
            assign_s_idx = idx + gap;
            tmp_p = G1.p(assign_s_idx);
            for i = 1 : G1.n
                G1.p(i) = Inf;
            end
            G1.p(assign_s_idx) = tmp_p;
            return;
        end
        
        new_pts = repmat(G.x(idx, :), size(E, 1), 1) + E; % get newly generated pts
        
        infeasible = false(size(new_pts, 1), 1);
        for i = 1 : size(E, 1)
            infeasible(i) = local_feasible(new_pts(i,:), G.x(idx,:), obst);
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
            plot([G.x(idx,1) G.x(idx,3)], [G.x(idx,2), G.x(idx,4)]);hold on;
            for kk = 1 : size(new_pts, 1)
                plot([new_pts(kk,1) new_pts(kk,3)], [new_pts(kk,2), new_pts(kk,4)]);hold on;
            end
            
            new_pts_shape = size(new_pts, 1);
            
            new_potential = potential(new_pts, t);
            current_potential = potential(G.x(idx, :), t);
            
            G.p = [G.p; new_potential];
            G.x = [G.x; new_pts];
            for i = G.n+1 : G.n+new_pts_shape
                G.idx{idx} = [G.idx{idx}, i];
                G.idx{i} = idx;
            end

            G1.p = [G1.p; new_potential];
            G1.x = [G1.x; new_pts];
            for i = G1.n+1 : G1.n+new_pts_shape
                G1.idx{idx+gap} = [G1.idx{idx+gap}, i];
                G1.idx{i} = idx+gap;
            end
            
            pt_chosen_complete = true;
            
%             if sum(new_potential < current_potential) > 0
%                 continuous_de = continuous_de + 1;
%                 if continuous_de > 15
%                     assign_s_idx = idx + gap;
%                     tmp_p = G1.p(assign_s_idx);
%                     for i = 1 : G1.n
%                         G1.p(i) = Inf;
%                     end
%                     G1.p(assign_s_idx) = tmp_p;
%                     return;
%                 else
%                     G.p = [G.p; new_potential];
%                     G.x = [G.x; new_pts];
%                     for i = G.n+1 : G.n+new_pts_shape
%                         G.idx{idx} = [G.idx{idx}, i];
%                         G.idx{i} = idx;
%                     end
% 
%                     G1.p = [G1.p; new_potential];
%                     G1.x = [G1.x; new_pts];
%                     for i = G1.n+1 : G1.n+new_pts_shape
%                         G1.idx{idx+gap} = [G1.idx{idx+gap}, i];
%                         G1.idx{i} = idx+gap;
%                     end
%                 end
%             else
%                 G.p = [G.p; new_potential];
%                 G.x = [G.x; new_pts];
%                 for i = G.n+1 : G.n+new_pts_shape
%                     G.idx{idx} = [G.idx{idx}, i];
%                     G.idx{i} = idx;
%                 end
%                 
%                 G1.p = [G1.p; new_potential];
%                 G1.x = [G1.x; new_pts];
%                 for i = G1.n+1 : G1.n+new_pts_shape
%                     G1.idx{idx+gap} = [G1.idx{idx+gap}, i];
%                     G1.idx{i} = idx+gap;
%                 end
%             end
        end
    end
    
    %%%%%% scatter pts %%%%%%%%%%%%%
%     y = reshape(G.x(idx,:), 2, [])';
%     axis off;
%     set(gcf,'color','w');
%     rectangle('Pos', [0 0 1 1], 'EdgeColor', 'b');
%     scatter(y(:,1),y(:,2),'b'); hold on;
%         draw_potential_lvl_curve(G.x(1,:));
    pause(0.01);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % check if newly generated pts are close enough to terminal
    if pt_chosen_complete
        % calc the distance
%         close_to_t = potential(new_pts, t) <= thres;
        G.n = G.n + size(new_pts, 1);
        G1.n = G1.n + size(new_pts, 1);
%         if sum(close_to_t) > 0
%             index = find(close_to_t) + G.n - size(new_pts, 1);
%             for i = 1 : length(index)
%                 if ~(final_move_block(G.x(index(i), :), G.x(1, :), obst)...
%                      || move_block(G.x(index(i), :), G.x(1, :), obst))
%                     % check if two pts are blocked by obst
%                     G.idx{1} = [G.idx{1}, index(i)];
%                     G.idx{index(i)} = [G.idx{index(i)}, 1];
%                     connected = true;
%                     break;
%                 end
%             end
%         end
    end
    
    % terminate if the algorithm fails
    if fail
        error('The algorithm failed')
    end
end

end

