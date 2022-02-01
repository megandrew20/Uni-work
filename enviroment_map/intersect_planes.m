function [t, index] = intersect_planes(r0, rn, P)
% every row of C contains [Xc Yc Zc R Cr Cg Cb]

t = Inf; index = 0;

for i=1:size(P,1);
    A=P(i,1)*r0(1,1);
    B=P(i,2)*r0(1,2);
    C=P(i,3)*r0(1,3);
    D=P(i,4);
    
    Ad= P(i,1)*rn(1,1);
    Bd= P(i,2)*rn(1,2);
    Cd= P(i,3)*rn(1,3);
    Dd= P(i,4);
    
    if Ad + Bd + Cd ~= 0
        x1 = -(A + B + C + D) /(Ad + Bd + Cd);
            if x1>=0
                % x1 is the nearest intersection
                if x1 < t
                    t = x1; index = i;
                end
            end        
    end
        
    end
end