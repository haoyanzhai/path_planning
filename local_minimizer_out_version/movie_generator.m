function [ p, obst, remain ] = movie_generator( path, total_obst, r )
% obst{1} = [];
% remain_obst{1} = total_obst;
rrr = 0.025;
obst{1} = [.725 .300 3.5*rrr 1;
        .725 .350 3*rrr 1;
        .725 .425 rrr 1;
        .725 .450 rrr 1;
        .725 .475 rrr 1;
        .725 .500 rrr 1;
        .725 .525 rrr 1;
        .725 .550 rrr 1;
        .725 .575 rrr 1;
        .725 .600 rrr 1;
        
        .680 .425 rrr 1;
        .680 .450 rrr 1;
        .680 .475 rrr 1;
        .680 .500 rrr 1;
        .680 .525 rrr 1;
        .680 .550 rrr 1;
        .680 .575 rrr 1;
        .680 .600 rrr 1;

        .825 .575 2.5*rrr 1;
        
        .575 1.00 rrr 1;
        .575 .975 rrr 1;
        .575 .950 rrr 1;
        .575 .925 rrr 1;
        .575 .900 rrr 1;
        .575 .875 rrr 1;
        .575 .850 rrr 1;
        .575 .825 rrr 1;
        .575 .800 rrr 1;
        .575 .675 rrr 1;
        .575 .650 rrr 1;
        .575 .625 rrr 1;
        .575 .600 rrr 1;
        .575 .575 rrr 1;
        .575 .550 rrr 1;
        .575 .525 rrr 1;
        .575 .500 rrr 1;
        .575 .475 rrr 1;
        .575 .450 rrr 1;
        .575 .425 rrr 1;
        .575 .400 rrr 1;
        .425 .200 4*rrr 1;
        .500 .500 rrr 1;
        .750 .950 .05 1;
        .850 .750 .05 1;
%         .425 .100 rrr 1;
        .425 .300 rrr 1;
        .425 .325 rrr 1;
        .425 .350 rrr 1];
remain{1} = [.125 .000 rrr 1;
        .425 .100 rrr 1;
        .125 .025 rrr 1;
        .125 .050 rrr 1;
        .125 .075 rrr 1;
        .125 .100 rrr 1;
        .125 .125 rrr 1;
        .125 .150 rrr 1;
        .125 .175 rrr 1;
        .125 .200 rrr 1;
        .125 .225 rrr 1;
        .125 .250 rrr 1;
        .125 .275 rrr 1;
        .675 .075 3*rrr 1;
        .000 .700 rrr 1;
        .025 .700 rrr 1;
        .050 .700 rrr 1;
        .075 .700 rrr 1;
        .350 .600 2*rrr 1;
        .450 .850 2*rrr 1;
        
        .100 .425 rrr 1;
        .100 .475 2*rrr 1;
        .125 .525 rrr 1;
        
        .125 .300 rrr 1;
        .275 1.00 rrr 1;
        .275 .975 rrr 1;
        .275 .950 rrr 1;
        .275 .925 rrr 1;
        .275 .900 rrr 1;
        .275 .875 rrr 1;
        .275 .850 rrr 1;
        .275 .825 rrr 1;
        .275 .675 rrr 1;
        .275 .650 rrr 1;
        .275 .625 rrr 1;
        .275 .600 rrr 1;
        .275 .575 rrr 1;
        .275 .550 rrr 1;
        .275 .525 rrr 1;
        .275 .500 rrr 1;
        .275 .475 rrr 1;
        .275 .450 rrr 1;
        .275 .425 rrr 1;
        .275 .400 rrr 1;
        .275 .375 rrr 1];
    

p{1} = path(1, :);

iter = 2;
for i = 1 : size(path, 1) - 1
    s = path(i, :); t = path(i+1, :);
    for lambda = 0 : 0.5 : 1
        x = (1-lambda)*s + lambda*t;
        if size(remain{iter-1}, 1) ~= 0
            [tobst, tremain_obst, ~] = add_obst(x, remain{iter-1}, obst{iter-1}, r);
        else
            tobst = obst{iter-1};
            tremain_obst = [];
        end
        p{iter} = x;
        obst{iter} = tobst;
        remain{iter} = tremain_obst;
        iter = iter + 1;
    end
end

end

