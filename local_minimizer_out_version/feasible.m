function infeasible = feasible( pt, o_pt, obst, idx, l, xy, pm )
% pm: plus or minus, true for plus
% xy: x coord or y coord, true for x coord
% idx: the diff pt idx

global ub
global lb

% ub = Inf;
% lb = 0;

total = reshape(pt, 2, [])';
x = total(idx, :);
y = total;
y(idx, :) = [];
tmp_idx = (idx-1)*2 + 1;
o_x = o_pt(tmp_idx : tmp_idx+1);

if ~isempty(find(pt<0 | pt>1, 1))
    infeasible = true;
    return
end

% in obst at new pt
% if size(obst, 1) > 0
%     infeasible = in_obst(x, obst);
%     if infeasible
% %         fprintf('0\n');
%         return
%     end
% end

if size(obst, 1) > 0
    for i = 1 : size(total, 1)
        tmp = in_obst(total(i, :), obst);
        if sum(tmp) > 0
            infeasible = true;
            return;
        end
    end
end

% too close at new pt
d = pdist2(y, x, 'euclidean');
infeasible = ~isempty(find((d>ub | d<lb), 1));
if infeasible
    return
end

% from original to now is blocked
for i = 1 : 2 : size(o_pt, 2) - 1
    infeasible = block(o_pt(i : i+1), x, obst);
    if infeasible
%         fprintf('1\n');
        return
    end
end

% two 2-dim pt blocked by obst
for i = 1 : size(y, 1)
    infeasible = block(x, y(i, :), obst);
    if infeasible
%         fprintf('2\n');
        return
    end
end

if ~isempty(obst)
    % two 2-dim mid pt blocked by obst
    for i = 1 : size(y, 1)
        infeasible = block((x+o_x)/2, y(i, :), obst);
        if infeasible
    %         fprintf('3\n');
            return
        end
    end

% %     two 2-dim 1/4 pt blocked by obst
%     for i = 1 : size(y, 1)
%         infeasible = block((x+3*o_x)/4, y(i, :), obst);
%         if infeasible
%     %         fprintf('3\n');
%             return
%         end
%     end
% 
% %     two 2-dim 3/4 pt blocked by obst
%     for i = 1 : size(y, 1)
%         infeasible = block((3*x+o_x)/4, y(i, :), obst);
%         if infeasible
%     %         fprintf('3\n');
%             return
%         end
%     end
end

% too close along link
if xy
    tmp = (x(1) - y(:,1)) / l;
else
    tmp = (x(2) - y(:,2)) / l;
end

if ~pm
    tmp = -tmp;
end

mark = tmp>0 & tmp<1;
y = y(mark, :);

if xy
    d = abs(x(2) - y(:,2));
    infeasible = ~isempty(find((d>ub | d<lb)==1, 1));
else
    d = abs(x(1) - y(:,1));
    infeasible = ~isempty(find((d>ub | d<lb)==1, 1));
end

end

