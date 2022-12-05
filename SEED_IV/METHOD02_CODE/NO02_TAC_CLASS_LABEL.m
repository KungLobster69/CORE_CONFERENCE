clc
clear all
close all

session01_label = [1,2,3,0,2,0,0,1,0,1,2,1,1,1,2,3,2,2,3,3,0,3,0,3];
session02_label = [2,1,3,0,0,2,0,2,3,3,2,3,2,0,1,1,2,1,0,3,0,1,3,1];
session03_label = [1,2,2,1,3,3,3,1,1,2,1,0,2,3,3,0,2,3,0,0,2,0,1,0];
for File_path = 1:3
    path_name = append('E:\THESIS\RESULT\SEED_IV\METHOD02\01.DATA_VDO\',num2str(File_path));
    DATA_VDO_name = append(path_name,'\DATA_VDO.mat');
    DATA_VDO_load = load(DATA_VDO_name);
    DATA_VDO = DATA_VDO_load.DATA_VDO;
    classlabel = [];
    NEXT_HUMAN = 0;
    if File_path == 1
        classlabel = session01_label;
        for Human = 1:15
            for VDO = 1:24
                DATA_VDO{VDO+NEXT_HUMAN,2} = classlabel(1,VDO);
            end
            NEXT_HUMAN = NEXT_HUMAN + 24;
        end
    end
    if File_path == 2
        classlabel = session02_label;
        for Human = 1:15
            for VDO = 1:24
                DATA_VDO{VDO+NEXT_HUMAN,2} = classlabel(1,VDO);
            end
            NEXT_HUMAN = NEXT_HUMAN + 24;
        end
    end
    if File_path == 3
        classlabel = session03_label;
        for Human = 1:15
            for VDO = 1:24
                DATA_VDO{VDO+NEXT_HUMAN,2} = classlabel(1,VDO);
            end
            NEXT_HUMAN = NEXT_HUMAN + 24;
        end
    end
    %% SAVE_DATA
    create_path = append('E:\THESIS\RESULT\SEED_IV\METHOD02\02.TAC_CLASS_LABEL\',num2str(File_path));
    create_DATA_VDO = append(create_path,'\DATA_VDO.mat');
    mkdir(create_path)
    save(create_DATA_VDO,'DATA_VDO','-v7.3')
end