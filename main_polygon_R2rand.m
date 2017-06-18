clc
clear
sim_mark='r*';

%% hexagon
a = 1;
A_1 = 30*pi/180;
A_2 = 60*pi/180;
A_3 = 90*pi/180;
A_4 = 120*pi/180;
A_5 = 150*pi/180;
b = a/2;
c = a*sqrt(3)/2;

A = [0 b*sqrt(3)/2]; B = [b/2 c]; C = [b*3/2 c]; 
D = [a b*sqrt(3)/2]; E = [b*3/2 0]; F = [b/2 0];
x = [A(1) B(1) C(1) D(1) E(1) F(1)];
y = [A(2) B(2) C(2) D(2) E(2) F(2)];
figure(1);
hold on;
n = length(x);
for i = 1 : n
    j = i;
    if i == n
        k = 1;
    else
        k = i+1;
    end
    plot([x(j) x(k)],[y(j) y(k)]);
%     plot([A(1) B(1)],[A(2) B(2)]);
end
figure(2);
%%
height = 3;
x_cell = cell(1,1);
x_cell{1,1} = x;
y_cell{1,1} = y;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A is set to R
R = A;
% [d_array,r2d_cdf] = sim_polygon_R2rand(R,x,y,height);
[d_array,r2d_cdf,sim_density] = sim_tiered_polygon_R2rand(R,x_cell,y_cell,[],height);
R_A=plot(d_array,r2d_cdf,sim_mark);
hold on;

% RB = c; RC = b; BC = a;
% [ r_array, cdf_array ] = cdf_triangle_vertex2rand( RB,RC,BC );
% [ r_array, cdf_array ] = cdf_Polygon_R2rand( R,x,y,height);
[ r_array, cdf_array ] = cdf_tiered_polygon_R2rand( R,x_cell,y_cell,[],height);
plot(r_array,cdf_array);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% R is an interior point
R = [0.5 0.4];
% [d_array,r2d_cdf] = sim_polygon_R2rand(R,x,y,height);
[d_array,r2d_cdf,sim_density] = sim_tiered_polygon_R2rand(R,x_cell,y_cell,[],height);
R_I=plot(d_array,r2d_cdf,'g*');
hold on;

% RB = c; RC = b; BC = a;
% [ r_array, cdf_array ] = cdf_triangle_vertex2rand( RB,RC,BC );
% [ r_array, cdf_array ] = cdf_Polygon_R2rand( R,x,y,height);
[ r_array, cdf_array ] = cdf_tiered_polygon_R2rand( R,x_cell,y_cell,[],height);
plot(r_array,cdf_array);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% R is an exterior point
R = [0 0];
% [d_array,r2d_cdf] = sim_polygon_R2rand(R,x,y,height);

[d_array,r2d_cdf,sim_density] = sim_tiered_polygon_R2rand(R,x_cell,y_cell,[],height);

R_E=plot(d_array,r2d_cdf,'k*');
hold on;

% RB = c; RC = b; BC = a;
% [ r_array, cdf_array ] = cdf_triangle_vertex2rand( RB,RC,BC );
% [ r_array, cdf_array ] = cdf_Polygon_R2rand( R,x,y,height);
[ r_array, cdf_array ] = cdf_tiered_polygon_R2rand( R,x_cell,y_cell,[],height);
plot(r_array,cdf_array);
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