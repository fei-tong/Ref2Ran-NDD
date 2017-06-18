clc
clear
sim_mark='r*';

Angle = [130 30 20];
[X,Y,Z,a,b,c,h_a,h_b,h_c,A,B,C]=gen_triangle(Angle(1),Angle(2),Angle(3),2);
% D=[A(1),A(2),1;C(1),C(2),1;B(1),B(2),1];
% 1/2*det(D)
x = [A(1) B(1) C(1)];
y = [A(2) B(2) C(2)];

height = 3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A is set to R
R = A;
% [d_array,r2d_cdf] = sim_triangle_vertex2rand(R,A,B,C,h_a);
[d_array,r2d_cdf] = sim_polygon_R2rand(R,x,y,height);
R_A=plot(d_array,r2d_cdf,sim_mark);
hold on;

% RB = c; RC = b; BC = a;
% [ r_array, cdf_array ] = cdf_triangle_vertex2rand( RB,RC,BC );
[ r_array, cdf_array ] = cdf_Polygon_R2rand( R,[A(1) B(1) C(1)],[A(2) B(2) C(2)],height);
plot(r_array,cdf_array);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% B is set to R
R = B;
[d_array,r2d_cdf] = sim_polygon_R2rand(R,x,y,height);
R_B=plot(d_array,r2d_cdf,sim_mark);

% RB = c; RC = a; BC = b;
% [ r_array, cdf_array ] = cdf_triangle_vertex2rand( RB,RC,BC );
[ r_array, cdf_array ] = cdf_Polygon_R2rand( R,[A(1) B(1) C(1)],[A(2) B(2) C(2)],height);
plot(r_array,cdf_array);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% C is set to R
R = C;
[d_array,r2d_cdf] = sim_polygon_R2rand(R,x,y,height);
R_C=plot(d_array,r2d_cdf,sim_mark);

% RB = a; RC = b; BC = c;
% [ r_array, cdf_array ] = cdf_triangle_vertex2rand( RB,RC,BC );
[ r_array, cdf_array ] = cdf_Polygon_R2rand( R,[A(1) B(1) C(1)],[A(2) B(2) C(2)],height);
plot(r_array,cdf_array);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% R is not vertex but a interior point
R = [1.2 0.2];
[d_array,r2d_cdf] = sim_polygon_R2rand(R,x,y,height);
R_I=plot(d_array,r2d_cdf,'g*');

[ r_array, cdf_array ] = cdf_Polygon_R2rand( R,[A(1) B(1) C(1)],[A(2) B(2) C(2)],height);
plot(r_array,cdf_array);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% R is not vertex but a exterior point
R = [0 1];
[d_array,r2d_cdf] = sim_polygon_R2rand(R,x,y,height);
R_E=plot(d_array,r2d_cdf,'k*');

[ r_array, cdf_array ] = cdf_Polygon_R2rand( R,[A(1) B(1) C(1)],[A(2) B(2) C(2)],height);
plot(r_array,cdf_array);

%==========================================
box on;
% axis([0 1.0 0 1.0]);
xlabel('Distance','fontsize',16);
ylabel('CDF','fontsize',16);

% AX = legend([lkm_based existing sim_based],'LKM-based','Existing Result','Simulation',4);
AX = legend([R_A  R_I R_E],'R is a vertex','R is (1.2,0.2)(interior)','R is (0,1)(exterior)',1);
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',16);
grid on;