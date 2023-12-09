clear, clc;
% [train, testdata]=corrSel();
data=loaddata();    
train=data(1);
train=cell2mat(train);

[train_row,train_col]=size(train);
[train,mu,sigma]=zscore(train);
train_mean = mu;
train_std = sigma;
a = load("D:\桌面\project\data\normaltrain.mat").ott;

qqq = table2array(a);
test = qqq(1:960*5,:);
% Mdl = fitcsvm(train,ones(size(train,1),1),OutlierFraction=0, ...
%     KernelScale="auto",Standardize=true);
% [~,s_OCSVM] = resubPredict(Mdl);
[forest,tf_forest,s_forest]=iforest(train);



n = size(test,1);
test=(test-repmat(train_mean,n,1))./repmat(train_std,n,1);
falm = 0;
xf = [];
% [~,sTest_OCSVM] = predict(Mdl,test);
[tfTest_forest,sTest_forest] = isanomaly(forest,test);

figure;
%     suptitle(['Fault',num2str(k-1)]);
%plot(1:n,sTest_OCSVMs,'k');
plot(1:n,sTest_forest,'k');
line([0,n],[forest.ScoreThreshold ,forest.ScoreThreshold ],'LineStyle','--','Color','r'); 

% 
% a = load("D:\桌面\project\data\normaltrain.mat").ott;
% data = table2array(a);
% N=4800;
% M=5;
% idx = crossvalind('Kfold',N,M);
% labels = logical(zeros(960,1));
% for i =1:5
%     val = data(idx == i, :);
%     train = data(~(idx == i), :);
%     [train_row,train_col]=size(train);
%     [train,mu,sigma]=zscore(train);
%     %PCA()   %PCA function
%     % [forest,tf_forest,s_forest]=iforest(train);
%     % [tfTest_forest,sTest_forest] = isanomaly(forest,val);
%     Mdl = fitcsvm(train,ones(size(train,1),1),OutlierFraction=0, ...
%     KernelScale="auto",Standardize=true);
%     [~,s_OCSVM] = resubPredict(Mdl);
%     [~,sTest_OCSVM] = predict(Mdl,val);
%     figure
%     % confMat = confusionmat(labels, tfTest_forest);
%     threshold = 0; % Define your threshold here
%     y_pred_binary = sTest_OCSVM(:, 1) > threshold;
%     confMat = confusionmat(labels, y_pred_binary);
%     confusionchart(confMat);
%     title('Confusion Matrix');
%     xlabel('Predicted Class');
%     ylabel('True Class');
% end
% 
