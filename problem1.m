% This file does the calculation of failure function and sensitivities
function [xt1 , dxt1] = problem1(mu0);
  x1 = mu0(1); x2=mu0(2);
  xt1 = [];
  dxt1 = [];
  Vs = 10;
  %xt1 = (exp(-x1+1))/((x2-1)^2+1)-2;
  %dxt11 = -(exp(-x1+1))/((x2-1)^2 + 1);
  %dxt12 = -((exp(-x1+1)*(2*x2-2))/((x2-1)^2 + 1)^2);
  xt1 = (Vs*x1  / (x1 + x2) - 4.75)*(-1);
  dxt11 = -Vs*(x2)/(x1 + x2)^2;
  dxt12 = Vs*(x1)/(x1 + x2)^2;

  %xt2 = exp(x1-2*x2+1)-2;
  %dxt21 = exp(x1-2*x2+1);
  %dxt22 = -2*exp(x1-2*x2+1);
  xt2 = (5.25 - (Vs*x1/(x1 + x2)))*-1;
  dxt21 = Vs*x2/(x1 + x2)^2;
  dxt22 = -Vs*x1/((x1 + x2)^2);

  %xt3 = x1^2 + x2^2 - 3;
  %dxt31 = 2*x1;
  %dxt32 = 2*x2;

  xt3 = (1 - (x1*x2)/(x1 + x2))*-1;
  dxt31 = Vs*(x1^2)/(x1 + x2)^2;
  dxt32 = Vs*(x2^2)/(x1 + x2)^2;

   xt1= -[ xt1; xt2; xt3];
   dxt1 = -[ dxt11; dxt12; dxt21; dxt22; dxt31; dxt32];
%minus sign above so we have g(x) >= 0 as the failure function


%c3
%x1 = -.5:.1:1.5;
%x2 = sqrt(-x1.^2 +3);
%plot(x1,x2)
