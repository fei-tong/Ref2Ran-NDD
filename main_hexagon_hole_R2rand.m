clc
clear
sim_mark='r*';

%% hexagon
a = 5;
A_1 = 30*pi/180;
A_2 = 60*pi/180;
A_3 = 90*pi/180;
A_4 = 120*pi/180;
A_5 = 150*pi/180;
b = a/2;
c = a*sqrt(3)/2;

A = [0 b*sqrt(3)/2]; B = [b/2 c]; C = [b*3/2 c]; 
D = [a b*sqrt(3)/2]; E = [b*3/2 0]; F = [b/2 0];
xv = [A(1) B(1) C(1) D(1) E(1) F(1)];
yv = [A(2) B(2) C(2) D(2) E(2) F(2)];
%%
a = 4;
b = 2;
% A = [0 0]; B = [0 a]; C = [a a]; D = [a 0];
G = [(a-b)/2 (a-b)/2]; H = [(a-b)/2 b+(a-b)/2]; I = [b+(a-b)/2 b+(a-b)/2]; J = [b+(a-b)/2 (a-b)/2];
xv1 = [G(1) H(1) I(1) J(1)];
yv1 = [G(2) H(2) I(2) J(2)];
line([xv1 G(1)],[yv1 G(2)]);
line([A(1) G(1)],[A(2) G(2)]);
% xv2 = [A(1) B(1) C(1) D(1) E(1) F(1) A(1) G(1) J(1) I(1) H(1) G(1)];
% yv2 = [A(2) B(2) C(2) D(2) E(2) F(2) A(2) G(2) J(2) I(2) H(2) G(2)];

xv2 = [A(1) F(1) E(1) D(1) C(1) B(1) A(1) G(1) H(1) I(1) J(1) G(1)];
yv2 = [A(2) F(2) E(2) D(2) C(2) B(2) A(2) G(2) H(2) I(2) J(2) G(2)];

figure(1);
hold on;
n = length(xv);
for i = 1 : n
    j = i;
    if i == n
        k = 1;
    else
        k = i+1;
    end
    plot([xv(j) xv(k)],[yv(j) yv(k)]);
%     plot([A(1) B(1)],[A(2) B(2)]);
end
text(A(1),A(2),'A');
text(B(1),B(2),'B');
text(C(1),C(2),'C');
text(D(1),D(2),'D');
text(E(1),E(2),'E');
text(F(1),F(2),'F');
text(G(1),G(2),'G');
text(H(1),H(2),'H');
text(I(1),I(2),'I');
text(J(1),J(2),'J');
figure(2);
%%
height = 3;

% d1,d2 - d2/d1 (d1!=0) (or d1/d2, d2!=0) reflects the ratio of the node density
%       in the ring (inner) area to the node density in the inner (ring) area
d2 = 5;
d1 = 1;
s = shoelace(xv,yv);
s1 = shoelace(xv1,yv1);
s2 = s-s1;
shoelace(xv2,yv2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A is set to R
R = A;

% Get the Ref2Rand CDF associated with the inner area with the same density
[ ~, cdf_array1 ] = cdf_Polygon_R2rand( R,xv1,yv1,height);%approach
%Get the Ref2Rand CDF associated with the ring area with the same density
[ ~, cdf_array2 ] = cdf_Polygon_R2rand( R,xv2,yv2,height);

%Get the Ref2Rand CDF (just the x array) associated with the whole area with the same density
[ r_array, ~ ] = cdf_Polygon_R2rand( R,xv,yv,height);%approach

cdf_array_nonuniform = zeros(1,length(r_array));
for i = 1 : length(r_array)
    if i > length(cdf_array1)
        d_F1 = 1;
    else
        d_F1 = cdf_array1(i);
    end
    if i > length(cdf_array2)
        d_F2 = 1;
    else
        d_F2 = cdf_array2(i);
    end
    cdf_array_nonuniform(i) = (s1*d1/(s1*d1+s2*d2))*d_F1 + (s2*d2/(s1*d1+s2*d2))*d_F2;
end
plot(r_array,cdf_array_nonuniform,'r-');
hold on;
[d_array2,r2d_cdf2,sim_d1,sim_d2] = sim_polygon_R2rand(R,xv,yv,xv1,yv1,d1,d2,height); %simulation
R_A=plot(d_array2,r2d_cdf2,'r*');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% R is an interior point
R = [0.5 0.4];
[ r_array1, cdf_array1 ] = cdf_Polygon_R2rand( R,xv1,yv1,height);%approach
% RB = c; RC = b; BC = a;
% [ r_array, cdf_array ] = cdf_triangle_vertex2rand( RB,RC,BC );
[ r_array2, cdf_array2 ] = cdf_Polygon_R2rand( R,xv2,yv2,height);
% plot(r_array,cdf_array);
[ r_array, ~ ] = cdf_Polygon_R2rand( R,xv,yv,height);%approach

cdf_array_nonuniform = zeros(1,length(r_array));
for i = 1 : length(r_array)
    if i > length(cdf_array1)
        d_F1 = 1;
    else
        d_F1 = cdf_array1(i);
    end
    if i > length(cdf_array2)
        d_F2 = 1;
    else
        d_F2 = cdf_array2(i);
    end
    cdf_array_nonuniform(i) = (s1*d1/(s1*d1+s2*d2))*d_F1 + (s2*d2/(s1*d1+s2*d2))*d_F2;
end
plot(r_array,cdf_array_nonuniform,'b-');
[d_array2,r2d_cdf2,sim_d1,sim_d2] = sim_polygon_R2rand(R,xv,yv,xv1,yv1,d1,d2,height); %simulation
R_I=plot(d_array2,r2d_cdf2,'b*');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% R is an exterior point
R = [0 0];
[ r_array1, cdf_array1 ] = cdf_Polygon_R2rand( R,xv1,yv1,height);%approach
% RB = c; RC = b; BC = a;
% [ r_array, cdf_array ] = cdf_triangle_vertex2rand( RB,RC,BC );
[ r_array2, cdf_array2 ] = cdf_Polygon_R2rand( R,xv2,yv2,height);
% plot(r_array,cdf_array);
[ r_array, ~ ] = cdf_Polygon_R2rand( R,xv,yv,height);%approach

cdf_array_nonuniform = zeros(1,length(r_array));
for i = 1 : length(r_array)
    if i > length(cdf_array1)
        d_F1 = 1;
    else
        d_F1 = cdf_array1(i);
    end
    if i > length(cdf_array2)
        d_F2 = 1;
    else
        d_F2 = cdf_array2(i);
    end
    cdf_array_nonuniform(i) = (s1*d1/(s1*d1+s2*d2))*d_F1 + (s2*d2/(s1*d1+s2*d2))*d_F2;
end
plot(r_array,cdf_array_nonuniform,'k-');
[d_array2,r2d_cdf2,sim_d1,sim_d2] = sim_polygon_R2rand(R,xv,yv,xv1,yv1,d1,d2,height); %simulation
R_E=plot(d_array2,r2d_cdf2,'k*');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================
box on;
% axis([0 1.0 0 1.0]);
xlabel('Distance','fontsize',16);
ylabel('CDF','fontsize',16);

% AX = legend([lkm_based existing sim_based],'LKM-based','Existing Result','Simulation',4);
AX = legend([R_A  R_I R_E],'R is a vertex','R is (0.5,0.4)(interior)','R is (0,0)(exterior)',1);
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',16);
grid on;