function [ rho, infl, drho ] = one_step_fp( G, rho0, dt, beta )

rho = zeros(size(rho0));
infl = rho;
[F1, F2] = free_energy(rho0, G.p, beta);

for i = 1 : G.n
    idx = G.idx{i};
    d = G.d{i}';
    d = ones(size(G.d{i}'));
    rho(i) = rho0(i) + dt * (sum(rho0(idx) .* max(d.*(F1(idx) - F1(i)) + (F2(idx) - F2(i)), 0)) ...
             - rho0(i) * sum(max(d.*(F1(i) - F1(idx)) + (F2(i) - F2(idx)), 0)));
%     infl(i) = sum(rho0(idx) .* max(F(idx) - F(i), 0));
end

drho = rho - rho0;

end

function [ F1, F2 ] = free_energy( rho, V, beta )

if beta == 0
    F2 = 0 * rho;
else
    F2 = beta * log(rho);
end

% F2 = beta * log(ones(size(rho)));
F1 = V;

end
