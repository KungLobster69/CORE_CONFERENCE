clc
clear all
close all

for File_path = 1%:3
    path_TRAIN_CONVERT2STR_name = append('E:\THESIS\RESULT\SEED_IV\METHOD01\07.CONVERT2STR\',num2str(File_path));
    TRAIN_CONVERT2STR_name = append(path_TRAIN_CONVERT2STR_name,'\TRAIN_TRAIN_CONVERT2STR.mat');
    TRAIN_CONVERT2STR_load = load(TRAIN_CONVERT2STR_name);
    TRAIN_TRAIN_ORI = TRAIN_CONVERT2STR_load.TRAIN_TRAIN_CONVERT2STR;
    % Create_Class_label %
    for i = 1:size(TRAIN_TRAIN_ORI,1)
        
    end
    Random_ROW = randi(312,312,1);
end