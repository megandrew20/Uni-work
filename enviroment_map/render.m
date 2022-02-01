clc;

amb_lighting = 0.7; %constant for whole image
background = [0 0 0]; %background colour
gamma = 2; %[1./2.2]; %gamma constant for tone correction

%spheres = [ Xc Yc Zc R Cr Cg Cb Kdiffuse Kspec Kn_spec (for surface)];
spheres = [] %0 -6.9 15   7   0.9 0.9 0.9   0.8 0.3  100 ];
         %   0 0 -4    2.5   1 0 0     0.5 0.8 100 ];

%planes = [ A B C D    Cr Cg Cb  Cr Cg Cb     Kdiffuse Kspec Kn_spec (for surface)];

planes = [];% 0 0 1 20    1 1 0 1 0 0   1 0 100 ];
%planes = [ 0 1 0 15     1 1 0    1 0 0   1 0  100 ];
         
%planes = [ 1  1 1 -20     1 1 0    0.75 0.5  1000 ]; %if have one minus for
%D doesn't work because colour  would be negitive and for gamma can't do complex number. 

%planes = [ 0  1 0 -3     1 1 0    1 1  100 ]; this works though?


%light_sources = [ Xc Yc Zc Intentisity_of_light_source] 

light_sources = [] %-15 10 -6 0.1];
                %13 12 -10 1];

posy = imread('posy.jpg'); % up
negx = imread('negx.jpg'); % left
posz = imread('posz.jpg'); % front
    posx = imread('posx.jpg'); % right
    negz = imread('negz.jpg'); % back
negy = imread('negy.jpg'); % down

SCENE = { spheres, background, light_sources, amb_lighting, planes, gamma, posy, negx, posz, posx, negz, negy};

point= [0 0 19];  %observer -5

%grid
nx=25*90+1; x=1*8; 
ny=25*60+1; y=1*5;

xd = linspace(-x,x,nx); 
yd = linspace(-y,y,ny);

%vector to hold all values
bitmap=zeros(ny,nx,3);

%each point on grid dimentions
%i = 136; j = 91;
for i= 1:nx
    for j= 1:ny
         %ray vector computed
         s = [xd(i),yd(j),0];
         vect = (s - point)/norm(s - point);
         
         bitmap(j,i,:) = raytrace(point,vect,SCENE,1)';
    end
end

image(xd,yd,(bitmap).^gamma); axis image
set(gca,'YDir','normal')