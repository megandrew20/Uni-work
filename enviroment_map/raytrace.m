function [intensity] = raytrace(s,vect,SCENE,depth)

% there is a limit to how deep we are prepared to go recursively
if depth>2
    intensity = [0 0 0];%SCENE{2}; % background, but should be something that stands out
    return
end

% try to process intersections
[t1, si] = intersect_spheres(s,vect,SCENE{1}); % e.g. spheres
[t2, int2] = intersect_planes(s,vect,SCENE{5});%,SCENE{3}) % e.g. planes
%[t3, int3] = intersections(s,vect,SCENE{5},SCENE{3}) % e.g. triangles

if t1<Inf && t1<t2 %&& t1<t3
    % process intersection with a sphere
    spheres = SCENE{1};
    ip1 = s + t1*vect;
    
    temp = ip1-spheres(si,1:3); n1 = temp/norm(temp);
    int1 = local_illumunation(ip1 + 1E-12*n1,n1,-vect,SCENE{3},spheres(si,8:10),spheres(si,5:7), SCENE{4}, SCENE);
    
    rft = -2.*n1.*(dot(n1,vect)) + vect;  % compute reflection ray to the sphere si at ip1
    intrf=raytrace(ip1 + 1E-12*n1,rft,SCENE,depth+1);
    %local_illumunation(ip1,rft,-vect,SCENE{3},spheres(si,8:10),spheres(si,5:7));
    
    %ix=0.6;
    %trans= ((ix*(dot(n1,vect)))-sqrt(1-((ix^2)*((dot(n1,vect)).^2))))*n1 -ix*vect ;%      % compute transmitted normal to the sphere si at ip1
    %inttr=local_illumunation(ip1,trans,-vect,SCENE{3},spheres(si,8:10),spheres(si,5:7));

    %int1 = ambient_diffuse_and_specular(ip1, n1, spheres(si,:), lights); % spheres(si,:) is describing surface properties
    %intensity = int1 + spheres(si,8)*raytrace(ip1 + 1E-12*n1,n1,SCENE,depth+1) ...
    %    +spheres(si,9)*raytrace(ip1 + 1E-12*t1,t1,SCENE,depth+1);
    
    intensity = int1+0.4*intrf;%+inttr; % diffusive term

elseif t2<Inf %&& t2<t3
    % process intersection with a plane
    planes = SCENE{5};
    ip1 = s + t2*vect;
    if mod(round(ip1(1)/4)+round(ip1(3)/4),2)==1
        checkercol=planes(int2,5:7);
    else
        checkercol=planes(int2,8:10);
    end
    
    n1 = planes(int2,1:3);
    int1 = local_illumunation(ip1 + 1E-12*n1,n1,-vect,SCENE{3},planes(int2,11:13),checkercol, SCENE{4}, SCENE);
    
    rft = -2.*n1.*(dot(n1,vect)) + vect;  % compute reflection ray to the sphere si at ip1
    intrf=raytrace(ip1 + 1E-12*n1,rft,SCENE,depth+1);
    %local_illumunation(ip1,rft,-vect,SCENE{3},spheres(si,8:10),spheres(si,5:7));
    
    %ix=0.6;
    %trans= ((ix*(dot(n1,vect)))-sqrt(1-((ix^2)*((dot(n1,vect)).^2))))*n1 -ix*vect ;%      % compute transmitted normal to the sphere si at ip1
    %inttr=local_illumunation(ip1,trans,-vect,SCENE{3},spheres(si,8:10),spheres(si,5:7));

    %int1 = ambient_diffuse_and_specular(ip1, n1, spheres(si,:), lights); % spheres(si,:) is describing surface properties
    %intensity = int1 + spheres(si,8)*raytrace(ip1 + 1E-12*n1,n1,SCENE,depth+1) ...
    %    +spheres(si,9)*raytrace(ip1 + 1E-12*t1,t1,SCENE,depth+1);
    
    intensity = int1; %+1*intrf;%+inttr; % diffusive term
    
    
    
%elseif t3<Inf
    % process intersection with a triangle
    
else
    % no intersection found
    %intensity = SCENE{2}; % background
    intensity = intersect_envcube_crude(s,vect,SCENE);
end

end

