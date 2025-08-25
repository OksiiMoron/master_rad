function data_wo_outliers = DnRoutlier(data)
    for i = 1:width(data)
        outliers = isoutlier(data(:,i));
        med = nanmedian(data(:,i));
        data(outliers, i) = med;
        
    end
    data_wo_outliers = data;
end