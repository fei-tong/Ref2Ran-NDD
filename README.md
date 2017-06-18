# Ref2Ran-NDD
To obtain the distribution of the distance from a reference point to a point uniformly distributed at random in arbitrarily-shaped finite wireless networks

## 1. Ref2Rand for arbitrary polygon - From an arbitrary reference point (with or without height) to a random point within the polygon
   simulation:
   * --> function   [d_array,r2d_cdf,sim_d1,sim_d2] = sim_polygon_R2rand(R,x,y,x1,y1,d1,d2,h)</br>
        % Input:</br>
        %   R : R(x,y), an arbitrary reference point</br>
        %   x,y : vectors of points, describing points in the plane as</br>
        %        (x,y) pairs. x and y must be the same lengths.</br>
        %   x1,y1 (optional) - vertices of a hole polygon</br>
        %   d1,d2 (optional) - d2/d1 (d1!=0) (or d1/d2, d2!=0) reflects the ratio of the node density</br>
        %       in the ring (inner) area to the node density in the inner (ring) area</br>
        %   h (optional): the height of the reference point R</br>
        %</br>
        % Output: CDF of the distance from R to a random point within</br>
        %           the polygon (x,y), i.e., [d_array,r2d_cdf]</br>
        %         sim_d1,sim_d2 (optional): the simulated node densities in</br>
        %           area (x1,y1) and the ring area, respectively.</br>
        </br>
   A more systematic simulation function, which can replace the above function:</br>
   * --> function   [d_array,r2d_cdf,sim_density] = sim_tiered_polygon_R2rand(R,x_cell,y_cell,varargin)</br>
        % Input:</br>
        %   R: reference point R(x_axis,y_axis)</br>
        %</br>
        %   x_cell: x axis of the vertexes of the ring area and each inner polygon (size:</br>
        %                 (n)*1, indicating that it has (n-1) "holes" and 1 ring area)</br>
        %   y_cell: y axis of the vertexes of the ring area and each inner polygon (size:</br>
        %                 (n)*1, indicating that it has (n-1) "holes" and 1 ring area)</br>
        %           The ring's vertexes are contained in the last element of (x_cell,y_cell)</br>
        %</br>
        %   varargin contains the following two optional arguments:</br>
        %       ->d_array: n*1, containing "node densities" of each hole (note that it is</br>
        %            not a real node density of the hole, but their ratios indicate</br>
        %            the node density ratio among these holes.</br>
        %            * Note that the order in this array is corresponding to the</br>
        %              order in (x_cell,y_cell)</br>
        %       ->h(optional): the height of the reference point R</br>
        %</br>
        % Call:</br>
        %       [d_array,r2d_cdf,sim_density] = sim_tiered_polygon_R2rand(R,x_cell,y_cell,[],h)</br>
        %       [d_array,r2d_cdf,sim_density] = sim_tiered_polygon_R2rand(R,x_cell,y_cell,d_array,[])</br>
        %       [d_array,r2d_cdf,sim_density] = sim_tiered_polygon_R2rand(R,x_cell,y_cell,d_array,h)</br>
        % Output:</br>
        %   CDF of the distance between R and a random point within the whole area</br>
      </br>
</br>
   approach to CDF of the distance from an arbitrary reference point (with or without height) to a random point with an arbitrary polygon, using the approach based on the shoelace formula</br>
   Two functions:
   * --> function [ r_array, cdf_array ] = cdf_Polygon_R2rand( R,x,y, h)</br>
        % This fuction is developed based on our uvicspace report:</br>
        %   https://dspace.library.uvic.ca//handle/1828/5134</br>
        % and a paper which proposes the exteded shoelace formula (also based on our above report):</br>
        %   "Computing Exact Closed-Form Distance Distributions in Arbitrarily Shaped Polygons with Arbitrary Reference Point"</br>
        %       from: http://users.cecs.anu.edu.au/~Salman.Durrani/software.html</br>
        % Input:</br>
            % R: an arbitrary reference point</br>
            % r: the radius of the circle (c) centered at R.</br>
            % x: an array containing the x axises of all the vertexes of the polygon</br>
            % y: an array containing the y axises of all the vertexes of the polygon</br>
            % h(optional): the height of the reference point R</br>
   A more systematic simulation function, which can replace the above function:
   * -->function [ r_array, cdf_array ] = cdf_tiered_polygon_R2rand( R,x_cell,y_cell,varargin )
        % Input:</br>
        %   R: reference point R(x_axis,y_axis)</br>
        %</br>
        %   x_cell: x axis of the vertexes of the ring area and each inner polygon (size:</br>
        %                 (n)*1, indicating that it has (n-1) "holes" and 1 ring area)</br>
        %   y_cell: y axis of the vertexes of the ring area and each inner polygon (size:</br>
        %                 (n)*1, indicating that it has (n-1) "holes" and 1 ring area)</br>
        %           The ring's vertexes are contained in the last element of (x_cell,y_cell)</br>
        %</br>
        %   varargin contains the following two optional arguments:</br>
        %      -> d_array: n*1, containing "node densities" of each hole (note that it is</br>
        %            not a real node density of the hole, but their ratios indicate</br>
        %            the node density ratio among these holes.</br>
        %            * Note that the order in this array is corresponding to the</br>
        %              order in (x_cell,y_cell)</br>
        %      -> h(optional): the height of the reference point R</br>
        %</br>
        % Call:</br>
        %       [ r_array, cdf_array ] = cdf_tiered_polygon_R2rand( R,x_cell,y_cell,[],h )</br>
        %       [ r_array, cdf_array ] = cdf_tiered_polygon_R2rand( R,x_cell,y_cell,d_array,[] )</br>
        %       [ r_array, cdf_array ] = cdf_tiered_polygon_R2rand( R,x_cell,y_cell,varargin )</br>
        % Output:</br>
        %   CDF of the distance between R and a random point within the whole area</br>
</br>       
   It calls the following basic fuction developed in our uvicspace report:
   * --> function [ area ] = TriangleVertexIntersectionArea(RB,RC,BC,r)</br>
        % R is the reference point, r is the radius of the circle (c) centered at R.</br>
        % This function is to get the area of the intersection between the circle c</br>
        % and the triangle RBC.</br>
        % RB, RC, BC: length of the edge RB, RC, and BC, respectively.</br>
        </br>
   Another function to be called when the reference point has a nonzero height:
   * --> function out=getPCDF(aVar, x_axis, pdf, cdf, aOpt)</br>
        % Given the pdf function: (pdf,x_axis) or cdf function (cdf,x_axis), this</br>
        %   function is to look up the above two functions with aVar as the x_axis</br>
        %   to find the corresponding pdf (aOpt = 0) or cdf (aOpt = 1)</br>
        % input:</br>
        %   aVar: x axis array which will be utilized to look up the two functions</br>
        %       (pdf,x_axis) or cdf function (cdf,x_axis)</br>
        %   x_axis, pdf, cdf: plot(x_axis,pdf) can get pdf figure</br>
        %                      plot(x_axis,cdf) can get cdf figure</br>
        %   aOpt: 1: lookup cdf; 0: lookup pdf</br>
        % output:</br>
        %   out: cdf or pdf array</br>
</br>
## 2. other functions used
   * --> function [ polygon_area ] = shoelace( x,y )</br>
        % This function is to get the area of an arbitrary polygon</br>
        % x: an array containing the x axises of all the vertexes of the polygon</br>
        % y: an array containing the y axises of all the vertexes of the polygon</br>
        % (x(i),y(i)) is a vertex of the polygon</br>
        </br>
   * --> function [X,Y,Z,a,b,c,h_a,h_b,h_c,A,B,C]=gen_triangle(alpha,beta,gamma,a)</br>
        % The function is for generating a triangle</br>
        % Input parameters: 3 angles ([0,180]): alpha,beta,gamma</br>
        %             the lenght of the opposite edge of angle beta: a</br>
        % Output: three decreasing angles: X,Y,Z</br>
        %         three edge lengths: a,b,c</br>
        %         three altitudes: h_a, h_b, h_c</br>
        %         three vertices: A,B,C</br>
        </br>
## 3. main test script file
   The following main m files can be run directly. They all use the same functions listed above.</br>
   * --> main_polygon_R2rand.m</br>
        For arbitrary polygon</br>
   * --> main_trangle_vertex2rand.m
        For triangle </br>
   * --> main_polygon_hole_R2rand.m
        For tiered polygon, by using the probabilistic sum method</br>
   * --> main_tiered_polygon_R2rand_systematic.m
        For tiered polygons, calling the systematic function: cdf_tiered_polygon_R2rand & sim_tiered_polygon_R2rand</br>
