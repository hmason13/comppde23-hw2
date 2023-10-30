%% Loop
numRefineRuns = 8;
errors = zeros(numRefineRuns,1);
numOfElements = zeros(numRefineRuns,1);
for refLev = 0:numRefineRuns-1
    fem2d
end

%% Regression
mdl = fitlm(log(numOfElements),log(errors));
mdl

%% Plot
figure(1)
loglog(numOfElements,errors,'r-o')
xlabel("Log number of elements")
ylabel("L2 error")
title("Log log: L2 error vs # of elements")

figure(2)
plot(mdl)