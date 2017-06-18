function [ area ] = TriangleVertexIntersectionArea(RB,RC,BC,r)
% R is the reference point, r is the radius of the circle (c) centered at R.
% This function is to get the area of the intersection between the circle c
% and the triangle RBC.
%
% Author: FEI TONG
% Date: Apr. 28, 2016
if RB == 0 || RC == 0 || BC == 0
    area = 0;
    return;
end

if RB > RC % to ensure RB<=RC
    t = RB;
    RB = RC;
    RC = t;
end

angle_R = acos((RB^2+RC^2-BC^2)/(2*RB*RC));  % angle R
a = angle_R; %alpha
angle_C = acos((RC^2+BC^2-RB^2)/(2*RC*BC));% angle C
h = RC*sin(angle_C); % the length of the altitude from R to BC

u = RB+BC+RC;
s = sqrt(u/2*(u/2-RB)*(u/2-BC)*(u/2-RC)); % area of the triangle RBC

angle_h_R = pi/2-angle_C; % the angle between h and RC

if angle_h_R < angle_R % the inside altitude case
    if r >= 0 && r <= h
        area = a*r^2/2;
    elseif r <= RB
        area = h*sqrt(r^2-h^2)+(a/2-acos(h/r))*r^2;
    elseif r <= RC
        area = h/2*(sqrt(RB^2-h^2) + sqrt(r^2-h^2)) + r^2/2*(a-(acos(h/RB)+acos(h/r)));
    else
        area = s;
    end
else % the outside altitude case
    if r >= 0 && r <= RB
        area = a*r^2/2;
    elseif r <= RC
        area = h/2*(sqrt(r^2-h^2)-sqrt(RB^2-h^2)) + r^2/2*(asin(h/r)-angle_C);
    else
        area = s;
    end
end

end

