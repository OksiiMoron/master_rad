clear
load("tbl_2019.mat");
load("tbl_2021.mat");

%[text] ## Izdvajanje varijabli
X_2019 = tbl_2019{:, 1:end-1};
Y_2019 = tbl_2019{:,end};
Vars_2019 = tbl_2019.Properties.VariableNames(1:end-1);

X_2021 = tbl_2021{:, 1:end-1};
Y_2021 = tbl_2021{:,end};
Vars_2021 = tbl_2021.Properties.VariableNames(1:end-1);

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
mdl_2019 = fitrensemble(X_2019, Y_2019, ... %[output:group:1a4b6915] %[output:3dcd02de]
    Method="Bag",NumLearningCycles=500 ... %[output:3dcd02de]
    , PredictorNames=Vars_2019, ResponseName='m/r', OptimizeHyperparameters={'MinLeafSize', 'MaxNumSplits'}, ... %[output:3dcd02de]
    HyperparameterOptimizationOptions=struct_hyper_opt); %[output:group:1a4b6915] %[output:3dcd02de]

mdl_2021 = fitrensemble(X_2021, Y_2021, ...
    Method="Bag", NumLearningCycles=500, ...
    PredictorNames=Vars_2021, ResponseName='m/r', ...
    OptimizeHyperparameters={'MinLeafSize', 'MaxNumSplits'}, ...
    HyperparameterOptimizationOptions=struct_hyper_opt);

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
%[output:3dcd02de]
%   data: {"dataType":"text","outputData":{"text":"|=====================================================================================================|\n| Iter | Eval   | Objective:  | Objective   | BestSoFar   | BestSoFar   |  MinLeafSize | MaxNumSplits |\n|      | result | log(1+loss) | runtime     | (observed)  | (estim.)    |              |              |\n|=====================================================================================================|\n|    1 | Best   |     0.43176 |      27.443 |     0.43176 |     0.43176 |            7 |           83 |\n|    2 | Best   |     0.40737 |      19.774 |     0.40737 |     0.40923 |            3 |           13 |\n|    3 | Accept |     0.45126 |      20.189 |     0.40737 |     0.40956 |            2 |            1 |\n|    4 | Accept |     0.47386 |      18.589 |     0.40737 |     0.40737 |           22 |            2 |\n","truncated":false}}
%---
