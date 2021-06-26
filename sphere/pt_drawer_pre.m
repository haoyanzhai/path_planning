function [cx, cy ] = pt_drawer_pre( x )
% x = (phi_i theta_i) nx2 matrix

cx = sin(x(:,1)) .* cos(x(:,2));
cy = sin(x(:,1)) .* sin(x(:,2));

end

