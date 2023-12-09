% confusion matrix
% normal data
% pick normal data from the fault data
clear,clc
[train,testdata] = PCA();



frecord = fopen('./records2.txt','w');
aa=[];bb=[];cc=[];dd=[]; 
[forest,tf_forest,s_forest]=iforest(train);

for k = 1:21
    
    disp(k);
    fprintf(frecord,'Fault(%d)—',k);
    test = cell2mat(testdata(k));
    
    n = size(test,1); 
    
    %sTest_forest=zeros(n,1);
    falm = 0;
    xf = []; 
    [tfTest_forest,sTest_forest] = isanomaly(forest,test);
    for i = 1:n
        if sTest_forest(i) > forest.ScoreThreshold 
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
    aa=[aa;falm];bb=[bb;falm/1.6];cc=[cc;100-length(xf)/8];dd=[dd;xf(1)-161];
   
    figure;

    plot(1:n,sTest_forest,'k');  
    xticks([0,160,500,1000]);
    str=['Fault ' num2str(k) ' Diagnosis Plot' '(IF)'];
    title(str); 
    xlabel('sample'); 
    ylabel('Score'); 
    hold on;
    line([0,n],[forest.ScoreThreshold ,forest.ScoreThreshold ],'LineStyle','--','Color','r');%画出标志线      
end
fclose(frecord);
filename = 'PerformanceRecording.xlsx';
writematrix(aa,filename,'Sheet',1,'Range','D2:D22');
writematrix(bb,filename,'Sheet',2,'Range','D2:D22');
writematrix(cc,filename,'Sheet',3,'Range','D2:D22');
writematrix(dd,filename,'Sheet',4,'Range','D2:D22');
