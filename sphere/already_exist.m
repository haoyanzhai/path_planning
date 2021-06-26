function r = already_exist( x, Gx, l )

r = false(size(x,1),1);
for i = 1 : size(x, 1)
    for j = 1 : size(Gx, 1)
        if potential(x(i,:), Gx(j,:)) < l
            r(i) = true;
            break;
        end
    end
end

% r = pdist2(Gx, x, 'euclidean', 'Smallest', 1)' < 1e-7;

end

