clc
clear all
close all

for File_path = 1%:3
    path_name = append('E:\THESIS\RESULT\SEED_IV\METHOD02\01.DATA_VDO\',num2str(File_path));
    DATA_VDO_name = append(path_name,'\DATA_VDO.mat');
    DATA_VDO_load = load(DATA_VDO_name);
    DATA_VDO = DATA_VDO_load.DATA_VDO;
end