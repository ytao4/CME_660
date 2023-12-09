
function [train, testdata]=corrSel()
    % import the data, using z-store to standardize the train data
    data=loaddata();    
    train=data(1);
    train=cell2mat(train);
    dataa = train;
    testdata=data(2:22);
    
    corrMatrix = corr(dataa);
    threshold = 0.9; % example threshold
    numFeatures = size(dataa, 2);
    selectedFeatures = true(1, numFeatures);
    
    
    for i = 1:numFeatures
        for j = i+1:numFeatures
            if abs(corrMatrix(i, j)) > threshold
                % If features are highly correlated, remove one
                selectedFeatures(j) = false;
            end
        end
    end
    
    train = dataa(:, selectedFeatures);
    
    for i=1:21
        test = testdata{i};
        testdata{i} = test(:, selectedFeatures);
    end
end