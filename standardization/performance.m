
clear, clc;
feature('DefaultCharacterSet', 'UTF8');
sheetNames = sheetnames('PerformanceRecording.xlsx');
data = cell(length(sheetNames), 1); % Initialize a cell array to store data from each sheet
for i = 1:length(sheetNames)
    data{i} = readtable('PerformanceRecording.xlsx', 'Sheet', sheetNames{i});
end


save('D:\桌面\CME660 MATLAB\performance_diiferent_processing/case_standerdization',"data");

