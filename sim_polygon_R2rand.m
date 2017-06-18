% function   [d_array,r2d_cdf] = sim_polygon_R2rand_nonuniform(R,x,y,x1,y1,h,density_ratio)
function   [d_array,r2d_cdf,sim_d1,sim_d2] = sim_polygon_R2rand(R,x,y,x1,y1,d1,d2,h)
% Input:
%   R : R(x,y), an arbitrary reference point
%   x,y : vectors of points, describing points in the plane as
%        (x,y) pairs. x and y must be the same lengths.
%   x1,y1 (optional) - vertices of a hole polygon
%   d1,d2 (optional) - d2/d1 (d1!=0) (or d1/d2, d2!=0) reflects the ratio of the node density
%       in the ring (inner) area to the node density in the inner (ring) area
%   h (optional): the height of the reference point R
%
% Output: CDF of the distance from R to a random point within
%           the polygon (x,y), i.e., [d_array,r2d_cdf]
%         sim_d1,sim_d2 (optional): the simulated node densities in
%           area (x1,y1) and the ring area, respectively.
%
% Author: FEI TONG
% Date: May. 2, 2016

if nargin < 3
    error 'This function needs at least 3 arguments.'
end

if nargin >= 7 && d1==d2 && d1==0
    error 'Both d1 and d2 are zero.'
end

max_iter = 10000;
count = 0;
distance_in_sim=zeros(1,max_iter); % distance of two random points with a triangle

x_length = max(x) - min(x);
y_length = max(y) - min(y);
% area = shoelace(xv,yv)
if (nargin == 3) || (nargin == 5) || (nargin == 7) % no h, i.e.,(R,x,y), (R,x,y,x1,y1), or (R,x,y,x1,y1,d1,d2)
    h = 0;
elseif nargin == 6 % (R,x,y,x1,y1,h)
    h = d1;
elseif nargin == 4 % (R,x,y,h)
    h = x1;
end

if nargin > 6
    s = shoelace(x,y);
    s1 = shoelace(x1,y1);
    s2 = s-s1;
    count1=0;
    count2=0;
end
while count < max_iter
    % generage the 1st random point
    density_ratio = rand;
    if nargin <= 6 % (R,x,y), (R,x,y,h), (R,x,y,x1,y1), or (R,x,y,x1,y1,h)
        while 1
            rand_x1 = min(x) + x_length*rand(1);
            rand_y1 = min(y) + y_length*rand(1);
            IN = inpolygon(rand_x1,rand_y1,x,y);
            if (nargin == 3) || (nargin == 4) % no x1 or y1, i.e., (R,x,y) or (R,x,y,h)
                if IN == 1
                    break;
                end
            elseif (nargin == 5) || (nargin == 6) % (R,x,y,x1,y1) or (R,x,y,x1,y1,h)
                IN2 = inpolygon(rand_x1,rand_y1,x1,y1);
                if IN == 1 && IN2~=1
                    break;
                end
            end
        end
    else % (R,x,y,x1,y1,d1,d2) or (R,x,y,x1,y1,d1,d2,h)
        if density_ratio < d1*s1/(d1*s1+d2*s2) % the point is in the inner square
            while 1
                rand_x1 = min(x) + x_length*rand(1);
                rand_y1 = min(y) + y_length*rand(1); 
                IN = inpolygon(rand_x1,rand_y1,x1,y1);
                if IN == 1
                    count1=count1+1;
                    break;
                end
            end
        else % the point is in the ring
            while 1
                rand_x1 = min(x) + x_length*rand(1);
                rand_y1 = min(y) + y_length*rand(1); 
                IN = inpolygon(rand_x1,rand_y1,x,y);
                IN2 = inpolygon(rand_x1,rand_y1,x1,y1);
                if IN == 1 && IN2~=1
                    count2=count2+1;
                    break;
                end
            end
        end
    end
    % calculate the distance from the reference point R to the random point
    RandPoint=[rand_x1,rand_y1];
    dist = norm(RandPoint-R);%sqrt((x1-V(1))^2+(y1-V(2))^2);
    count = count + 1;
    distance_in_sim(count)=sqrt(h^2+dist^2);
end

if nargin > 6
    sim_d1 = count1/s1;
    sim_d2 = count2/s2;
end

[cc,x_array] = ecdf(distance_in_sim);% from simulation
point_num = 40;
r2d_cdf = zeros(1,point_num);
d_array = zeros(1,point_num);
tick = int32(length(x_array)/point_num);
for i =1:point_num
    next = i*tick;
    if next >length(x_array)
        next = length(x_array);
        d_array(i) = x_array(next);
        r2d_cdf(i) = cc(next);
        break;
    end
    d_array(i) = x_array(next);
    r2d_cdf(i) = cc(next);
end

end