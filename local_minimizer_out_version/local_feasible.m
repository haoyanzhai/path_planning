function infeasible = local_feasible( pt, o_pt, obst)

infeasible = false;

total = reshape(pt, 2, [])';
o_total = reshape(o_pt, 2, [])';

% new pt out of boundary
for i = 1 : size(total, 1)
    if total(i, 1) > 1 || total(i, 1) <0 || total(i, 2) > 1 || total(i, 2) < 0
        infeasible = true;
        return;
    end
end

% new pt in obst
if size(obst, 1) > 0
    for i = 1 : size(total, 1)
        tmp = in_obst(total(i, :), obst);
        if sum(tmp) > 0
%             fprintf('0\n');
            infeasible = true;
            return;
        end
    end
end



% block along the way
for i = 1 : size(total, 1)
    if block(o_total(i,:), total(i,:), obst)
%         fprintf('1\n');
        infeasible = true;
        return;
    end
end

% block the linking
for i = 1 : size(total, 1)
    for j = 1 : size(total, 1)
        if i ~= j
            if block(total(i,:), total(j,:), obst)
                infeasible = true;
%                 fprintf('2\n');
                return;
            end
        end
    end
end

tt = (total + o_total) / 2;
for i = 1 : size(tt, 1)
    for j = 1 : size(tt, 1)
        if i ~= j
            if block(tt(i,:), tt(j,:), obst)
                infeasible = true;
%                 fprintf('3\n');
                return;
            end
        end
    end
end

end






