% The function is for generating a triangle
% Input parameters: 3 angles ([0,180]): alpha,beta,gamma
%             the lenght of the opposite edge of angle beta: a
% Output: three decreasing angles: X,Y,Z
%         three edge lengths: a,b,c
%         three altitudes: h_a, h_b, h_c
%         three vertices: A,B,C
%
% Author: FEI TONG
% Date: Apr. 28, 2016

function [X,Y,Z,a,b,c,h_a,h_b,h_c,A,B,C]=gen_triangle(alpha,beta,gamma,a)
%sort the angle: X >= Y >= Z
X = alpha; Y = beta; Z = gamma;
if beta > X
    X = beta; Y =alpha;
elseif gamma > X;
    X = gamma; Z = alpha;
end
if Y < Z
    temp = Y;
    Y=Z;
    Z=temp;
end

X=X*pi/180; Y=Y*pi/180; Z=Z*pi/180;
h_b=a*sin(Z); h_c=a*sin(Y);
if X <= pi/2
    b=h_c/sin(X); c=h_b/sin(X);
else
    b=h_c/sin(pi-X); c=h_b/sin(pi-X);
end
h_a = b*sin(Z); 
A = [b*cos(Z) h_a];
B = [a 0];
C = [0 0];

% plot the triangle
figure(1);
plot([A(1) B(1)],[A(2) B(2)]);
hold on;
plot([C(1) B(1)],[C(2) B(2)]);
plot([A(1) C(1)],[A(2) C(2)]);
figure(2);
end