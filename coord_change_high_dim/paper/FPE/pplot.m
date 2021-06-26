function [] = pplot( path, obst, remain_obst, flag )

if nargin == 3
    flag = false;
end

c = ['r', 'g', 'b', 'k', 'm'];
for i = 1 : size(path, 1) - 1
    y = reshape(path(i,:), 2, [])';
    z = reshape(path(i+1,:), 2, [])';
    for lambda = 0 : 0.5 : 1
        b = lambda * z + (1-lambda) * y;
        for j = 1 : size(y, 1)
            if flag
                for k = j + 1 : size(y, 1)
                    plot([b(j,1) b(k,1)], [b(j,2) b(k,2)]); hold on;
                end
            end
            scatter(b(j,1), b(j,2), [], c(j));hold on;
        end
        oplot(obst, remain_obst);
        axis off;
        set(gcf,'color','w');
        rectangle('Pos', [0 0 1 1], 'EdgeColor', 'b');
        hold off;
        
        pause(0.01);
    end
end

end

