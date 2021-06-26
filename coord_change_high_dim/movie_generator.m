function [ p, obst, remain ] = movie_generator( path, total_obst, r )

obst{1} = [];
remain{1} = total_obst;
p{1} = path(1, :);

iter = 2;
for i = 1 : size(path, 1) - 1
    s = path(i, :); t = path(i+1, :);
    for lambda = 0 : 0.5 : 1
        x = (1-lambda)*s + lambda*t;
        if size(remain{iter-1}, 1) ~= 0
            [tobst, tremain_obst, ~] = add_obst(x, remain{iter-1}, obst{iter-1}, r);
        else
            tobst = obst{iter-1};
            tremain_obst = [];
        end
        p{iter} = x;
        obst{iter} = tobst;
        remain{iter} = tremain_obst;
        iter = iter + 1;
    end
end

end

