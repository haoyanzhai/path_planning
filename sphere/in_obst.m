function in = in_obst( x, obst )
% obst = [lower phi, upper phi, lower theta, upper theta]

in = (x(:,1)<pi/16) | (x(:,1)>=pi/2);
% in = (x(:,1)<pi/7) | (x(:,1)>=pi/2);
for i = 1 : size(obst, 1)
    in = in | (x(:,1)>obst(i,1) & x(:,1)<obst(i,2) & x(:,2)>obst(i,3) & x(:,2)<obst(i,4));
end

end

