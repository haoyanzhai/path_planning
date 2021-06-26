function [ obst, remain_obst, f ] = add_obst(x, remain_obst, obst, r)

idx = false(size(remain_obst, 1), 1);
f = 0;
if size(remain_obst, 1) > 0
    for i = 1 : 2 : size(x, 2)
        idx = idx | (pdist2(remain_obst(:,1:2), x(i : i+1))) <= r;
    end
    if (isempty(find(idx == 1, 1)))
        f = 0;
    else
        new = remain_obst(idx, :);
        remain_obst(idx, :) = [];
        obst = [obst; new];
        f = 1;
    end
end

end