 function [train, testdata] = PCA()
  
    data = loaddata(); 
    train = data{1}; 
    test = data(2:22); 

 


   
    [train, mu, sigma] = zscore(train);

    % PCA dimensionality reduction
    covMatrix = cov(train); 
    [eigenVectors, eigenValues] = eig(covMatrix); 
    eigenValuesDiag = diag(eigenValues); 
    [sortedEigenValues, sortOrder] = sort(eigenValuesDiag, 'descend'); 
    sortedEigenVectors = eigenVectors(:, sortOrder); 


    cumVar = cumsum(sortedEigenValues) / sum(sortedEigenValues);
    numComponents = find(cumVar >= 0.9, 1); 

    principalComponents = sortedEigenVectors(:, 1:numComponents); 
    train = train * principalComponents; 

    testdataTransformed = cell(size(test));

    
    for i = 1:numel(test)

        test{i} = (test{i} - mu) ./ sigma; 
        testdataTransformed{i} = test{i} * principalComponents; 
    end

    testdata = testdataTransformed;
end
