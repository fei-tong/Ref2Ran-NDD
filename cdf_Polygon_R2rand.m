function [ r_array, cdf_array ] = cdf_Polygon_R2rand( R,x,y, h)
% This fuction is developed based on our uvicspace report:
%   https://dspace.library.uvic.ca//handle/1828/5134
% and a paper which proposes the exteded shoelace formula (also based on our above report):
%   "Computing Exact Closed-Form Distance Distributions in Arbitrarily Shaped Polygons with Arbitrary Reference Point"
%       from: http://users.cecs.anu.edu.au/~Salman.Durrani/software.html
% Input:
    % R: an arbitrary reference point
    % r: the radius of the circle (c) centered at R.
    % x: an array containing the x axises of all the vertexes of the polygon
    % y: an array containing the y axises of all the vertexes of the polygon
    % h(optional): the height of the reference point R
%
% Author: FEI TONG
% Date: Apr. 28, 2016

if nargin < 3
    error 'This function needs at least 3 arguments.'
end

polygon_area  = shoelace( x,y ); % the area of the polgyon
% polygon_area = 3/2*sqrt(3)*0.5^2
n = length(x); % Get the number of vertices
v = [x' y'];

max_d = 0;

for i = 1 : n
    d = norm(R - v(i,:));
    if d > max_d
        max_d = d;
    end
end

delta = 1/1000;
r_array=0:delta:max_d;
% cdf_array = zeros(1,length(r_array));
area = zeros(1,length(r_array));
for i = 1 : n
    % formed triangle
    B = [x(i) y(i)];
    if i == n
        C = [x(1) y(1)];
    else
        C = [x(i+1) y(i+1)];
    end
    s = sign(det([R(1) R(2) 1; B(1) B(2) 1; C(1) C(2) 1])); % get the sign 
    RB = norm(R-B);
    BC = norm(B-C);
    RC = norm(R-C);
    
    for j = 1:length(r_array) 
        r = r_array(j);
        area(j) = area(j) + s * TriangleVertexIntersectionArea(RB,RC,BC,r);
    end
end
cdf_array = abs(area)./polygon_area;

% If the height of the reference point R is h:
% The random variable (rv) D (no height case) has its cdf F_D(d) (0<=d<=max_d). 
% Another rv L=sqrt(h^2+D^2), its cdf is F_L(l) (h<=l<=sqrt(max_d^2+h^2)).
% What's F_L(l)? Below is to get this cdf of L. The detials are shows
% as follows:
%  F_L(l) = Pr(L<=l)
%         = Pr(sqrt(h^2+D^2)<=l) 
%         = Pr(D<=sqrt(l^2-h^2))
%         = F_D(sqrt(l^2-h^2)).
if nargin == 4 % function argument contains h, i.e., ( R,x,y,h)
    l_array = h:delta:sqrt(max_d^2+h^2);
    d_array = sqrt(l_array.^2-h^2);
    l_cdf_array = getPCDF(d_array,r_array,cdf_array,cdf_array,1);
    
    r_array = l_array;
    cdf_array = l_cdf_array;
end

end

