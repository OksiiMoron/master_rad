%[text] ## Ucitavanje prethodno transformisanih podataka
% Grupisanje podataka iz prethodno transformisanih podataka za 2019. i
% 2021. godinu
GHSI_2021 = GHSI_2021_matrix_transformed;
GHSI_2019 = GHSI_2019_matrix(:, 2:8);
prosperitet = GHSI_2019_matrix(:, [10:11, 13:15]);
starost = GHSI_2019_matrix(:, [12, 18:19]);
bolesti = GHSI_2019_matrix(:, [22,23,end]);

% Normalizacija podataka
GHSI_2021_normalized = normalize(GHSI_2021);
GHSI_2019_normalized = normalize(GHSI_2019);
prosperitet_normalized = normalize(prosperitet);
starost_normalized = normalize(starost);
bolesti_normalized = normalize(bolesti);

[coeff, score, latent, tsquared, explained] = pca(GHSI_2021_normalized);
pcs_treshold(explained, 85) %[output:865febb9]



%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
%[output:865febb9]
%   data: {"dataType":"textualVariable","outputData":{"name":"ans","value":"3"}}
%---
