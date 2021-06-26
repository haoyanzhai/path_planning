function blocked = move_block( x, y, obst )

% ymx = y - x;
% tmp = find(abs(ymx) > 1e-4, 1);
% pm = sign(ymx(tmp)) == 1;
% l = abs(ymx(tmp));
% xy = mod(tmp, 2) == 1;
% idx = ceil(tmp / 2);
% blocked = feasible(y, x, obst, idx, l, xy, pm);
blocked = local_feasible(y, x, obst);

end

