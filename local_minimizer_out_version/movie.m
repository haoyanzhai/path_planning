function [ ] = movie( p, o, r, flag )

if nargin == 3
    flag = false;
end
ff = true;
c = ['b', 'k', 'c', 'r', 'm'];
idx = 0;
% start = reshape(p{1}, 2, [])';
start = reshape([.9 .9 .9 .95 .9 .85 .95 .9 .85 .9], 2, [])';
target = reshape(p{end}, 2, [])';
for i = 1 : length(p)
%     tic
%     hold off;
    clf('reset');
%     close all;
    oplot(o{i}, r{i}, false); hold on;
    for j = 1 : size(start, 1)
        if flag
            for k = j + 1 : size(start, 1)
                plot([start(j,1) start(k,1)], [start(j,2) start(k,2)], '-', 'LineWidth', 3, 'Color', [.7 .7 .7]);
%                 hold on;
            end
        end
        scatter(start(j,1), start(j,2), 100, [.7 .7 .7], 'filled');
%         hold on;
    end
    for j = 1 : size(target, 1)
        if flag
            for k = j + 1 : size(target, 1)
                plot([target(j,1) target(k,1)], [target(j,2) target(k,2)], '-', 'LineWidth', 3, 'Color', [.7 .7 .7]);
%                 hold on;
            end
        end
        scatter(target(j,1), target(j,2), 100, [.7 .7 .7], 'filled');
%         hold on;
    end
    
    
    if ff
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
%     ff = false;
    b = reshape(p{i}, 2, [])';
    for j = 1 : size(b, 1)
        if flag
            for k = j + 1 : size(b, 1)
                plot([b(j,1) b(k,1)], [b(j,2) b(k,2)], 'b-', 'LineWidth', 3);
%                 hold on;
            end
        end
        scatter(b(j,1), b(j,2), 100, c(j), 'filled');
%         hold on;
    end
    pause(0.01);
%     if idx == 0 || idx == length(p)-1 || mod(idx, 20) == 0
%         idx
%         saveas(gcf, strcat('./pic/double/', int2str(idx), '.png'));
%     end
    idx = idx + 1;
%     toc
end

end

