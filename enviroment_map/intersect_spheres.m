function [t, index] = intersect_spheres(r0, rn, S)
% every row of S contains [Xc Yc Zc R Cr Cg Cb]

t = Inf; index = 0;

for i=1:size(S,1)
    a = norm(rn)^2;% actually, always 1
    v = r0 - S(i,1:3);
    b = 2*dot(rn,v);
    c = norm(v)^2 - S(i,4)^2;
    if b^2-4*a*c>=0
        x1 = (-b - sqrt(b^2-4*a*c))/2/a;
        x2 = (-b + sqrt(b^2-4*a*c))/2/a;
        if x2>=0
            if x1>=0
                % x1 is the nearest intersection
                if x1 < t
                    t = x1; index = i;
                end
            else
                % x2 is the nearest intersection
                if x2 < t
                    t = x2; index = i;
                end
            end
        end
    end
end
