%[text] ## Ucitavanje prethodno transformisanih podataka
clear
load("GHSI_2021_transformed_data.mat");
GHSI_2019_matrix = table2array(GHSI_2019_table);

% Grupisanje podataka iz prethodno transformisanih podataka za 2019. i
% 2021. godinu
GHSI_2021 = GHSI_2021_matrix_transformed;
GHSI_2019 = GHSI_2019_matrix(:, 2:8);
prosperitet = GHSI_2019_matrix(:, [10:11, 13:15]);
starost = GHSI_2019_matrix(:, [12, 18:19]);
bolesti = GHSI_2019_matrix(:, [22,23,end]);

% grupisanje podataka kako bi mogli da ih sprovedemo kroz for loop
grupe = {GHSI_2021, GHSI_2019, prosperitet, starost, bolesti};
nazivi = {'GHSI_2021', 'GHSI_2019', 'prosperitet', 'starost', 'bolesti'};
rezultati_PCA = struct();

for i= 1:length(grupe)
    % normalizovanje podataka
    norm_podaci = normalize(grupe{i});

    % PCA
    [coeff, score, latent, tsquared, explained] = pca(norm_podaci);
    nPCs = pcs_treshold(explained, 85);
    
    % grupisanje rezultata PCA u strukturu odakle mozemo po potrebi da
    % uzmemo sta nam treba za dalju analizu
    rezultati_PCA.(nazivi{i}).coeff = coeff(:, 1:nPCs);
    rezultati_PCA.(nazivi{i}).score = score(:, 1:nPCs);
    rezultati_PCA.(nazivi{i}).latent = latent(1:nPCs);
    rezultati_PCA.(nazivi{i}).explained = explained(1:nPCs);
    rezultati_PCA.(nazivi{i}).nPCs = nPCs;
end

% Formiranje posebnih tabela sa PCs
GHSI_2019_PCS = array2table(rezultati_PCA.GHSI_2019.score, "VariableNames", {'GHSI_2019_PC1', 'GHSI_2019_PC2', 'GHSI_2019_PC3'});
GHSI_2021_PCS = array2table(rezultati_PCA.GHSI_2021.score, "VariableNames", {'GHSI_2021_PC1', 'GHSI_2021_PC2', 'GHSI_2021_PC3'});
prosperitet_PCS = array2table(rezultati_PCA.prosperitet.score, "VariableNames", {'prosperitet_PC1', 'prosperitet_PC2'});
starost_PCS = array2table(rezultati_PCA.starost.score, "VariableNames", {'starost_PC1', 'starost_PC2'});
bolesti_PCS = array2table(rezultati_PCA.bolesti.score, "VariableNames", {'bolesti_PC1', 'bolesti_PC2'});

% Cuvanje tabela za datu upotrebu
save('PCA_data.mat', 'rezultati_PCA', 'GHSI_2019_PCS', 'GHSI_2021_PCS', 'prosperitet_PCS', 'starost_PCS', 'bolesti_PCS', 'GHSI_2021', 'GHSI_2019', 'bolesti', 'starost', 'prosperitet')

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":35.9}
%---
