% This file does the calculation of failure function and sensitivities 
function xt1 = prob1fig(xx,fixedx,cuno); 
load prob1figdata  %for the new version of fsolve (Sept 17, 2008)
  x2 = fixedx(ipic); x1=xx; %for the new version of fsolve (Sept 17, 2008)
  xt1 = [];
  dxt1 = [];
  Vs = 10;
  % xt1 = (exp(-x1+1))/((x2-1)^2+1)-2;
  xt1 = (Vs*x1  / (x1+ x2) - 4.75)*(-1);
  % xt2 = exp(x1-2*x2+1)-2;
  xt2 = (5.25 - (Vs*x1/(x1 + x2)))*-1;
  % xt3 = x1^2 + x2^2 - 3;
  xt3 = (1 - (x1*x2)/(x1 + x2))*-1;

   xt1= [ xt1;xt2; xt3];
  
  xt1 = xt1(cuno,1);
 
