function [ ] = movie( p, o, r, flag )

if nargin == 3
    flag = false;
end
ff = true;
c = ['r', 'g', 'b', 'k', 'm'];
idx = 0;
rectangle('Pos', [0 0 1 1], 'EdgeColor', [.9 .9 .9], 'FaceColor', [.9 .9 .9]); hold on;

for i = 1 : length(p)
%     hold off;
    oplot(o{i}, r{i}, ff); hold on;
    ff = false;
    b = reshape(p{i}, 2, [])';
    for j = 1 : size(b, 1)
        if flag
            for k = j + 1 : size(b, 1)
                plot([b(j,1) b(k,1)], [b(j,2) b(k,2)], 'b-', 'LineWidth', 2); hold on;
            end
        end
        scatter(b(j,1), b(j,2), 50, c(j), 'filled');
        hold on;
    end
    pause(0.01);
%     waitforbuttonpress;
%     saveas(gcf, strcat('./pic/', int2str(idx), '.png'));
    idx = idx + 1;
end

end

