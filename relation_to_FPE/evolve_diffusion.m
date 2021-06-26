function [ tphi, idx ] = evolve_diffusion( G, current, phi, obst )

tphi = phi;
tphi(current) = 1;
done = false;

p = G.p;
p(tphi==1) = Inf;

idx = find(tphi==1);
cand = [];
for i = 1 : length(idx)
    cand = union(cand, G.idx{idx(i)});
end

while ~done
    
    scatter(G.x(cand,1), G.x(cand,2));
%     waitforbuttonpress
    
    
    tmp_p = p(cand);
    [~, tmp_idx] = min(tmp_p);
    current = cand(tmp_idx);
    tphi(current) = 1;
    cand = union(cand, G.idx{current});
    neighbor = G.idx{current};
    tmp_p = p;
    tmp_p(tphi==1) = Inf;
    neighbor_p = tmp_p(neighbor);
    if ~isempty(find(neighbor_p < p(current), 1))
        done = true;
    end
    fprintf('%f %f %f\n', G.x(current,1), G.x(current,2), p(current));
    p(current) = Inf;
    
end

tmp_p = p(cand);
[~, tmp_idx] = min(tmp_p);
idx = cand(tmp_idx);
% G.x(idx,1)
% G.x(idx,2)

end

