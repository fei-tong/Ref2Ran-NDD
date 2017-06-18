clc
clear

%% to generate polygons
% clc;
% clear;
sim_mark='r*';
a = 4;
b = 1;
% node_num = 3;
% sim_times = 1000; 

A = [0 0]; B = [0 a]; C = [a a]; D = [a 0];
E = [(a-b)/2 (a-b)/2]; F = [(a-b)/2 b+(a-b)/2]; G = [b+(a-b)/2 b+(a-b)/2]; H = [b+(a-b)/2 (a-b)/2];
M = [1 0];
I = E+M;
J = F+M;
K = G+M;
L = H+M;

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
line([H(1) I(1)],[H(2) I(2)]);
text(E(1),E(2),'E');
text(F(1),F(2),'F');
text(G(1),G(2),'G');
text(H(1),H(2),'H');

xv2 = [I(1) J(1) K(1) L(1)];
yv2 = [I(2) J(2) K(2) L(2)];
line([xv2 I(1)],[yv2 I(2)]);
text(I(1),I(2),'I');
text(J(1),J(2),'J');
text(K(1),K(2),'K');
text(L(1),L(2),'L');

text(0.5,3.5,'S3');
text(1,2,'S1');
text(3,2,'S2');
text(0,4.5,'S');
axis equal;
axis([-1 5 -1 5]);
figure(2);
% the ring (x,y) coordinates:
% xv_ring = [A(1) B(1) C(1) D(1) A(1) E(1) H(1) G(1) F(1) E(1)];
% yv_ring = [A(2) B(2) C(2) D(2) A(2) E(2) H(2) G(2) F(2) E(2)];
xv_ring = [A(1) B(1) C(1) D(1) A(1) E(1) H(1) I(1) L(1) K(1) J(1) I(1) H(1) G(1) F(1) E(1)];
yv_ring = [A(2) B(2) C(2) D(2) A(2) E(2) H(2) I(2) L(2) K(2) J(2) I(2) H(2) G(2) F(2) E(2)];

height = 5;
d1=10;% the density of the inner square
d2=5;
d3=1;% the density of the ring
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R = [-1 -1];

% 2 inner areas:
x_cell = cell(3,1);
y_cell = cell(3,1);
x_cell{1,1} = xv1;
x_cell{2,1} = xv2;
x_cell{3,1} = xv_ring;
y_cell{1,1} = yv1;
y_cell{2,1} = yv2;
y_cell{3,1} = yv_ring;
d_array = [d1;d2;d3];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1 inner area:
% x_cell = cell(2,1);
% y_cell = cell(2,1);
% x_cell{1,1} = xv1;
% x_cell{2,1} = xv_ring;
% y_cell{1,1} = yv1;
% y_cell{2,1} = yv_ring;
% d_array = [d1;d2];
[ r_array, cdf_array ] = cdf_tiered_polygon_R2rand(R,x_cell,y_cell,d_array,height);
plot(r_array,cdf_array,'k-');

hold on;
% [d_array2,r2d_cdf2,sim_d1,sim_d2] = sim_polygon_R2rand(R,xv,yv,xv1,yv1,d1,d2,height); %simulation
[d_array2,r2d_cdf2,sim_density] = sim_tiered_polygon_R2rand(R,x_cell,y_cell,d_array,height);
sim_density
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