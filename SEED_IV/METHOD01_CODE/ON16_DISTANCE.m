clc
clear all
close all

for File_path = 1%:3
    path_name = append('E:\THESIS\RESULT\SEED_IV\METHOD01\15.CROSS_VALIDATION_DATA\',num2str(File_path));
    for Order_K_FOLD = 1%:4
        TRAIN_TRAIN_name = append(path_name,'\TRAIN_TRAIN_FOLD_',num2str(Order_K_FOLD),'.mat');
        TRAIN_TEST_name = append(path_name,'\TRAIN_TEST_FOLD_',num2str(Order_K_FOLD),'.mat');
        TRAIN_TRAIN_load = load(TRAIN_TRAIN_name);
        TRAIN_TEST_load = load(TRAIN_TEST_name);
        TRAIN_TRAIN = TRAIN_TRAIN_load.TRAIN_TRAIN;
        TRAIN_TEST = TRAIN_TEST_load.TRAIN_TEST;
        Edit_Distance_FOLD = [];
        for ROW_TRAIN_TRAIN = 1:size(TRAIN_TRAIN,1)
            for ROW_TRAIN_TEST = 1:size(TRAIN_TEST,1)
                Sample_TRAIN_TRAIN = TRAIN_TRAIN{ROW_TRAIN_TRAIN,1};
                Sample_TRAIN_TEST = TRAIN_TEST{ROW_TRAIN_TEST,1};
                Check_Empty_TRAIN_TRAIN = isempty(Sample_TRAIN_TRAIN);
                Check_Empty_TRAIN_TEST = isempty(Sample_TRAIN_TEST);
                if Check_Empty_TRAIN_TRAIN == 0 && Check_Empty_TRAIN_TEST == 0
                    Edit_Distance_FOLD(ROW_TRAIN_TEST,ROW_TRAIN_TRAIN) = F01_EditDistance(Sample_TRAIN_TRAIN,Sample_TRAIN_TEST);
                else
                    Edit_Distance_FOLD = 0;
                end
            end
        end
        Edit_Distance_DATA{Order_K_FOLD,1} = Edit_Distance_FOLD;
        Edit_Distance_DATA{Order_K_FOLD,2} = TRAIN_TRAIN(:,2);
        Edit_Distance_DATA{Order_K_FOLD,3} = TRAIN_TEST(:,2);
    end
    create_path = append('E:\THESIS\RESULT\SEED_IV\METHOD01\16.Edit_Distance_DATA\',num2str(File_path));
    mkdir(create_path)
    create_Edit_Distance_DATA = append(create_path,'\Edit_Distance_DATA.mat');
    save(create_Edit_Distance_DATA,'Edit_Distance_DATA','-v7.3')
end