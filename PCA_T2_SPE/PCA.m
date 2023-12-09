clear,clc
% import the data, 
data=loaddata();    
train=data(1);
train=cell2mat(train);
testdata=data(2:22);
[train_row,train_col]=size(train);
[train,mu,sigma]=zscore(train);

train_mean = mu;
train_std = sigma;

sigmatrain = cov(train); 
[T,lamda] = eig(sigmatrain);
D = flipud(diag(lamda)); 
num_pc = 1;
while sum(D(1:num_pc))/sum(D) < 0.9
    num_pc = num_pc +1;
end
P = T(:,train_col-num_pc+1:train_col); 


T2UCL1=num_pc*(train_row-1)*(train_row+1)*finv(0.99,num_pc,train_row - num_pc)/(train_row*(train_row - num_pc)); 
T2UCL2=num_pc*(train_row-1)*(train_row+1)*finv(0.95,num_pc,train_row - num_pc)/(train_row*(train_row - num_pc));

theta = zeros(3,1);
for i = 1:3 
    theta(i) = sum((D(num_pc+1:train_col)).^i);
end 
h0 = 1 - 2*theta(1)*theta(3)/(3*theta(2)^2);
ca = norminv(0.99,0,1);
SPE = theta(1)*(h0*ca*sqrt(2*theta(2))/theta(1) + 1 + theta(2)*h0*(h0 - 1)/theta(1)^2)^(1/h0);
frecord = fopen('./records.txt','w');

aa=[];bb=[];cc=[];dd=[];
ee=[];ff=[];gg=[];hh=[];
for k = 1:21
    
    fprintf(frecord,'故障模式(%d)—',k);
    test = cell2mat(testdata(k));
    
    n = size(test,1); 
    test=(test-repmat(train_mean,n,1))./repmat(train_std,n,1); 
    
    [r,y] = size(P*P');
    I = eye(r,y); 
    T2_test = zeros(n,1);
    SPE_test = zeros(n,1);
    T2_falm = 0; SPE_falm = 0;
    xf_T2 = []; cf_SPE = [];
    for i = 1:n
        T2_test(i)=test(i,:)*P/lamda(train_col-num_pc+1:train_col,train_col-num_pc+1:train_col)*P'*test(i,:)';
        SPE_test(i) = test(i,:)*(I - P*P')*test(i,:)';
        if T2_test(i) > T2UCL1 
            if i < 161
                T2_falm = T2_falm + 1; 
            else
                xf_T2 = cat(1, xf_T2, i); 
            end
        end
        if SPE_test(i) > SPE  
            if i < 161      
                SPE_falm = SPE_falm + 1; 
            else
                cf_SPE = cat(1, cf_SPE, i); 
            end
        end
    end
    aa=[aa;T2_falm];bb=[bb;T2_falm/1.6];cc=[cc;100-length(xf_T2)/8];dd=[dd;xf_T2(1)-161];
    ee=[ee;SPE_falm];ff=[ff;SPE_falm/1.6];gg=[gg;100-length(cf_SPE)/8];hh=[hh;cf_SPE(1)-161];
    
    figure;
    subplot(121); 
    plot(1:n,T2_test,'k');  
    xticks([0,160,500,1000]);
    title('PCA T^2'); 
    xlabel('sample'); 
    ylabel('T^2'); 
    hold on;
    line([0,n],[T2UCL1,T2UCL1],'LineStyle','--','Color','r');
    line([0,n],[T2UCL2,T2UCL2],'LineStyle','--','Color','g'); 
    subplot(122); 
    plot(1:n,SPE_test,'k'); 
    xticks([0,160,500,1000]);
    title('PCA SPE');
    xlabel('sample'); 
    ylabel('SPE'); 
    hold on;
    line([0,n],[SPE,SPE],'LineStyle','--','Color','r');
end
fclose(frecord);

writematrix(aa,'PerformanceRecording.xlsx','Sheet',1,'Range','B2:B22');
writematrix(bb,'PerformanceRecording.xlsx','Sheet',2,'Range','B2:B22');
writematrix(cc,'PerformanceRecording.xlsx','Sheet',3,'Range','B2:B22');
writematrix(dd,'PerformanceRecording.xlsx','Sheet',4,'Range','B2:B22');
writematrix(ee,'PerformanceRecording.xlsx','Sheet',1,'Range','C2:C22');
writematrix(ff,'PerformanceRecording.xlsx','Sheet',2,'Range','C2:C22');
writematrix(gg,'PerformanceRecording.xlsx','Sheet',3,'Range','C2:C22');
writematrix(hh,'PerformanceRecording.xlsx','Sheet',4,'Range','C2:C22');





