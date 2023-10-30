function DirichletBoundaryValue = u_d(x)
%U_D   Data on the Dirichlet boundary
%   Y = U_D(X) returns function values at N discrete points  
%   on the Dirichlet boundary. This input data has to be choosen  
%   by the user. X has dimension N x 2 and Y has dimension N x 1.
%
%
%   See also FEM2D, F, and G.
%

%    J. Alberty, C. Carstensen and S. A. Funken  02-11-99
%    File <u_d.m> in $(HOME)/acf/fem2d/
%    This Dirichlet boundary data is used to compute Fig. 3 in 
%    "Remarks around 50 lines of Matlab: Short finite element 
%    implementation"
X = x(:,1);
Y = x(:,2);

holder = zeros(size(x,1),1);
for index = 1:size(X,1)
    if X(index)==1
        holder(index) = 500;
    end
end
DirichletBoundaryValue =  holder;