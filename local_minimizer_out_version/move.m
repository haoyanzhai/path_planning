function [ p, obst, remain_obst ] = move( path, remain_obst, obst, r )

fprintf('moving...\n');

p = path(1, :);
dt = 0.05;
done = 0;
lll = 2*r/3;
for i = 1 : size(path,1) - 1
    s = path(i, :); t = path(i+1, :);
    tmp = t - s;
    for lambda = dt : dt : 1-lll
        x = s + lambda * tmp;
        if size(remain_obst, 1) ~= 0
            [obst, remain_obst, ~] = add_obst(x, remain_obst, obst, r);
        end
        
        if move_block(x, x+tmp*lll, obst)
            p = [p; x];
            done = 1;
            lambda
            break;
        end
    end
    if done
        break;
    end
    p = [p; t];
end

fprintf('moving done\n');

end

