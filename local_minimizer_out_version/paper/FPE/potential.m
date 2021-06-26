function p = potential( pts, t )

% orginal potential
% p = sum((pts - repmat(t, size(pts, 1), 1)).^2, 2);

% euclidean
p = zeros(size(pts, 1), 1);
for i = 1 : 2 : size(pts, 2) - 1
    p = p + sqrt(sum((pts(:,i:i+1) - repmat(t(i:i+1), size(pts, 1), 1)).^2, 2));
end


% max potential
% p = zeros(size(pts, 1), 1);
% for i = 1 : 2 : size(pts, 2) - 1
%     p = max(p, sum((pts(:,i:i+1) - repmat(t(i:i+1), size(pts, 1), 1)).^2, 2));
% end

% W potential


end

