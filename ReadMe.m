1. Ref2Rand for arbitrary polygon - From an arbitrary reference point (with or without height)
                                    to a random point within the polygon
    * simulation: 
       --> function   [d_array,r2d_cdf,sim_d1,sim_d2] = sim_polygon_R2rand(R,x,y,x1,y1,d1,d2,h)
        % Input:
        %   R : R(x,y), an arbitrary reference point
        %   x,y : vectors of points, describing points in the plane as
        %        (x,y) pairs. x and y must be the same lengths.
        %   x1,y1 (optional) - vertices of a hole polygon
        %   d1,d2 (optional) - d2/d1 (d1!=0) (or d1/d2, d2!=0) reflects the ratio of the node density
        %       in the ring (inner) area to the node density in the inner (ring) area
        %   h (optional): the height of the reference point R
        %
        % Output: CDF of the distance from R to a random point within
        %           the polygon (x,y), i.e., [d_array,r2d_cdf]
        %         sim_d1,sim_d2 (optional): the simulated node densities in
        %           area (x1,y1) and the ring area, respectively.
        
      A more systematic simulation function, which can replace the above function:
      --> function   [d_array,r2d_cdf,sim_density] = sim_tiered_polygon_R2rand(R,x_cell,y_cell,varargin)
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
        %       ->d_array: n*1, containing "node densities" of each hole (note that it is
        %            not a real node density of the hole, but their ratios indicate
        %            the node density ratio among these holes.
        %            * Note that the order in this array is corresponding to the
        %              order in (x_cell,y_cell)
        %       ->h(optional): the height of the reference point R
        %
        % Call:
        %       [d_array,r2d_cdf,sim_density] = sim_tiered_polygon_R2rand(R,x_cell,y_cell,[],h)
        %       [d_array,r2d_cdf,sim_density] = sim_tiered_polygon_R2rand(R,x_cell,y_cell,d_array,[])
        %       [d_array,r2d_cdf,sim_density] = sim_tiered_polygon_R2rand(R,x_cell,y_cell,d_array,h)
        % Output:
        %   CDF of the distance between R and a random point within the whole area
      

    * approach to CDF of the distance from an arbitrary reference point (with or without height)
                  to a random point with an arbitrary polygon, using the approach based on the shoelace formula
        Two functions:
        --> function [ r_array, cdf_array ] = cdf_Polygon_R2rand( R,x,y, h)
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
       A more systematic simulation function, which can replace the above function:
       -->function [ r_array, cdf_array ] = cdf_tiered_polygon_R2rand( R,x_cell,y_cell,varargin )
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

       
       It calls the following basic fuction developed in our uvicspace report:
       --> function [ area ] = TriangleVertexIntersectionArea(RB,RC,BC,r)
        % R is the reference point, r is the radius of the circle (c) centered at R.
        % This function is to get the area of the intersection between the circle c
        % and the triangle RBC.
        % RB, RC, BC: length of the edge RB, RC, and BC, respectively.
        
       Another function to be called when the reference point has a nonzero height:
       --> function out=getPCDF(aVar, x_axis, pdf, cdf, aOpt)
        % Given the pdf function: (pdf,x_axis) or cdf function (cdf,x_axis), this
        %   function is to look up the above two functions with aVar as the x_axis
        %   to find the corresponding pdf (aOpt = 0) or cdf (aOpt = 1)
        % input:
        %   aVar: x axis array which will be utilized to look up the two functions
        %       (pdf,x_axis) or cdf function (cdf,x_axis)
        %   x_axis, pdf, cdf: plot(x_axis,pdf) can get pdf figure
        %                      plot(x_axis,cdf) can get cdf figure
        %   aOpt: 1: lookup cdf; 0: lookup pdf
        % output:
        %   out: cdf or pdf array

2. other functions used
    --> function [ polygon_area ] = shoelace( x,y )
        % This function is to get the area of an arbitrary polygon
        % x: an array containing the x axises of all the vertexes of the polygon
        % y: an array containing the y axises of all the vertexes of the polygon
        % (x(i),y(i)) is a vertex of the polygon
        
    --> function [X,Y,Z,a,b,c,h_a,h_b,h_c,A,B,C]=gen_triangle(alpha,beta,gamma,a)
        % The function is for generating a triangle
        % Input parameters: 3 angles ([0,180]): alpha,beta,gamma
        %             the lenght of the opposite edge of angle beta: a
        % Output: three decreasing angles: X,Y,Z
        %         three edge lengths: a,b,c
        %         three altitudes: h_a, h_b, h_c
        %         three vertices: A,B,C
        
3. main test script file
    The following main m files can be run directly. They all use the same functions listed above.
    --> main_polygon_R2rand.m
        For arbitrary polygon
    --> main_trangle_vertex2rand.m
        For triangle
    --> main_polygon_hole_R2rand.m
        For tiered polygon, by using the probabilistic sum method
    --> main_tiered_polygon_R2rand_systematic.m
        For tiered polygons, calling the systematic function: cdf_tiered_polygon_R2rand & sim_tiered_polygon_R2rand
    
        