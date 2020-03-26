close all;
clear all;
f=664;
pg=0:20; 
hold
crc=(10+pg)/.27;
plot(crc,pg)  
plot(100*ones(1,length(pg)),pg)
cr=0:100;
plot(cr,10*ones(1,length(cr)))
fill([100,100,74.041],[10,17,10],'g')

%simulate and plot
nsim = 30;
rand('seed',717171);
yield = 0.0;
n = 2;

a = [1 1];  
b = [1 1];
xsim = zeros(n,nsim);
xr = [76 10.5]'; %Initial nominal design (provides the tolerance center reference point)
t  = 1.25*[25 3]'; %Intial tolerance
   xr = [75.5 10]';  %Changing this produces nominal design
  t  = 1*[25 3]'; %changing this produces tolerance design

tc = xr+0.5*t;
plot(tc(1,1),tc(2,1),'ro')

for i=1:nsim;
  %u = rand(n,1);
    u = rand(1,n);

  %zran = t .* u + xr;  % for Uniform dist. only
  xran = (1 - (1-u).^(1./b)).^(1./a);
  %zran = t .* xran + xr;
   zran = t .* xran' + xr;
  xsim(:,i)=zran;
  
end; % for
 

plot(xsim(1,:),xsim(2,:),'b.')
legend('Original Constraints','Original Constraints','Original Constraints', 'Tolerance Box Center','Sample Realizations','Feasible Region',-1)
title('Yield Optimization')
xlabel('Random Design Variable 1')
ylabel('Random Design Variable 2')