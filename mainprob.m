% The Calling routine for Solving the simple problem
% using Max. yield s.t. box constraints
% % created  K. Ponnambalam on November 18, 2002. 
clear all;
close all;

%set the parameters of DBPDF
%a = [1 1]; b = [2 2]; %Triangular-like
% a = [1.9 1.9]; b = [0.08 0.08]; %  
%  a = [1 1]; b = [1 1];  %Uniform
% a = [1.65 1.65];  b = [1.8 1.8];  %For normal kind
% a = [5 1];   b = [1 5]; % non-symmetric
% a = [2.5 2.5]; b = [4 4];;%Gaussian-like distn
%a = [1 1];     b = [5 5]; %Strange non-symmet. dist
a = [1 2.5];    b = [2 4];  %One Triangular , one Normal-like
%  a = [8 8]; b = [8 8]; %highly kurtic

n=2; % number of design variables
m=3; %number of original constraints

npolytope = 3;


% Correlation Coef. matrix NOT REALLY NEEDED EXCEPT TO KEEP THE OLD FORMULATION
R = eye(n);

% Nominal values of the design variables:
mu0=[0.5, 1]; 
mu0=mu0';
x0 = [[.25,.9]'; [1,.6]'; [.75,1.5]'; [2.1, 2.1]'; [1.9, 1.9]'];
for iterations=1:npolytope


sigma = 0.05 * mu0; %based on tolerance 15%
C = diag(sigma) * R * diag(sigma);

% The AFOSM algorithm to build polytopes

[betag,xstar,sensg,gfun] = iterprob(mu0,C,x0,m,n);

%
% The matrix sensg contains sensitivity vectors g_i corresponding to
% the system:    g'*(x-x*) >= 0. This lead to -As for =< systems.
%
xs = reshape(xstar,n,m); % points x* on the failure surface
As = - reshape(sensg,n,m); % sensitivity information
Un = eye(n);
for i = 1:m
bs(i,1) = As(:,i)' * xs(:,i);
end

options(1)=1;               %Display intermediate results
%options(2)=1e-3;            %tolerance on mu
options(3)=1e-3;            %tolerance on f(mu)
options(4)=1e-3;            %tolerance on constraints
options(7)=1;               %Algorithm: Line Search Algorithm. (Default 0)
options(13) = 0;           %Number of Eq. Const.
options(14) = 1000;          %max number of iterations
%options(18) = 0.5;          %stepsize

clear x xs x0
% construct initial vector x0 containing xu, xl and xr where
% xr defines the location of the box given by xl and xu.
lob = [-.5 .2];
upb = [2, 2];
vlb=[lob; lob; lob];
vub=[upb; upb; upb];
tol =[100 50]'/100;  %percent tolerance
xu = mu0 + tol .* mu0;
xl = mu0 - tol .* mu0;
xr = xl;
x0 =[mu0;.9*mu0;xr;];

t = [.21, 0.99]'; 
%fix it! For u0 = (1, 0.5), (0.25, 0.25) gets 100% yield 
trange = t; %for figures

%calcualte maximum yield and find the normal design (center)
 % x  = constr('dbcdfprob',x0,options,vlb,vub,[],a,b,t,As,bs); %old function

[x,feval,exitflag] = fmincon('dbcdfprobfun',x0,[],[],[],[],vlb,vub,'dbcdfprobcon',[],a,b,t,As,bs);
  
xu = x(1:n,1);
xl = x(n+1:2*n,1);
xr = x(2*n+1:3*n,1);

mu0 = xr+(t/2);

if iterations >= (npolytope-2)
    %draw only some final runs
    figure %new figure for each iteration of the polytope building
    drawfigmainprob
    simuplotmainprob
end
   
x0 = xstar; %only for iterative polytopes


end %for iterations
