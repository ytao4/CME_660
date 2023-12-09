function corrmatrix_heatmap(data)
    corrMatrix = corrcoef(data);
    heatmap(corrMatrix);
    title('Correlation Matrix Map');
end