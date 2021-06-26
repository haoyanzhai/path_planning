function [ blocked ] = final_move_block( x, y, obst )

global ub
global lb

for i = 0 : 0.05 : 1
    z = reshape((1-i)*x + i*y, 2, [])';
    blocked = pdist(z);
    blocked = sum((blocked>ub) | (blocked<lb)) > 0;
    if blocked
        return
    end
end


end

