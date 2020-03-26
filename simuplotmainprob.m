%simulate and plot
nsim = 100;
rand('seed',717171);
yield = 0.0;
xsim = zeros(n,nsim);
for i=1:nsim;
  %u = rand(n,1);
    u = rand(1,n);

  %zran = t .* u + xr;  % for Uniform dist. only
  xran = (1 - (1-u).^(1./b)).^(1./a);
  %zran = t .* xran + xr;
   zran = t .* xran' + xr;
  xsim(:,i)=zran;
  
  [xt1,dxt1] = problem1(zran);

  bool1= (xt1(1:3)>=0);
  if sum(bool1) >= 2.9 
    yield = yield + 1.0;
  end
%pause
end; % for
 
yield = yield/nsim

plot(xsim(1,:),xsim(2,:),'b.')

legend('Tolerance Box Center','Maximum Yield Box','Tolerance Box','Polytope','Polytope','Polytope','Original Constraints','Original Constraints','Original Constraints','MC',-1)
title('Yield Optimization')