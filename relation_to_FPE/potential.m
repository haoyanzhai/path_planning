function p = potential( pts, t )

% orginal potential
p = sum((pts - repmat(t, size(pts, 1), 1)).^2, 2);


end

