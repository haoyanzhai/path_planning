function [ ] = draw_potential_lvl_curve( t )

xy = linspace(0, 1, 100);
[x,y] = meshgrid(xy);
z = sqrt((x-t(1)).^2+(y-t(2)).^2);
contour(x,y,z, 20);

end

