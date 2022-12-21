clc
clear all
close all

for File_path = 1
    path_name_TRAIN = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD01\09.CROSS_VALIDATION\',num2str(File_path));
    TRAIN_name = append(path_name_TRAIN,'\TRAIN_TRAIN_LV3_200_50_2.mat');
    TRAIN_load = load(TRAIN_name);
    TRAIN = TRAIN_load.TRAIN_TRAIN;
    path_name_TEST = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD01\16.TEST_CONVERT2STR\',num2str(File_path));
    TEST_name = append(path_name_TEST,'\TEST_STR_LV3_200_50.mat');
    TEST_load = load(TEST_name);
    TEST = TEST_load.CONVERT2STR;
    Edit_Distance = [];
    for ROW_TRAIN = 1:size(TRAIN,1)
        SAMPLE_TRAIN = TRAIN{ROW_TRAIN,1};
        for ROW_TEST = 1:size(TEST,1)
            SAMPLE_TEST = TEST{ROW_TEST,1};
            Edit_Distance(ROW_TRAIN,ROW_TEST) = F01_EditDistance(SAMPLE_TRAIN,SAMPLE_TEST);
        end
    end
    % SAVE_DATA %
    create_path = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD01\17.TEST_DISTANCE\',num2str(File_path));
    create_DISTANCE = append(create_path,'\TEST_DISTANCE_LV3_200_50.mat');
    mkdir(create_path)
    save(create_DISTANCE,'Edit_Distance','-v7.3')
end