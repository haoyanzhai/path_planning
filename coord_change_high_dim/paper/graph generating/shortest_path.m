function path = shortest_path( G )

% get adjacency matrx
M = zeros(G.n);
for i = 1 : G.n
    M(i, G.idx{i}) = 1;
end

[~, path, ~] = graphshortestpath(sparse(M), 2, 1, 'Method', 'Dijkstra');
path = G.x(path, :);

end

