function y = geo( x, l )

phi = x(1);
theta = x(2);

dphi = l / (2*pi);
dtheta = l / (2*pi*sin(phi));
y = [phi+dphi, theta; phi-dphi, theta; phi, mod(theta+dtheta,2*pi); phi, mod(theta-dtheta,2*pi)];

end

