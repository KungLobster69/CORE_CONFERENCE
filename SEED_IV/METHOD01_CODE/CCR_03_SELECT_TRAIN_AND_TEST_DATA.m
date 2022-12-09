clc
clear
close all

for File_path = 1:3
    path_name = append('E:\THESIS\RESULT\SEED_IV_CONFERENCE\METHOD01\02.CLASS_LABEL\',num2str(File_path));
    DATA_VDO_name = append(path_name,'\DATA_VDO.mat');
    DATA_VDO_load = load(DATA_VDO_name);
    DATA_VDO = DATA_VDO_load.DATA_VDO;
    TEST_VDO = {};
    TRAIN_VDO = {};
    for ROW = 1:48
        TEST_VDO(ROW,:) = DATA_VDO(ROW+312,:);
    end
    for ROW = 1:312
        TRAIN_VDO(ROW,:) = DATA_VDO(ROW,:);
    end
    % SAVE_DATA
    create_path = append('E:\THESIS\RESULT\SEED_IV_CONFERENCE\METHOD01\03.TRAIN_AND_TEST_DATA\',num2str(File_path));
    create_TRAIN_VDO = append(create_path,'\TRAIN_VDO.mat');
    create_TEST_VDO = append(create_path,'\TEST_VDO.mat');
    mkdir(create_path)
    save(create_TRAIN_VDO,'TRAIN_VDO','-v7.3')
    save(create_TEST_VDO,'TEST_VDO','-v7.3')
end
