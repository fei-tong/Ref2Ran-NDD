% function   [d_array,r2d_cdf,sim_density] = sim_tiered_polygon_R2rand(R,x_cell,y_cell,d_array,h)
function   [d_array,r2d_cdf,sim_density] = sim_tiered_polygon_R2rand(R,x_cell,y_cell,varargin)
% Input:
%   R: reference point R(x_axis,y_axis)
%
%   x_cell: x axis of the vertexes of the ring area and each inner polygon (size:
%                 (n)*1, indicating that it has (n-1) "holes" and 1 ring area)
%   y_cell: y axis of the vertexes of the ring area and each inner polygon (size:
%                 (n)*1, indicating that it has (n-1) "holes" and 1 ring area)
%           The ring's vertexes are contained in the last element of (x_cell,y_cell)
%
%   varargin contains the following two optional arguments:
%       ->d_array: n*1, containing "node densities" of each hole (note that it is
%            not a real node density of the hole, but their ratios indicate
%            the node density ratio among these holes.
%            * Note that the order in this array is corresponding to the
%              order in (x_cell,y_cell)
%       ->h(optional): the height of the reference point R
%
% Call:
%       [d_array,r2d_cdf,sim_density] = sim_tiered_polygon_R2rand(R,x_cell,y_cell,[],h)
%       [d_array,r2d_cdf,sim_density] = sim_tiered_polygon_R2rand(R,x_cell,y_cell,d_array,[])
%       [d_array,r2d_cdf,sim_density] = sim_tiered_polygon_R2rand(R,x_cell,y_cell,d_array,h)
% Output:
%   CDF of the distance between R and a random point within the whole area

if nargin < 3
    error 'This function needs at least 3 arguments.'
end
[n,~] = size(x_cell);
[p,~] = size(y_cell);

if isempty(varargin{1})
    d_array = ones(n,1);
else
    d_array = varargin{1};
end

if isempty(varargin{2})
    h = 0;
else
    h = varargin{2};
end

[q,~] = size(d_array);
if n ~= p || n ~= q
    error 'The numbers of holes contained in the arguments are not consistent'
end

if all(d_array==0)
    error 'All densities are zero.'
end

s = zeros(n,1); % area array
density_ratio = zeros(n,1);
counter_array = zeros(n,1);
for i = 1 : n
    s(i) = shoelace(x_cell{i,1},y_cell{i,1});
end

for i = 1 : n
    density_ratio(i) = s(i)*d_array(i)/(s'*d_array);
    if i ~= 1
        density_ratio(i) = density_ratio(i) + sum(density_ratio(1:i-1));
    end
end

max_iter = 20000;
count = 0;
distance_in_sim=zeros(1,max_iter); % distance of two random points with a triangle

x_length = max(cellfun(@max,x_cell)) - min(cellfun(@min,x_cell));
y_length = max(cellfun(@max,y_cell)) - min(cellfun(@min,y_cell));

while count < max_iter
    % generage the 1st random point
    rand_density_ratio = rand;
    for i = 1:n
        if rand_density_ratio < density_ratio(i)
            if i ~= n
                while 1
                    rand_x1 = min(cellfun(@min,x_cell)) + x_length*rand(1);
                    rand_y1 = min(cellfun(@min,y_cell)) + y_length*rand(1);
                    IN = inpolygon(rand_x1,rand_y1,x_cell{i,1},y_cell{i,1});
                    if IN == 1
                        break;
                    end
                end
            else % i==n, the last one is the ring area
                while 1
                    rand_x1 = min(cellfun(@min,x_cell)) + x_length*rand(1);
                    rand_y1 = min(cellfun(@min,y_cell)) + y_length*rand(1);
                    IN = inpolygon(rand_x1,rand_y1,x_cell{n,1},y_cell{n,1});
                    IN2 = zeros(n-1,1); % totally, there are n-1 inner holes
                    for j = 1:n-1
                        IN2 = inpolygon(rand_x1,rand_y1,x_cell{j,1},y_cell{j,1});
                    end
                    if IN == 1 && all(IN2 == 0)
                        break;
                    end
                end
            end
            counter_array(i) = counter_array(i)+1;
            break;
        end
    end    
    % calculate the distance from the reference point R to the random point
    RandPoint=[rand_x1,rand_y1];
    dist = norm(RandPoint-R);%sqrt((x1-V(1))^2+(y1-V(2))^2);
    count = count + 1;
    distance_in_sim(count)=sqrt(h^2+dist^2);
end
sim_density = counter_array./s;

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