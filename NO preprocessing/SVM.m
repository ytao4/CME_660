% One-Class Support Vector Machine (OCSVM)

clear,clc
% % import the data, using z-store to standardize the train data
% data=loaddata();    
% train=data(1);
% train=cell2mat(train);
% testdata=data(2:22);
[train, testdata]=corrSel();

Mdl = fitcsvm(train,ones(size(train,1),1),OutlierFraction=0, ...
    KernelScale="auto",Standardize=true);
[~,s_OCSVM] = resubPredict(Mdl);
frecord = fopen('./records3.txt','w');
aa=[];bb=[];cc=[];dd=[];

for k = 1:21
    
    disp(k)
    fprintf(frecord,'Fault(%d)—',k);
    test = cell2mat(testdata(k));
 
    n = size(test,1); 
    %test=(test-repmat(train_mean,n,1))./repmat(train_std,n,1); 
    falm = 0;
    xf = []; 
  
    [~,sTest_OCSVM] = predict(Mdl,test);
    for i = 1:n
        if sTest_OCSVM(i) < 0
            if i < 161
                falm = falm + 1; 
            else
                xf = cat(1, xf, i); 
            end
        end
    end
    if isempty(xf) 
        xf(1)=inf;
    end
    fprintf(frecord,'(FP/FPR/FN/T)：%3d/%.2f/%.2f/%d\n',falm,falm/1.6,100-length(xf)/8,xf(1)-161);
    aa=[aa;falm];bb=[bb;falm/1.6];cc=[cc;100-length(xf)/8];dd=[dd;xf(1)-161];
    
    figure;
%     suptitle(['Fault',num2str(k-1)]); 
    plot(1:n,sTest_OCSVM,'k');  
    xticks([0,160,500,1000]);
    str=['Fault ' num2str(k) ' Diagnosis Plot' '(OCSVM)'];
    title(str); 
    xlabel('sample'); 
    ylabel('score'); 
    hold on;
    line([0,n],[0,0],'LineStyle','--','Color','r');    
    text(n-100,0,"belowoutliers",'Color','r')
end
fclose(frecord);
filename='PerformanceRecording.xlsx';
writematrix(aa,filename,'Sheet',1,'Range','E2:E22');
writematrix(bb,filename,'Sheet',2,'Range','E2:E22');
writematrix(cc,filename,'Sheet',3,'Range','E2:E22');
writematrix(dd,filename,'Sheet',4,'Range','E2:E22');
