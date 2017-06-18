function [ polygon_area ] = shoelace( x,y )
% This function is to get the area of an arbitrary polygon
% x: an array containing the x axises of all the vertexes of the polygon
% y: an array containing the y axises of all the vertexes of the polygon
% (x(i),y(i)) is a vertex of the polygon

% Get the number of vertices
n = length(x);
% Initialize the area
polygon_area = 0;
% Apply the formula
for i = 1 : n
    if i == n
        j = 1;
    else
        j = i+1;
    end
    polygon_area = polygon_area + (x(i)*y(j)- x(j)* y(i));%(x(i) + x(i+1)) * (y(i) - y(i+1));
end
polygon_area = abs(polygon_area)/2;
end

