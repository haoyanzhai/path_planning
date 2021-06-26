function [] = oplot( obst_found, obst_remain, flg )

if nargin == 2
    flg = false;
end

rectangle('Pos', [0 0 1 1], 'EdgeColor', [.9 .9 .9], 'FaceColor', [.9 .9 .9]);

for i = 1 : size(obst_remain, 1)
    x = obst_remain(i, 1);
    y = obst_remain(i, 2);
    r = obst_remain(i, 3);
    
    if obst_remain(i, 4) == 1
        pos = [x - r, y - r, 2 * r, 2 * r];
        curv = [1 1];
    else
        pos = [x - sqrt(2)/2*r, y - sqrt(2)/2*r, sqrt(2)*r, sqrt(2)*r];
        curv = [0 0];
    end
    rectangle('Position',pos,'Curvature',curv, 'EdgeColor', [.6 .6 .6], 'FaceColor', [.6 .6 .6]);
end

for i = 1 : size(obst_found, 1)
    x = obst_found(i, 1);
    y = obst_found(i, 2);
    r = obst_found(i, 3);
    if obst_found(i, 4) == 1
        pos = [x - r, y - r, 2 * r, 2 * r];
        curv = [1 1];
    else
        pos = [x - sqrt(2)/2*r, y - sqrt(2)/2*r, sqrt(2)*r, sqrt(2)*r];
        curv = [0 0];
    end
    rectangle('Position',pos,'Curvature',curv, 'FaceColor', [.3 .3 .3], 'EdgeColor', [.3 .3 .3]);
end


if flg
    axis([0 1 0 1]);
    axis off;
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset; 
    left = outerpos(1) + ti(1);
    bottom = outerpos(2) + ti(2);
    ax_width = outerpos(3) - ti(1) - ti(3);
    ax_height = outerpos(4) - ti(2) - ti(4);
    ax.Position = [left bottom ax_width ax_height];
end


end

