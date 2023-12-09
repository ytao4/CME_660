
clear,clc
[train,testdata] = PCA();



tr_mean=mean(train); 
c=cov(train); 
dis=zeros(size(train,1),1);
frecord = fopen('./records_MD_5%.txt','w');
for i=1:size(train,1)
    
    dis(i)=(train(i,:)-tr_mean)*inv(c)*(train(i,:)-tr_mean)';
end
m=max(dis);
C=inv(c); 
delta=0.95; 
aa=[];bb=[];cc=[];dd=[];

for k = 1:21
    
    disp(k)
    fprintf(frecord,'Fault(%d)—',k);
    test = cell2mat(testdata(k));
    
    n = size(test,1); 
    
    falm = 0;
    xf = []; 
    d=zeros(n,1);
    
    for i = 1:n
        d(i)=(test(i,:)-tr_mean)*C*(test(i,:)-tr_mean)';
        if d(i)>m*delta
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
    plot(1:n,d,'k');  
    xticks([0,160,500,1000]);
    str=['Fault ' num2str(k) ' Diagnosis Plot' '(Mahalanobis Distance)'];
    title(str); 
    xlabel('sample'); 
    ylabel('score'); 
    hold on;
    line([0,n],[m*delta,m*delta],'LineStyle','--','Color','r');    
%     text(n-100,0,"thresholdbelowoutlier",'Color','r')
end
fclose(frecord);
filename='PerformanceRecording.xlsx';
writematrix(aa,filename,'Sheet',1,'Range','F2:F22');
writematrix(bb,filename,'Sheet',2,'Range','F2:F22');
writematrix(cc,filename,'Sheet',3,'Range','F2:F22');
writematrix(dd,filename,'Sheet',4,'Range','F2:F22');
