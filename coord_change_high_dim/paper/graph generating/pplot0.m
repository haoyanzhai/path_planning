function [] = pplot0( path, obst, remain_obst )

c = ['r', 'g', 'b', 'k', 'm'];
for i = 1 : size(path, 1) - 1
    y = reshape(path(i,:), 2, [])';
    z = reshape(path(i+1,:), 2, [])';
    for lambda = 0 : 0.5 : 1
        b = lambda * z + (1-lambda) * y;
        for j = 1 : length(c)
            for k = j + 1 : length(c)
                plot([b(j,1) b(k,1)], [b(j,2) b(k,2)]); hold on;
            end
            scatter(b(j,1), b(j,2), [], c(j));hold on;
        end
        oplot(obst, remain_obst);
        hold off;
        
        pause(0.01);
    end
end

end

