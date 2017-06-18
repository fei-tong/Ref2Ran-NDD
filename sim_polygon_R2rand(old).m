function   [d_array,r2d_cdf] = sim_polygon_R2rand(R,x,y,x1,y1,h)
% Input:
%   R : R(x,y), an arbitrary reference point
%   x,y : vectors of points, describing points in the plane as
%        (x,y) pairs. x and y must be the same lengths.
%   x1,y1 (optional) - vertices of a hole polygon
%   h (optional): the height of the reference point R
%
% Output: CDF of the distance from R to a random point within
%         the polygon (x,y), i.e., [d_array,r2d_cdf]
%
% Author: FEI TONG
% Date: Apr. 28, 2016

if nargin < 3
    error 'This function needs at least 3 arguments.'
end

max_iter = 10000;
count = 0;
distance_in_sim=zeros(1,max_iter); % distance of two random points with a triangle

x_length = max(x) - min(x);
y_length = max(y) - min(y);
% area = shoelace(xv,yv)
if (nargin == 3) || (nargin == 5) % no h, i.e.,(R,x,y) or (R,x,y,x1,y1)
    h = 0;
elseif nargin == 4
    h = x1;
end
while count < max_iter
    % generage the 1st random point
    while 1
        rand_x1 = min(x) + x_length*rand(1);
        rand_y1 = min(y) + y_length*rand(1); % h_a is the altitude from point A to edge BC
        IN = inpolygon(rand_x1,rand_y1,x,y);
        if (nargin == 3) || (nargin == 4) % no x1 or y1, i.e., (R,x,y) or (R,x,y,h)
            if IN == 1
                break;
            end
        else
            IN2 = inpolygon(rand_x1,rand_y1,x1,y1);
            if IN == 1 && IN2~=1
                break;
            end
        end
    end 
    RandPoint=[rand_x1,rand_y1];
    dist = norm(RandPoint-R);%sqrt((x1-V(1))^2+(y1-V(2))^2);
    count = count + 1;
    distance_in_sim(count)=sqrt(h^2+dist^2);
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