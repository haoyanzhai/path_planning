function p = potential( x, t )

phi = x(:,1);
theta = x(:,2);

cx = sin(phi).*cos(theta);
cy = sin(phi).*sin(theta);
cz = cos(phi);

tx = sin(t(1)).*cos(t(2));
ty = sin(t(1)).*sin(t(2));
tz = cos(t(1));

p = 2*pi*acos(cx.*tx + cy.*ty + cz.*tz);

end

