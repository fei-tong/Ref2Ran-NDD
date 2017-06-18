
function out=getPCDF(aVar, x_axis, pdf, cdf, aOpt)
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
%
% Author: FEI TONG
% Date: Apr. 28, 2016

format LONGG
out=zeros(size(aVar));
dx=(max(x_axis)-min(x_axis))/(length(x_axis)-1);
row=length(aVar(:,1));
for i=1:row
    indDist = max(1, round((aVar(i,:)-min(x_axis))/dx));
    if (aOpt == 1)
        out(i,:)=cdf(indDist);
    else
        out(i,:)=pdf(indDist);
    end
end

end