function [] = pathplot( path, obst, remain_obst )

close all
oplot(obst, remain_obst); hold on;

for i = 1 : length(path) - 1
    plot([path(i, 1) path(i+1, 1)], [path(i, 2), path(i+1, 2)], 'b-', 'LineWidth',1.5); hold on;
end

axis off;
set(gcf,'color','w');
rectangle('Pos', [0 0 1 1], 'EdgeColor', 'b');

end