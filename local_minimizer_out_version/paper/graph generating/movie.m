function [ ] = movie( p, o, r, flag )

if nargin == 3
    flag = false;
end

c = ['r', 'g', 'b', 'k', 'm'];

for i = 1 : length(p)
    hold off;
    b = reshape(p{i}, 2, [])';
    for j = 1 : size(b, 1)
        if flag
            for k = j + 1 : size(b, 1)
                plot([b(j,1) b(k,1)], [b(j,2) b(k,2)]); hold on;
            end
        end
        scatter(b(j,1), b(j,2), [], c(j));
        hold on;
    end
    oplot(o{i}, r{i});
    axis off;
    set(gcf,'color','w');
    rectangle('Pos', [0 0 1 1], 'EdgeColor', 'b');
    pause(0.01);
end

end

