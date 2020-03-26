function [g,geq] = dbcdf(x,a,b,t,As,bs);
% Extract vectors xu, xl and xr from x
% xr defines the location of the box given by xl and xu.
% x0 = [xu;xl;xr];
n = 2; % number of design parameters
xu = x(1:n,1);
xl = x(n+1:2*n,1);
xr = x(2*n+1:3*n,1);

Ap = max(0,As)';
Am = max(0,-As)';
g1 = Ap * xu - Am * xl - bs;   % The signs were set up for g1 <0.
g2 = xl - xu;               
g3 = xr - xl;
g4 = xu - xr - t;
g5 = -xu + xl + .2*t; %minimum box width and the results may vary with this

g = [g1; g2; g3; g4; g5];
%g = [g1; g2; g3; g4; ];

geq=[];

