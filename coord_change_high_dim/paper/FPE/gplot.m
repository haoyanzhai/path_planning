function [] = gplot( G, flag, obst, remain_obst )

oplot(obst, remain_obst); hold on;

x = G.x;
scatter(x(:,1), x(:,2), 'bo', 'filled');hold on;
if flag
    for i = 1 : G.n
        idx = G.idx{i};
        for j = 1 : length(idx)
            plot([x(i, 1), x(idx(j), 1)], [x(i, 2), x(idx(j), 2)], 'b-'); hold on;
        end
    end
end

end

