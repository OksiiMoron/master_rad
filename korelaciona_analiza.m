%[text] ## Ucitavanje podataka
clear
load("GHSI_2021_transformed_data.mat");
load("PCA_data.mat");
GHSI_2019_matrix = table2array(GHSI_2019_table);
%[text] ## Korelaciona analiza izmedju rezultat PCA i odgovarajucih podataka
pocetni_podaci = {GHSI_2021, GHSI_2019, starost, bolesti, prosperitet};
podaci_pca = {GHSI_2021_PCS, GHSI_2019_PCS, starost_PCS, bolesti_PCS, prosperitet_PCS};
nazivi_grupaVsPC = {'GHSI_2021_vsPC', 'GHSI_2019_vsPC', 'starost_vsPC', 'bolesti_vsPC', 'prosperitet_vsPC'};
rezultati_CORR_PC = struct();
for i = 1:length(podaci_pca)
    pc_data = table2array(podaci_pca{i});
    combined_data = [pc_data, pocetni_podaci{i}];
    [coeff, p_values] = corr(combined_data);

    rezultati_CORR_PC.(nazivi_grupaVsPC{i}).coeff = coeff;
    rezultati_CORR_PC.(nazivi_grupaVsPC{i}).p_values = p_values;
end

disp(rezultati_CORR_PC.GHSI_2019_vsPC.coeff) %[output:7878a149]

%[text] ## Korelacija izmedju znacajnih PCs i m/r
m_r = GHSI_2019_matrix(:,18);
nazivi_PCvsmr = {'GHSI_2021_PCvsMR', 'GHSI_2019_PCvsMR', 'starost_vsMR', 'bolesti_vsMR', 'prosperitet_vsMR'};
rezultati_PC_mr = struct();
for i = 1:length(podaci_pca)
    pc_data = table2array(podaci_pca{i});
    [coeff, p_values] = corr(pc_data, m_r);

    rezultati_PC_mr.(nazivi_PCvsmr{i}).coeff = coeff;
    rezultati_PC_mr.(nazivi_PCvsmr{i}).p_values = p_values;
end

disp(rezultati_PC_mr.GHSI_2019_PCvsMR.coeff) %[output:35582e6d]

%[text] ## Korelacija varijabli koje nisu usle u PCA i m/r
var_noPCA = GHSI_2019_matrix(:, [16,17,20,21,24,26]);
nazivi_noPCAvsmr = {'IEvsMR', 'REvsMR', 'OBvsMR', 'SMvsMR', 'INvsMR', 'ONvsMR'};
rezultati_noPCA_mr = struct();
for i = 1:width(var_noPCA)
    [coeff, p_values] = corr(var_noPCA(:,i), m_r);

    rezultati_noPCA_mr.(nazivi_noPCAvsmr{i}).coeff = coeff;
    rezultati_noPCA_mr.(nazivi_noPCAvsmr{i}).p_values = p_values;
end

%[output:070f7c2e]

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
%[output:7878a149]
%   data: {"dataType":"text","outputData":{"text":"    1.0000   -0.0000   -0.0000    0.9948    0.9064    0.8077    0.8258    0.9099    0.7152    0.7291\n   -0.0000    1.0000   -0.0000   -0.0185    0.0410   -0.2468    0.0231    0.1528   -0.5646    0.5847\n   -0.0000   -0.0000    1.0000   -0.0390   -0.0945   -0.4204    0.4586    0.1072    0.1036   -0.1181\n    0.9948   -0.0185   -0.0390    1.0000    0.8948    0.8423    0.8194    0.8992    0.6941    0.7038\n    0.9064    0.0410   -0.0945    0.8948    1.0000    0.6820    0.6617    0.8003    0.6194    0.6613\n    0.8077   -0.2468   -0.4204    0.8423    0.6820    1.0000    0.5672    0.6436    0.5713    0.4466\n    0.8258    0.0231    0.4586    0.8194    0.6617    0.5672    1.0000    0.7503    0.5299    0.5246\n    0.9099    0.1528    0.1072    0.8992    0.8003    0.6436    0.7503    1.0000    0.5545    0.6838\n    0.7152   -0.5646    0.1036    0.6941    0.6194    0.5713    0.5299    0.5545    1.0000    0.2978\n    0.7291    0.5847   -0.1181    0.7038    0.6613    0.4466    0.5246    0.6838    0.2978    1.0000\n\n","truncated":false}}
%---
%[output:35582e6d]
%   data: {"dataType":"text","outputData":{"text":"    0.6582\n    0.4558\n   -0.1000\n\n","truncated":false}}
%---
%[output:070f7c2e]
%   data: {"dataType":"textualVariable","outputData":{"name":"coeff","value":"-0.6224"}}
%---
