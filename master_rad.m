%[text] ## Uvoz i transformacija podataka
GHSI_2021_table = readtable("GHSI_2021_large_table.csv", VariableNamingRule="preserve", ReadRowNames=true);
% Izdvajanje imena kolona i drzava
countryNames = GHSI_2021_table.Properties.RowNames;
col_names = GHSI_2021_table.Properties.VariableNames; %[output:19bb47c0]

% Izdvajanje numerickog dela tabele u vidu matrice
GHSI_2021_matrix = table2array(GHSI_2021_table(:,2:end));

GHSI_2021_matrix_transformed = zeros(size(GHSI_2021_matrix));
lambdas = zeros(size(GHSI_2021_matrix,1),1);

% Pretvaranje negativnih vrednosti u pozitivne, kako bi matrica mogla da
% ,,udje'' u boxcox funckiju, pomeranjem svih vrednosti za min()
min_val = min(GHSI_2021_matrix(:));
if min_val <= 0
    GHSI_2021_matrix = GHSI_2021_matrix - min_val + eps; 
end

% BoxCox tranformacija svake kolone
for i = 1:width(GHSI_2021_matrix)
    [GHSI_2021_matrix_transformed(:,i), lambdas(i)] = boxcox(GHSI_2021_matrix(:, i));
end

%[text] ## Uklanjanje autlajera
% Iskoriscena je ista funkcija koju smo koristili u Zadatku 1
GHSI_2021_matrix_transformed = DnRoutlier(GHSI_2021_matrix_transformed);


%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
%[output:19bb47c0]
%   data: {"dataType":"matrix","outputData":{"columns":7,"header":"1×7 cell array","name":"col_names","rows":1,"type":"cell","value":[["'OVERALL SCORE'","'1) PREVENTION OF THE EMERGENCE OR RELEASE OF PATHOGENS'","'2) EARLY DETECTION & REPORTING FOR EPIDEMICS OF POTENTIAL INT'L CONCERN'","'3) RAPID RESPONSE TO AND MITIGATION OF THE SPREAD OF AN EPIDEMIC'","'4) SUFFICIENT & ROBUST HEALTH SECTOR TO TREAT THE SICK & PROTECT HEALTH WORKERS'","'5) COMMITMENTS TO IMPROVING NATIONAL CAPACITY, FINANCING AND ADHERENCE TO NORMS'","'6) OVERALL RISK ENVIRONMENT AND COUNTRY VULNERABILITY TO BIOLOGICAL THREATS'"]]}}
%---
