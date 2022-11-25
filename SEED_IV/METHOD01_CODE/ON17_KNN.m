clc
clear all
close all

for File_path = 1%:3
    path_name = append('E:\THESIS\RESULT\SEED_IV\METHOD01\16.Edit_Distance_DATA\',num2str(File_path));
    Edit_Distance_DATA_name = append(path_name,'\Edit_Distance_DATA.mat');
    Edit_Distance_DATA_load = load(Edit_Distance_DATA_name);
    Edit_Distance_DATA = Edit_Distance_DATA_load.Edit_Distance_DATA;
    for Order_K_FOLD = 1%:4
    end
end