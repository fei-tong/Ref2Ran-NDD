% function [ r_array, cdf_array ] = cdf_tiered_polygon_R2rand( R,x_cell,y_cell,d_array,h )
function [ r_array, cdf_array ] = cdf_tiered_polygon_R2rand( R,x_cell,y_cell,varargin )
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
%      -> d_array: n*1, containing "node densities" of each hole (note that it is
%            not a real node density of the hole, but their ratios indicate
%            the node density ratio among these holes.
%            * Note that the order in this array is corresponding to the
%              order in (x_cell,y_cell)
%      -> h(optional): the height of the reference point R
%
% Call:
%       [ r_array, cdf_array ] = cdf_tiered_polygon_R2rand( R,x_cell,y_cell,[],h )
%       [ r_array, cdf_array ] = cdf_tiered_polygon_R2rand( R,x_cell,y_cell,d_array,[] )
%       [ r_array, cdf_array ] = cdf_tiered_polygon_R2rand( R,x_cell,y_cell,varargin )
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

if all(d_array==0)
    error 'All densities are zero.'
end

[q,~] = size(d_array);
if n~=p || n~=q
    error 'The numbers of holes contained in the arguments are not consistent'
end

F = cell(n,1); % cdf array
s = zeros(n,1); % area array
for i = 1 : n
    s(i) = shoelace(x_cell{i,1},y_cell{i,1});
    [ r_array, F{i,1} ] = cdf_Polygon_R2rand( R,x_cell{i,1},y_cell{i,1}, h);
end

cdf_array = zeros(1,length(r_array));
d_F = zeros(n,1);
for i = 1 : length(r_array)
    for j = 1 : n
        if i > length(F{j,1})
            d_F(j) = 1;
        else
            d_F(j) = F{j,1}(i);
        end
        cdf_array(i) = cdf_array(i) + (s(j)*d_array(j)/(s'*d_array))*d_F(j);
    end
end

end

