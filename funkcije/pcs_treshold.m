function num_significantPCA = pcs_treshold(explained, treshold)
    kumulativna_suma = cumsum(explained);
    num_significantPCA = find(kumulativna_suma >= treshold, 1, 'first');
end

%[appendix]{"version":"1.0"}
%---
