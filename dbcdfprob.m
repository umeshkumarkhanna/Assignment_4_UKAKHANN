function [f,g] = dbcdf(x,a,b,t,As,bs);
% Extract vectors xu, xl and xr from x
% xr defines the location of the box given by xl and xu.
% x0 = [xu;xl;xr];
n = 2; % number of design parameters
xu = x(1:n,1);
xl = x(n+1:2*n,1);
xr = x(2*n+1:3*n,1);
f = 1.0;
for j=1:n;
 fj1 = -abs(1 - abs((xu(j)-xr(j))/t(j))^a(j))^b(j); 
 fj2 = +abs(1 - abs((xl(j)-xr(j))/t(j))^a(j))^b(j);
 %fj1 = -(1 - ((xu(j)-xr(j))/t(j))^a(j))^b(j);
 %fj2 = +(1 - ((xl(j)-xr(j))/t(j))^a(j))^b(j);
 %if (abs(fj1)>1+eps) |(abs(fj2)>1+eps)
 % a,b,
 % fj1,fj2
 % x, t'
 % pause
 %end
fj = fj1 + fj2;
%pause

%fj = (xu(j) - xr(j))/t(j) - (xl(j)-xr(j))/t(j) ; % for Uniform dist. only

 f = f * fj;
end
f = -f;

Ap = max(0,As)';
Am = max(0,-As)';
g1 = Ap * xu - Am * xl - bs;   % The signs were set up for g1 <0.
g2 = xl - xu;               
g3 = xr - xl;
g4 = xu - xr - t;
g5 = -xu + xl + .2*t; %minimum box width and the results may vary with this

g = [g1; g2; g3; g4; g5];
%g = [g1; g2; g3; g4; ];

