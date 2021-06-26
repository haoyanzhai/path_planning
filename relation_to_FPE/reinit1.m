function [ rho, beta, flg ] = reinit1( G, exterior, idx, rho, beta, gradient_beta, diffusion_beta, flg, new_add )
% flg: 1 diffusion, 0 gradient

p = G.p(new_add);
neighbor = G.idx{new_add};
p_neighbor = G.p(neighbor);
down_cand = neighbor(p_neighbor < p);

if ~isempty(down_cand) && isempty(intersect(down_cand,idx)) && flg == 1
    rho(:)=1e-4;
    rho(new_add) = 1;
    rho = rho / sum(rho);
    beta = gradient_beta;
    flg = 0;
    fprintf('reinit gradient\n');
    waitforbuttonpress
    return
end

if isempty(down_cand) && flg == 0
    rho(:)=1e-4;
    rho(new_add) = 1;
    rho = rho / sum(rho);
    beta = diffusion_beta;
    flg = 1;
    fprintf('reinit diffusion\n');
%     waitforbuttonpress
    return
end

end

