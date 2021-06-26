function [ obst, remain_obst, f ] = add_obst(x, remain_obst, obst, r)

idx = false(size(remain_obst, 1), 1);
f = 0;

if size(remain_obst, 1) > 0
    midpt = [(remain_obst(:,1)+remain_obst(:,2))/2, (remain_obst(:,3)+remain_obst(:,4))/2];
    for i = 1 : length(idx)
        for j = 1 : size(x, 1)
            if potential(midpt(i,:), x(j,:)) <= r
                idx(i) = true;
                break;
            end
        end
    end
%     idx = idx | (pdist2(midpt, x)) <= r;
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