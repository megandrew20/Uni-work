function intensity = local_illumunation(r0, sn, vv, L, SS, color, amb, SCENE)

kd = SS(1); ks = SS(2); n = SS(3);
intensity = amb;
for i=1:size(L,1)
    temp = L(i,1:3)-r0; lv = temp/norm(temp);
    if intersect_spheres(r0+ 1E-12*sn,lv,SCENE{1}) == Inf
        temp = lv + vv; hwv = temp/norm(temp);
        intensity = amb + L(i,4)*(color*kd*dot(lv,sn) + ks*dot(sn,hwv)^n);
    end
end