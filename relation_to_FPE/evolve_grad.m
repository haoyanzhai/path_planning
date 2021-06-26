function [ tphi, idx, rho ] = evolve_grad( G, current )

dt = 1e-1;
beta = 0.0;
iteration = 300;

rho = zeros(G.n, iteration + 1);
rho(current, 1) = 1;

iter = 1;

while iter <= iteration
    [rho(:, iter+1), ~, ~] = one_step_fp(G, rho(:,iter), dt, beta);
    
    if ~isreal(rho(:,iter+1))
        fprintf('not real\n');
        return
    end
    
    iter = iter + 1;
%     fprintf('%d %f\n', iter, sum(rho(:,iter)));
end

tphi = rho(:,1);
for i = 2 : size(rho, 2)
    tmp = rho(:,i);
    tmp(tmp>0) = 1;
    tphi = tphi | tmp;
end
p = Inf * ones(length(G.p),1);
p(tphi>0) = G.p(tphi>0);
[~, idx] = min(p);

end

