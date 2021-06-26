function in = path_infeasible( s, x, obst )

in = false(size(x, 1),1);
for j = 1 : length(in)
    l = step(s, x(j,:), 5);
    in(j) = ~isempty(find(in_obst(l, obst),1));
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

