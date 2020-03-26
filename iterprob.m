%Iterative formula to converge to the correct reference points x*.
%Prepared by Abbas Seifi on July 26, 1996. 
%Application of FOSM for Simple example by Ponnu on Dec 1 1999.

function [betag,xstar,sensg,gfun] = iterative(mu,C,x0,m,n)

m =3; % 
n=2;
gfun(1:m)=ones(m,1); eps1 = [1e-3*ones(1,3)];
maxiter=5; 
betag(1:m)=zeros(m,1); beta = 0; xstar=[]; sensg=[];
G =  zeros(size(mu)); 

for i=1:m;
j = (i-1)*n;
xs = x0(j+1:j+n); iter=1; xk_1=zeros(n,1);
G = ones(n,1);

%if i==1, maxiter=100; end;

while (abs(gfun(i))>eps1(1,i)) & (norm(G)>1e-6) & (iter<maxiter)

%defines vector G(.) the first-order sensitivity coefficients
 [xt1, dxt] = problem1(xs);

i
if (i==1),
     gfun(i) = xt1(1,1);
     G = dxt(1:2);
   elseif (i==2),
     gfun(i) = xt1(2,1);
     G = dxt(3:4);
   elseif (i==3),
     gfun(i) = xt1(3,1);
     G = dxt(5:6);
   end% if


% The matrix sensg contains sensitivity vectors g_i 
% for the system:    g'*(x-x*) >= 0.

%defines betag(i)
 beta = betag(i);
 l = sqrt(G'*C*G);
 
% betag(i) =  - G'*(xs - mu) /l;  
 betag(i) =  abs((xs - mu)'*G) /l;
%iterative equation:
   xk_2 = xk_1;
   xk_1 = xs;
  xs = mu - (betag(i) + gfun(i)/l)/l * C * G;
%xs'
   if (norm(xs - xk_2)/norm(xs) <1e-2),
   %if (norm(xs - xk_2)/norm(xs) <eps1),
      'cycling is avoided'
     xs =  mu - (betag(i)+0.5*gfun(i)/l)/l * C * G;
   end%if
 iter=iter+1,
end% while
% preparing the output: 
	xstar=[xstar;xs];
	sensg=[sensg; G];
end% for 

% print the results:
  betag, gfun
