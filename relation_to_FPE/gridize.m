function G = gridize( G, l )

e = 1e-3;

for i = 2 : length(G.idx)
    G.idx{i} = [];
end

idx = G.idx{1};
for i = 1 : length(G.idx{1})
    G.idx{idx(i)} = 1;
end

for i = 2 : length(G.idx)
    right = [G.x(i,1)+l G.x(i,2)];
    left = [G.x(i,1)-l G.x(i,2)];
    up = [G.x(i,1) G.x(i,2)+l];
    down = [G.x(i,1) G.x(i,2)-l];
    
    for j = 2 : length(G.idx)
        if norm(right-G.x(j,:)) < e
            G.idx{i} = [G.idx{i} j];
        end
        if norm(left-G.x(j,:)) < e
            G.idx{i} = [G.idx{i} j];
        end
        if norm(up-G.x(j,:)) < e
            G.idx{i} = [G.idx{i} j];
        end
        if norm(down-G.x(j,:)) < e
            G.idx{i} = [G.idx{i} j];
        end
    end
end

end

