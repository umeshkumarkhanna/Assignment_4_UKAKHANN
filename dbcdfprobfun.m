function f = dbcdf(x,a,b,t,As,bs);
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



