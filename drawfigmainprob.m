%draw figures

mu0 = xr+trange/2;
plot(mu0(1,1),mu0(2,1),'go')
hold
% xu =[0.8316;1.2678];
% xl =[0.2732;0.7151];
xp = [xl(1,1) xu(1,1) xu(1,1) xl(1,1) xl(1,1)];
yp = [xl(2,1) xl(2,1) xu(2,1) xu(2,1) xl(2,1)];
plot(xp,yp,'k-')


%outside box (tolerance box)
% xr =[0.2732    0.7151]';
% trange = [0.5584    0.5527]';
xrt = xr+trange;
xp = [xr(1,1) xrt(1,1) xrt(1,1) xr(1,1) xr(1,1)];
yp = [xr(2,1) xr(2,1) xrt(2,1) xrt(2,1) xr(2,1)];
plot(xp,yp,'g-')

% plot the polytope lines
  for i=1:3
     if (As(2,i) == 0)
        ys = -0.0:.1:2.5;
        xs = bs(i) * ones(size(ys));
     else
        xs = -0.0:.1:2.5;
        ys= (bs(i)-As(1,i)*xs)./As(2,i);
     end
     axis([-2 4 0 2])
     plot(xs,ys,'r-')
  end% for

 %above from jmainfig2.m
 
 
%draw the cuno constraint using problem1 (actual)
%curve number
cuno=1;
x20=1;
fixedx = 0.:.02:1.75;
for ipic=1:length(fixedx)
 %x1(ipic) = oldfsolve('prob1fig',x20,[],[],fixedx(ipic),cuno);
 save prob1figdata fixedx ipic cuno  %for the new version of fsolve (Sept 17, 2008)
 [ x1(ipic), feval, exitflag] = fsolve('prob1fig',x20);%for the new version of fsolve (Sept 17, 2008)
end %ipic
plot(x1,fixedx,'b-')



%draw the cuno constraint using problem1 (actual)
%curve number
cuno=3;
x20=1;
fixedx = 0.:.02:1.75;
for ipic=1:length(fixedx)
% x1(ipic) = oldfsolve('prob1fig',x20,[],[],fixedx(ipic),cuno);
 save prob1figdata fixedx ipic cuno %for the new version of fsolve (Sept 17, 2008)
  [ x1(ipic), feval, exitflag] = fsolve('prob1fig',x20); %for the new version of fsolve (Sept 17, 2008)
end %ipic
plot(x1,fixedx,'b-')



%draw the cuno constraint using problem1 (actual)
%curve number
cuno=2;
x20=1;
fixedx = 0.:.02:1.75;
for ipic=1:length(fixedx)
% x1(ipic) = oldfsolve('prob1fig',x20,[],[],fixedx(ipic),cuno);
  save prob1figdata fixedx ipic cuno %for the new version of fsolve (Sept 17, 2008)
  [ x1(ipic), feval, exitflag] = fsolve('prob1fig',x20); %for the new version of fsolve (Sept 17, 2008)
end %ipic
plot(x1,fixedx,'b-')

