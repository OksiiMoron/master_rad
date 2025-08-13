%[text] ## Uvoz i transformacija podataka
clear
GHSI_2019_table = readtable("mr_GHSI_demo_data_transf_out.csv", VariableNamingRule="preserve", ReadRowNames=true);
GHSI_2021_table = readtable("GHSI_2021_large_table.csv", VariableNamingRule="preserve", ReadRowNames=true);

% filtriranje po zajednickim drzavama
idx = ismember(GHSI_2021_table.Properties.RowNames, GHSI_2019_table.Properties.RowNames);
GHSI_2021_table_filtered = GHSI_2021_table(idx, :);

isequal(GHSI_2021_table_filtered.Properties.RowNames, GHSI_2019_table.Properties.RowNames);
GHSI_2021_table_filtered = GHSI_2021_table_filtered(GHSI_2019_table.Properties.RowNames, :);
isequal(GHSI_2021_table_filtered.Properties.RowNames, GHSI_2019_table.Properties.RowNames);


% Izdvajanje imena kolona i drzava
countryNames = GHSI_2021_table_filtered.Properties.RowNames;
col_names = GHSI_2021_table_filtered.Properties.VariableNames;

% Izdvajanje numerickog dela tabele u vidu matrice
GHSI_2021_matrix = table2array(GHSI_2021_table_filtered);


GHSI_2021_matrix_transformed = zeros(size(GHSI_2021_matrix));
lambdas = zeros(size(GHSI_2021_matrix,2),1);

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

GHSI_2021_table_transformed = array2table(GHSI_2021_matrix_transformed, VariableNames=col_names, RowNames=countryNames) %[output:7b3254d7]

save("GHSI_2021_transformed_data.mat", 'GHSI_2021_matrix_transformed', 'GHSI_2021_table_transformed', 'GHSI_2019_table');


%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
%[output:7b3254d7]
%   data: {"dataType":"tabular","outputData":{"columnNames":["OVERALL SCORE","1) PREVENTION OF THE EMERGENCE OR RELEASE OF PATHOGENS","2) EARLY DETECTION & REPORTING FOR EPIDEMICS OF POTENTIAL INT'L CONCERN","3) RAPID RESPONSE TO AND MITIGATION OF THE SPREAD OF AN EPIDEMIC","4) SUFFICIENT & ROBUST HEALTH SECTOR TO TREAT THE SICK & PROTECT HEALTH WORKERS","5) COMMITMENTS TO IMPROVING NATIONAL CAPACITY, FINANCING AND ADHERENCE TO NORMS","6) OVERALL RISK ENVIRONMENT AND COUNTRY VULNERABILITY TO BIOLOGICAL THREATS"],"columns":7,"dataTypes":["double","double","double","double","double","double","double"],"header":"85×7 table","name":"GHSI_2021_table_transformed","rowNames":["Afghanistan","Andorra","Armenia","Australia","Austria","Azerbaijan","Belgium","Bangladesh","Bosnia and Herzegovina","Bolivia","Central African Republic","Canada","Switzerland","Chile"],"rows":85,"type":"table","value":[["9.2404","7.5729","9.8298","4.9923","12.0467","74.1094","39.2525"],["10.3886","15.3841","1.0386","6.1620","8.6542","51.0958","111.0164"],["14.7511","37.0648","24.0940","7.1289","25.1645","71.8773","62.0160"],["16.0262","31.6598","27.1098","7.3889","28.4969","89.0471","104.1775"],["14.0425","26.8906","16.5764","6.3105","23.5727","78.0585","121.2663"],["10.3886","17.9543","10.2312","5.6591","12.5099","44.9534","79.1553"],["14.3930","27.2591","19.7997","6.5903","26.9133","74.3723","105.9975"],["10.5369","13.7371","17.2713","5.3555","13.1324","49.8122","63.9021"],["10.5185","16.9389","7.2074","5.9724","19.3025","45.5910","66.5215"],["9.4624","20.1183","10.0860","5.3048","9.4927","29.3390","64.4834"],["6.9502","6.7007","6.6104","4.6024","5.0262","39.2412","31.7951"],["15.8529","33.6810","24.3886","6.7506","27.8989","98.3807","112.9990"],["14.3206","25.6105","16.8965","7.5426","22.5242","72.5333","117.2794"],["13.9390","24.3547","21.1794","7.2880","23.2026","63.9038","89.4213"]]}}
%---
