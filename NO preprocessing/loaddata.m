function data=loaddata()
    pathname='D:\桌面\CME 660\Project\TE_process\TE_process/';
    for i=0:21
        if i<10
            index=['0' num2str(i)];
        else
            index=num2str(i);
        end
        dataname=[pathname 'd' index '_te' '.dat'];
        data{i+1}=load(dataname);
    end
end


