%% Loop setup
numRefineRuns = 5;
errors = zeros(numRefineRuns,1);
numOfElements = zeros(numRefineRuns,1);

%% Load data
% Initialisation
load coordinates.dat; coordinates(:,1)=[];
load dirichlet.dat; dirichlet(:,1) = [];

try
    load elements3.dat;
    elements3(:,1)=[];
catch anException
    elements3=[];
end

try
    load elements4.dat;
    elements4(:,1)=[];
catch anException
    elements4=[];
end

try
    load neumann.dat;
    neumann(:,1)=[];
catch anException
    neumann=[];
end

%% Indicator plot setup
% figure(5)
% axes("XScale","log","YScale","log")
% cmap = colormap;
% hold on

%% Run loop
idxToRefine = 1:4; % hard coded, :/
for refLev = 0:numRefineRuns-1
    fem2d
    indicators = computeEtaR(u,coordinates,elements3, ...
                             dirichlet,neumann,@u_d,@g);
    [sortedElements,assocIndex] = sort(indicators,'descend');
    numOfIndicesToRefine = size(indicators,1)/10;
    numOfIndicesToRefine = round(numOfIndicesToRefine)+1;
    idxToRefine = assocIndex(1:numOfIndicesToRefine);
    % plot(logspace(-10,0,size(sortedElements,1)), sortedElements, ...
    %         "Color",cmap(1+refLev*30,:),"Marker","o")
end

% Finalize plot 5
% title("Error from sorted elements")
% ylabel("Error from individual element")
% xlabel("Element index mapped to (0,1)")
% hold off

%% Regression
mdl = fitlm(log(numOfElements),log(errors));
mdl

%% Plot
figure(2)
loglog(numOfElements,errors,'r-o')
xlabel("Log number of elements")
ylabel("L2 error")
title("Log log: L2 error vs # of elements")

figure(3)
plot(mdl)