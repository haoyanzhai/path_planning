function [ ] = oplot( current_obst, remain_obst, flg )
% obst = [lower phi, upper phi, lower theta, upper theta]

if nargin == 2
    flg = false;
end


rectangle('Pos', [-1 -1 2 2], 'EdgeColor', [.9 .9 .9], 'FaceColor', [.9 .9 .9], 'Curvature', [1 1]); hold on;
rrr = sin(pi/16);
% rrr = sin(pi/7);
rectangle('Pos', [-rrr -rrr 2*rrr 2*rrr], 'EdgeColor', [.3 .3 .3], 'Curvature', [1 1]); hold on;
axis equal;
% number of points plotted on an edge for obst
n = 200;

pts = [];

obst = current_obst;
for i = 1 : size(obst, 1)
    s_theta = (obst(i,3) : step(obst(i,3), obst(i,4), n) : obst(i,4))';
    s_phi = (obst(i,1) : step(obst(i,1), obst(i,2), n) : obst(i,2))';
    
    % phi up
    pts = [pts; repmat(obst(i,2),length(s_theta),1), s_theta];
    
    % phi down
    pts = [pts; repmat(obst(i,1),length(s_theta),1), s_theta];
    
    % theta up
    pts = [pts; s_phi, repmat(obst(i,4),length(s_phi),1)];
    
    % theta down
    pts = [pts; s_phi, repmat(obst(i,3),length(s_phi),1)];
end

if ~isempty(pts)
    [cx, cy] = pt_drawer_pre(pts);
    scatter(cx, cy, 2, '.', 'MarkerEdgeColor', [.3 .3 .3]);
end

pts = [];
obst = remain_obst;
for i = 1 : size(obst, 1)
    s_theta = (obst(i,3) : step(obst(i,3), obst(i,4), n) : obst(i,4))';
    s_phi = (obst(i,1) : step(obst(i,1), obst(i,2), n) : obst(i,2))';
    
    % phi up
    pts = [pts; repmat(obst(i,2),length(s_theta),1), s_theta];
    
    % phi down
    pts = [pts; repmat(obst(i,1),length(s_theta),1), s_theta];
    
    % theta up
    pts = [pts; s_phi, repmat(obst(i,4),length(s_phi),1)];
    
    % theta down
    pts = [pts; s_phi, repmat(obst(i,3),length(s_phi),1)];
end

if ~isempty(pts)
    [cx, cy] = pt_drawer_pre(pts);
    scatter(cx, cy, '.', 'MarkerEdgeColor', [.6 .6 .6]);
end



if flg
%     rectangle('Position', [-1.1 -1.1 2.2 2.2], 'EdgeColor', [1 .5 .5], 'LineWidth', 0.1); hold on;
    axis([-1 1 -1 1]);
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


function s = step(lower, upper, n)

s = (upper - lower) / (n-1);

end

