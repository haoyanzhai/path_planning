classdef pt
    
    properties
        coord
    end
    
    methods
        function this = pt(val)
            this.coord = val;
        end
        
        % pt1 = pt2: 1
        % pt1 ~= pt2: 0
        function r = equal(pt1, pt2)
            dif = abs(pt1.coord - pt2.coord);
            r = ~(sum(dif > 1e-8) > 0);
        end
        
        function r = small(pt1, pt2)
            dif = pt1.coord - pt2.coord;
            x = find(abs(dif) > 1e-8, 1);
            if isempty(x)
                r = 0;
            else
                r = dif(x) < -1e-8;
            end
        end
        
        % small or equal
        % pt1 < pt2: 1
        % pt1 = pt2: -1
        % pt1 > pt2: 0
        function r = soe(pt1, pt2)
            dif = pt1.coord - pt2.coord;
            x = find(abs(dif) > 1e-8, 1);
            if isempty(x)
                r = -1;
            else
                r = dif(x) < -1e-8;
            end
        end
        
        function print(this)
            fprintf(mat2str(this.coord));
            fprintf('\n');
        end
    end
    
end

