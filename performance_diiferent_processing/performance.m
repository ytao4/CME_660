

draw1("Isolation Forest",1)
draw1("One-Class SVM",2)
draw1("Mahalanobis Distance",3)

function draw1(t,i)
raw = load("case_raw.mat").data; % case 1
stand = load("case_standerdization.mat").data; % case 2
norm = load("case_normalization.mat").data; % case 3
pca = load("case_pca.mat").data; % case 4


FN1 = table2array(raw{1});FN2 = table2array(stand{1});
FN3 = table2array(norm{1});FN4 = table2array(pca{1});

FR1 = table2array(raw{2});FR2 = table2array(stand{2});
FR3 = table2array(norm{2});FR4 = table2array(pca{2});

LR1 = table2array(raw{3});LR2 = table2array(stand{3});
LR3 = table2array(norm{3});LR4 = table2array(pca{3});

T1 = table2array(raw{4});T2 = table2array(stand{4});
T3 = table2array(norm{4});T4 = table2array(pca{4});
n=1:21;
figure
subplot(2,2,1)
sgtitle(t)
plot(n,FN1(:,i),LineWidth=1)
hold on
plot(n,FN2(:,i),LineWidth=1,LineStyle='--')
plot(n,FN3(:,i),LineWidth=1,LineStyle='-.')
plot(n,FN4(:,i),LineWidth=1,LineStyle=':')
xticks(1:2:21);
xlim([1,21]);
xlabel("Fault")
ylabel("FP")
title("FP")
legend('case1', 'case2', 'case3', 'case4')
subplot(2,2,2)
plot(n,FR1(:,i))
hold on
plot(n,FR2(:,i),LineWidth=1,LineStyle='--')
plot(n,FR3(:,i),LineWidth=1,LineStyle='-.')
plot(n,FR4(:,i),LineWidth=1,LineStyle=':')
xticks(1:2:21);
xlim([1,21]);
xlabel("Fault")
ylabel("FPR/%")
title("FPR")
legend('case1', 'case2', 'case3', 'case4')
subplot(2,2,3)
plot(n,LR1(:,i),'r')
hold on
plot(n,LR2(:,i),LineWidth=1,LineStyle='--')
plot(n,LR3(:,i),LineWidth=1,LineStyle='-.')
plot(n,LR4(:,i),LineWidth=1,LineStyle=':')
xticks(1:2:21);
xlim([1,21]);
xlabel("Fault")
ylabel("FNR/%")
title("FNR")
legend('case1', 'case2', 'case3', 'case4')
subplot(2,2,4)
plot(n,T1(:,i),'r')
hold on
plot(n,T2(:,i),LineWidth=1,LineStyle='--')
plot(n,T3(:,i),LineWidth=1,LineStyle='-.')
plot(n,T4(:,i),LineWidth=1,LineStyle=':')
xticks(1:2:21);
xlim([1,21]);
xlabel("Fault")
ylabel("T")
title("T")
legend('case1', 'case2', 'case3', 'case4')
end
