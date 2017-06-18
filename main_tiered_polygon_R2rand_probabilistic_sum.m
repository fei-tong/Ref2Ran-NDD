clc
clear

%% to generate polygons
% clc;
% clear;
sim_mark='r*';
a = 4;
b = 2;
% node_num = 3;
% sim_times = 1000; 

A = [0 0]; B = [0 a]; C = [a a]; D = [a 0];
E = [(a-b)/2 (a-b)/2]; F = [(a-b)/2 b+(a-b)/2]; G = [b+(a-b)/2 b+(a-b)/2]; H = [b+(a-b)/2 (a-b)/2];
M = [0 0];
E = E-M;
F = F-M;
G = G-M;
H = H-M;


% use x1 and y1 denote the rectangle that just encompasses the whole
% outside square; 
x1 = a; y1 = a;
% outside square vertices
xv = [A(1) B(1) C(1) D(1)];
yv = [A(2) B(2) C(2) D(2)];

figure(1);
line([xv A(1)],[yv A(2)]);
text(A(1),A(2),'A');
text(B(1),B(2),'B');
text(C(1),C(2),'C');
text(D(1),D(2),'D');
% inside square vertices
xv1 = [E(1) F(1) G(1) H(1)];
yv1 = [E(2) F(2) G(2) H(2)];
line([xv1 E(1)],[yv1 E(2)]);
line([A(1) E(1)],[A(2) E(2)]);
text(E(1),E(2),'E');
text(F(1),F(2),'F');
text(G(1),G(2),'G');
text(H(1),H(2),'H');


% text(0.5,3.5,'S3');
text(2,2,'S1');
text(3.5,2,'S2');
text(0,4.5,'S');
axis equal;
axis([-1 5 -1 5]);
figure(2);
% the ring (x,y) coordinates:
xv_ring = [A(1) B(1) C(1) D(1) A(1) E(1) H(1) G(1) F(1) E(1)];
yv_ring = [A(2) B(2) C(2) D(2) A(2) E(2) H(2) G(2) F(2) E(2)];
% xv_ring = [A(1) B(1) C(1) D(1) A(1) E(1) H(1) I(1) L(1) K(1) J(1) I(1) H(1) G(1) F(1) E(1)];
% yv_ring = [A(2) B(2) C(2) D(2) A(2) E(2) H(2) I(2) L(2) K(2) J(2) I(2) H(2) G(2) F(2) E(2)];

height = 5;
d1=10;% the density of the inner square
d2=1;% the density of the ring
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R = [-1 -1];
% A is set to R, for the polygon (xv1,yv1)
% [d_array1,r2d_cdf1] = sim_polygon_R2rand(R,xv1,yv1,height); %simulation
% R_S=plot(d_array1,r2d_cdf1,sim_mark); % R_S: small square
% hold on;
[ r_array1, cdf_array1 ] = cdf_Polygon_R2rand( R,xv1,yv1,height);%approach
% plot(r_array1,cdf_array1);

% A is set to R, for the polygon (xv,yv)
% [d_array,r2d_cdf] = sim_polygon_R2rand(R,xv,yv,height); %simulation
% R_L=plot(d_array,r2d_cdf,'b*');% R_L: large square
[ r_array, cdf_array ] = cdf_Polygon_R2rand( R,xv,yv,height);%approach
% plot(r_array,cdf_array);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%to calculate the ref2rand within the intersection area; S2
s = shoelace(xv,yv);
s1 = shoelace(xv1,yv1);
% s2 = s-s1
s2 = shoelace(xv_ring,yv_ring);

%% % probability sum
% cdf_array2 = zeros(1,length(r_array));
% for i = 1 : length(r_array)
%     if i > length(cdf_array)
%         d_F = 1;
%     else
%         d_F = cdf_array(i);
%     end
%     
%     if i > length(cdf_array1)
%         d_F1 = 1;
%     else
%         d_F1 = cdf_array1(i);
%     end
%     
% %     cdf_array2(i) = ((s1+density_ratio*s2)*d_F - s1*d_F1)/(density_ratio*s2);
%     cdf_array2(i) = (s*d_F - s1*d_F1)/s2;
% end
%%
[ r_array2, cdf_array2 ] = cdf_Polygon_R2rand( R,xv_ring,yv_ring,height);%approach

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
hold on;
[d_array2,r2d_cdf2,sim_d1,sim_d2] = sim_polygon_R2rand(R,xv,yv,xv1,yv1,d1,d2,height); %simulation

R_R=plot(d_array2,r2d_cdf2,'k*'); % R_R: ring

%==========================================
box on;
% axis([0 1.0 0 1.0]);
xlabel('Distance','fontsize',16);
ylabel('CDF','fontsize',16);

% AX = legend([R_S R_L R_R],'CDF1(To the inner square)','CDF(To the outer square)','CDF2(To the ring)',2);
AX = legend([R_R],'to the whole area',2);
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',16);
% axis([-2 8 0 1]);
grid on;