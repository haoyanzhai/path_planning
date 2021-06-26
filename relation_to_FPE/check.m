function grad_or_diff = check( G, current )
% This is for final.m

current_p = G.p(current);
neighbor = G.idx{current};
neighbor_p = G.p(neighbor);
tmp = find(neighbor_p < current_p, 1);
grad_or_diff = ~isempty(tmp);
% tmp_d = G.d{current};
% grad_or_diff = false;
% for i = 1 : length(tmp)
%     x = neighbor(tmp(i));
%     gradi_or_diff = grad_or_diff | 
% 
% end

