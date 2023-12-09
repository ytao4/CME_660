%%
t2SPE = load("T2ANDSPE.mat").data;
raw = load("case_raw.mat").data; % case 1
stand = load("case_standerdization.mat").data; % case 2
norm = load("case_normalization.mat").data; % case 3
pca = load("case_pca.mat").data; % case 4

best_FN=table2array(t2SPE{1});
best_FN(1:21,3:5)=table2array(pca{1});
best_FR=table2array(t2SPE{2});
best_FR(1:21,3:5)=table2array(stand{2});
best_LR=table2array(t2SPE{3});
best_LR(1:21,3:5)=table2array(stand{3});
best_T=table2array(t2SPE{4});
best_T(1:21,3:5)=table2array(stand{4});

n=1:21;
figure
subplot(2,2,1)
sgtitle("Performance of different algorithms")
plot(n,best_FN(:,1),LineWidth=1,LineStyle="-")
hold on
plot(n,best_FN(:,2),LineWidth=1,LineStyle="--")
plot(n,best_FN(:,3),LineWidth=1,LineStyle="-.")
plot(n,best_FN(:,4),LineWidth=1,LineStyle=":")
plot(n,best_FN(:,5),LineWidth=1,LineStyle="--",Marker="*",MarkerSize=3)
xticks(1:2:21);
xlim([1,21]);
ylim([0,14]);
xlabel("Fault")
ylabel("FP")
title("FP")
legend('PCA(T2)', 'PCA(SPE)', 'IF', 'OCSVM' ,'MD')
subplot(2,2,2)
plot(n,best_FR(:,1),LineWidth=1,LineStyle="-")
hold on
plot(n,best_FR(:,2),LineWidth=1,LineStyle="--")
plot(n,best_FR(:,3),LineWidth=1,LineStyle="-.")
plot(n,best_FR(:,4),LineWidth=1,LineStyle=":")
plot(n,best_FR(:,5),LineWidth=1,LineStyle="--",Marker="*",MarkerSize=3)
xticks(1:2:21);
xlim([1,21]);
ylim([0,10]);
xlabel("Fault")
ylabel("FPR/%")
title("FPR")
legend('PCA(T2)', 'PCA(SPE)', 'IF', 'OCSVM' ,'MD')
subplot(2,2,3)
plot(n,best_LR(:,1),LineWidth=1,LineStyle="-")
hold on
plot(n,best_LR(:,2),LineWidth=1,LineStyle="--")
plot(n,best_LR(:,3),LineWidth=1,LineStyle="-.")
plot(n,best_LR(:,4),LineWidth=1,LineStyle=":")
plot(n,best_LR(:,5),LineWidth=1,LineStyle="--",Marker="*",MarkerSize=3)
xticks(1:2:21);
xlim([1,21]);
%ylim([0,10]);
xlabel("Fault")
ylabel("FNR/%")
title("FNR")
legend('PCA(T2)', 'PCA(SPE)', 'IF', 'OCSVM' ,'MD')
subplot(2,2,4)
plot(n,best_T(:,1),LineWidth=1,LineStyle="-")
hold on
plot(n,best_T(:,2),LineWidth=1,LineStyle="--")
plot(n,best_T(:,3),LineWidth=1,LineStyle="-.")
plot(n,best_T(:,4),LineWidth=1,LineStyle=":")
plot(n,best_T(:,5),LineWidth=1,LineStyle="--",Marker="*",MarkerSize=3)
xticks(1:2:21);
xlim([1,21]);
%ylim([0,10]);
xlabel("Fault")
ylabel("T")
title("T")
legend('PCA(T2)', 'PCA(SPE)', 'IF', 'OCSVM' ,'MD')