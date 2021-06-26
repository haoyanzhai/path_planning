function [ interior, exterior, exclude ] = find_neigbor( G, interior, exterior, idx, drho )

interior = union(interior, idx);
exterior = union(exterior, G.idx{idx});
exterior = setdiff(exterior, interior);
exclude = find(drho < 0);
exclude = [];

end

