function [ rho, beta, flg ] = reinit( G, exterior, idx, rho, beta, gradient_beta, diffusion_beta, flg, new_add )
% flg: 1 diffusion, 0 gradient

down_cand = [];
real_down_cand = false;
for i = 1 : length(exterior)
    p = G.p(exterior(i));
    neighbor = G.idx{exterior(i)};
    p_neighbor = G.p(neighbor);
    down_cand = union(down_cand, neighbor(p_neighbor < p));
    real_down_cand = real_down_cand | isempty(find(ismember(neighbor(p_neighbor < p), idx), 1));
end
% x = G.x(new_add,:)
% real_down_cand
if real_down_cand && flg == 1
    rho(:)=1e-4;
    rho(new_add) = 1;
    rho = rho / sum(rho);
    beta = gradient_beta;
    flg = 0;
    fprintf('reinit gradient\n');
    waitforbuttonpress
    return
end

if isempty(setdiff(down_cand, idx)) && flg == 0
    rho(:)=1e-4;
    rho(new_add) = 1;
    rho = rho / sum(rho);
    beta = diffusion_beta;
    flg = 1;
    fprintf('reinit diffusion\n');
    waitforbuttonpress
    return
end

end

