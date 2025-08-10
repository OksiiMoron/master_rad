%[text] ## Uvoz i transformacija podataka
GHSI_2019_table = readtable("mr_GHSI_demo_data_transf_out.csv", VariableNamingRule="preserve", ReadRowNames=true);
GHSI_2021_table = readtable("GHSI_2021_large_table.csv", VariableNamingRule="preserve", ReadRowNames=true);

% filtriranje po zajednickim drzavama
idx = ismember(GHSI_2019_table.Properties.RowNames, GHSI_2021_table.Properties.RowNames);
GHSI_2021_table_filtered = GHSI_2021_table(idx, :);

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

GHSI_2021_table_transformed = array2table(GHSI_2021_matrix_transformed, VariableNames=col_names, RowNames=countryNames);


%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
