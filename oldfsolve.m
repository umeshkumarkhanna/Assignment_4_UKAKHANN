function [x,OPTIONS] = fsolve(FUN,x,OPTIONS,GRADFUN,varargin)
%FSOLVE Solves nonlinear equations by a least squares method.
%
%   FSOLVE solves equations of the form:
%             
%   F(X)=0    where F and X may be vectors or matrices.   
%
%   X=FSOLVE('FUN',X0) starts at the matrix X0 and tries to solve the 
%   equations described in FUN. FUN is usually an M-file which returns 
%   an evaluation of the equations for a particular value of X: F=FUN(X).
%
%   X=FSOLVE('FUN',X0,OPTIONS) allows a vector of optional parameters to
%   be defined. OPTIONS(2) is a measure of the precision required for the 
%   values of X at the solution. OPTIONS(3) is a measure of the precision
%   required of the objective function at the solution. See HELP FOPTIONS. 
%
%   X=FSOLVE('FUN',X0,OPTIONS,'GRADFUN') enables a function'GRADFUN'
%   to be entered which returns the partial derivatives of the functions,
%   dF/dX, (stored in columns) at the point X: gf = GRADFUN(X).
%
%   X=FSOLVE('FUN',X0,OPTIONS,'GRADFUN',P1,P2,...) passes the 
%   problem-dependent parameters P1,P2,... directly to the functions 
%   FUN and GRADFUN: FUN(X,P1,P2,...) and GRADFUN(X,P1,P2,...).  Pass
%   empty matrices for OPTIONS and 'GRADFUN' to use the default values. 
%
%   [X,OPTIONS]=FSOLVE('FUN',X0,...) returns the parameters used in the 
%   optimization method.  For example, options(10) contains the number 
%   of function evaluations used.
%   
%   The default algorithm is the Gauss-Newton method with a 
%   mixed quadratic and cubic line search procedure.  A Levenberg-Marquardt 
%   method is selected by setting  OPTIONS(5)=1. 

%   Copyright (c) 1990-98 by The MathWorks, Inc.
%   $Revision: 1.16 $  $Date: 1997/11/29 01:23:12 $
%   Andy Grace 7-9-90.


% Handle undefined arguments
if nargin < 2, error('fsolve requires two input arguments');end
if nargin<4
    GRADFUN=[];
    if nargin<3
        OPTIONS=[];
    end
end

if length(OPTIONS)<5; 
    OPTIONS(5)=0; 
end
% Switch methods making Gauss Newton the default method.
if OPTIONS(5)==0; OPTIONS(5)=1; else OPTIONS(5)=0; end

% Convert to inline function as needed.
if ~isempty(FUN)
  [funfcn, msg] = fcnchk(FUN,length(varargin));
  if ~isempty(msg)
    error(msg);
  end
else
  error('FUN must be a function name or valid expression.')
end

if ~isempty(GRADFUN)
  [gradfcn, msg] = fcnchk(GRADFUN,length(varargin));
  if ~isempty(msg)
    error(msg);
  end
else
  gradfcn = [];
end

[x,OPTIONS] = mynlsq(funfcn,x,OPTIONS,gradfcn,varargin{:});

if OPTIONS(8)>10*OPTIONS(3) & OPTIONS(1)>0
    disp('Optimizer is stuck at a minimum that is not a root')
    disp('Try again with a new starting guess')
end

% end fsolve

