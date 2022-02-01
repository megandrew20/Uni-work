function intensity = intersect_envcube_crude(r0, rn, SCENE)

cube_size = 15;
plane_normals = [  0 -1  0  ; % up
                   1  0  0  ; % left
                   0  0  -1 ; % front
                  -1  0  0  ; % right
                   0  0  1  ; % back
                   0  1  0 ]; % down
plane_points = -cube_size*plane_normals;

intensity = [0 0 0];

for i=1:size(plane_normals,1)
    t = dot(plane_points(i,:)-r0, plane_normals(i,:)) / dot(rn,plane_normals(i,:));
    if t>=0
        ip = r0 + t*rn;
        if plane_normals(i,1)~=0 || (ip(1) >= -cube_size && ip(1) <= cube_size)
            if plane_normals(i,2)~=0 || (ip(2) >= -cube_size && ip(2) <= cube_size)
                if plane_normals(i,3)~=0 || (ip(3) >= -cube_size && ip(3) <= cube_size)
                    % relevant intersection found!
                    intensity = abs(plane_normals(i,:));
                    break
                end
            end
        end
    end
end

switch i
    case 1
        
        [NY, NX, ~] = size(SCENE{7}); % up
        ux = round( 1 + (ip(1)-(-cube_size))/(2*cube_size)*(NX-1) );
        uy = round( 1 + (ip(3)-(-cube_size))/(2*cube_size)*(NY-1) );
        intensity = sqrt(double(reshape(SCENE{7}(uy,ux,1:3),[1,3]))/255);
    case 2

        [NY, NX, ~] = size(SCENE{8}); % left
        ux = round( 1 + (ip(3)+(cube_size))/(2*cube_size)*(NX-1) );
        uy = round( 1 + (cube_size-ip(2))/(2*cube_size)*(NY-1) ); %CHECK MEG
        intensity = sqrt(double(reshape(SCENE{8}(uy,ux,1:3),[1,3]))/255);
    case 3
      
         [NY, NX, ~] = size(SCENE{9}); % front
        ux = round( 1 + (ip(1)+(cube_size))/(2*cube_size)*(NX-1) );
        uy = round( 1 + (cube_size-ip(2))/(2*cube_size)*(NY-1) );
        intensity = sqrt(double(reshape(SCENE{9}(uy,ux,1:3),[1,3]))/255);
   case 4 %right

            [NY, NX, ~] = size(SCENE{10}); % right
         ux = round( 1 + (cube_size-ip(3))/(2*cube_size)*(NX-1) );
        uy = round( 1 + (cube_size-ip(2))/(2*cube_size)*(NY-1) ); 
        intensity = sqrt(double(reshape(SCENE{10}(uy,ux,1:3),[1,3]))/255);

    case 5 %back

         [NY, NX, ~] = size(SCENE{11}); % back
        ux = round( 1 + (-ip(1)+(cube_size))/(2*cube_size)*(NX-1) );
        uy = round( 1 + (cube_size-ip(2))/(2*cube_size)*(NY-1) );
        intensity = sqrt(double(reshape(SCENE{11}(uy,ux,1:3),[1,3]))/255);  
        
    case 6
         [NY, NX, ~] = size(SCENE{12}); % down
        ux = round( 1 + (cube_size-ip(1))/(2*cube_size)*(NX-1) );
        uy = round( 1 + (cube_size-ip(3))/(2*cube_size)*(NY-1) ); 
        intensity = sqrt(double(reshape(SCENE{12}(uy,ux,1:3),[1,3]))/255);
end

