clear
load("data/tbl_2019.mat");
load("data/tbl_2021.mat");


%[text] ## Izdvajanje varijabli
X_2019 = normalize(tbl_2019{:, 1:end-1});
Y_2019 = normalize(tbl_2019{:,end});
Vars_2019 = tbl_2019.Properties.VariableNames(1:end-1);

X_2021 = normalize(tbl_2021{:, 1:end-1});
Y_2021 = normalize(tbl_2021{:,end});
Vars_2021 = tbl_2021.Properties.VariableNames(1:end-1);

X_2021_red = normalize(tbl_2021{:, 2:end-1});
Y_2021_red = Y_2021;
Vars_2021_red = tbl_2021.Properties.VariableNames(2:end-1);

%[text] ## Definisanje struct za optimizaciju parametara
struct_hyper_opt = struct( ...
    'UseParallel', true, ...
    'Optimizer', 'bayesopt', ...
    'AcquisitionFunctionName', 'expected-improvement-per-second-plus', ...
    'Repartition', true, ...
    'ShowPlots', false, ...
    'Verbose', 1, ...
    'MaxObjectiveEvaluations', 500);

%[text] ## Treniranje modela
mdl_2019 = fitrensemble(X_2019, Y_2019, ... %[output:group:2095b1d6] %[output:6e5bf433]
    Method="Bag",NumLearningCycles=500 ... %[output:6e5bf433]
    , PredictorNames=Vars_2019, ResponseName='m/r', OptimizeHyperparameters={'MinLeafSize', 'MaxNumSplits'}, ... %[output:6e5bf433]
    HyperparameterOptimizationOptions=struct_hyper_opt); %[output:group:2095b1d6] %[output:6e5bf433]

save('RF_modeli/RF_2019.mat','mdl_2019','Vars_2019');

%%

mdl_2021 = fitrensemble(X_2021, Y_2021, ... %[output:group:75124fd1] %[output:0f08c2d7]
    Method="Bag", NumLearningCycles=500, ... %[output:0f08c2d7]
    PredictorNames=Vars_2021, ResponseName='m/r', ... %[output:0f08c2d7]
    OptimizeHyperparameters={'MinLeafSize', 'MaxNumSplits'}, ... %[output:0f08c2d7]
    HyperparameterOptimizationOptions=struct_hyper_opt); %[output:group:75124fd1] %[output:0f08c2d7]

save('RF_modeli/RF_2021.mat','mdl_2021','Vars_2021');
%%

mdl_2021_red = fitrensemble(X_2021_red, Y_2021_red, Method='Bag', NumLearningCycles=500 ...
    , PredictorNames=Vars_2021_red, ResponseName='m/r', OptimizeHyperparameters={'MinLeafSize', 'MaxNumSplits'} ...
    , HyperparameterOptimizationOptions=struct_hyper_opt);
save('RF_modeli/RF_2021_red.mat','mdl_2021_red','Vars_2021_red');


%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
%[output:6e5bf433]
%   data: {"dataType":"text","outputData":{"text":"|=====================================================================================================|\n| Iter | Eval   | Objective:  | Objective   | BestSoFar   | BestSoFar   |  MinLeafSize | MaxNumSplits |\n|      | result | log(1+loss) | runtime     | (observed)  | (estim.)    |              |              |\n|=====================================================================================================|\n|    1 | Best   |     0.55679 |      30.558 |     0.55679 |     0.55679 |            3 |           65 |\n","truncated":false}}
%---
%[output:0f08c2d7]
%   data: {"dataType":"error","outputData":{"errorType":"runtime","text":"Unrecognized function or variable 'X_2021'."}}
%---
