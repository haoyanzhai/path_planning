classdef bst
    %BST Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        val = []
        left = []
        right = []
        parent = []
    end
    
    methods
        function this = bst(pt)
            this.val = pt;
            this.left = 0;
            this.right = 0;
            this.parent = 0;
        end
        
        function [this, fail] = insert(this, pt)
            [idx, leftc] = get_pos(this, 1, pt);
            if leftc == -1
                fail = true;
                return;
            end
            this.val = [this.val pt];
            fail = false;
            if leftc == 1
                this.left(idx) = length(this.val);
            else
                this.right(idx) = length(this.val);
            end
            this.left = [this.left 0];
            this.right = [this.right 0];
            this.parent = [this.parent idx];
        end
        
        function [idx, left] = get_pos(this, idx, pt)
            tmp = soe(pt, this.val(idx));
            if tmp == 1 % small
                if this.left(idx) ~= 0
                    [idx, left] = get_pos(this, this.left(idx), pt);
                else
                    left = 1;
                end
            elseif tmp == -1 % equal
                idx = 0;
                left = -1;
            else % big
                if this.right(idx) ~= 0
                    [idx, left] = get_pos(this, this.right(idx), pt);
                else
                    left = 0;
                end
            end
        end
        
        function print(this)
            print_p(this, 1);
        end
        
        function print_p(this, idx)
            if idx ~= 0
                print_p(this, this.left(idx));
                this.val(idx).print();
                print_p(this, this.right(idx));
            end
        end
    end
    
end

