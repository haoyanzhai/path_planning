function in = in_obst( x, obst )

in = ~isempty(find(pdist2(obst(:,1:2), x, 'euclidean') < obst(:,3), 1));

end

