function blocked = block( x, y, obst, flag )
    if nargin == 3
        flag = false;
    end

    if size(obst, 1) > 0
        o = obst(:, 1:2);
        r = obst(:, 3);

        u = (x - y)';
        if flag
            if in_obst(y, obst)
                blocked = true;
                fprintf('in\n');
                return
            end
        end
        
        tmp = sqrt(sum(((eye(2) - u*u'/(u'*u)) * (o - repmat(y, size(o,1), 1))').^2, 1)') < r;
        angle1 = (o(:,1)-x(1))*(y(1)-x(1)) + (o(:,2)-x(2))*(y(2)-x(2)) > 0;
        angle2 = (o(:,1)-y(1))*(x(1)-y(1)) + (o(:,2)-y(2))*(x(2)-y(2)) > 0;
        blocked = ~isempty(find(tmp & angle1 & angle2, 1));
    else
        blocked = false;
    end
end
