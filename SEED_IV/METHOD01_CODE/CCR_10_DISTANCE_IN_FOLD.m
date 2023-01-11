clc
clear all
close all

for File_path = 3
    k = [70,80];
    for COL_K = 1:size(k,2)
        path_name = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD01\09.CROSS_VALIDATION\',num2str(File_path));
        K_FOLD = 4;
        for Order_K_FOLD = 1:K_FOLD
            TRAIN_TRAIN_name = append(path_name,'\TRAIN_TRAIN_LV5_200_',num2str(k(COL_K)),'_',num2str(Order_K_FOLD),'.mat');
            TRAIN_TEST_name = append(path_name,'\TRAIN_TEST_LV5_200_',num2str(k(COL_K)),'_',num2str(Order_K_FOLD),'.mat');
            TRAIN_TRAIN_load = load(TRAIN_TRAIN_name);
            TRAIN_TEST_load = load(TRAIN_TEST_name);
            TRAIN_TRAIN = TRAIN_TRAIN_load.TRAIN_TRAIN;
            TRAIN_TEST = TRAIN_TEST_load.TRAIN_TEST;
            SIZE_TRAIN_TRAIN = size(TRAIN_TRAIN,1);
            SIZE_TRAIN_TEST = size(TRAIN_TEST,1);
            Edit_Distance_FOLD = [];
            for ROW_TRAIN_TRAIN = 1:SIZE_TRAIN_TRAIN
                SAMPLE_TRAIN_TRAIN = TRAIN_TRAIN{ROW_TRAIN_TRAIN,1};
                for ROW_TRAIN_TEST = 1:SIZE_TRAIN_TEST
                    SAMPLE_TRAIN_TEST = TRAIN_TEST{ROW_TRAIN_TEST,1};
                    Edit_Distance_FOLD(ROW_TRAIN_TRAIN,ROW_TRAIN_TEST) = F01_EditDistance(SAMPLE_TRAIN_TRAIN,SAMPLE_TRAIN_TEST);
                end
            end
            % SAVE_DATA %
            create_path = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD01\10.DISTANCE_FOLD\',num2str(File_path));
            create_DISTANCE = append(create_path,'\DISTANCE_FOLD_LV5_200_',num2str(k(COL_K)),'_',num2str(Order_K_FOLD),'.mat');
            mkdir(create_path)
            save(create_DISTANCE,'Edit_Distance_FOLD','-v7.3')
        end
    end
end