clc
clear all
close all

for File_path = 1:3
    path_TRAIN_CONVERT2STR_name = append('E:\THESIS\RESULT\SEED_IV\METHOD01\07.CONVERT2STR_62\',num2str(File_path));
    TRAIN_CONVERT2STR_name = append(path_TRAIN_CONVERT2STR_name,'\TRAIN_TRAIN_CONVERT2STR.mat');
    TRAIN_CONVERT2STR_load = load(TRAIN_CONVERT2STR_name);
    TRAIN_TRAIN_ORI = TRAIN_CONVERT2STR_load.TRAIN_TRAIN_CONVERT2STR;
    
    % Create_Class_label %
    NEXT_HUMAN = 0;
    for Human = 1:13
        for VDO = 1:24
            if VDO < 7
                TRAIN_TRAIN_ORI{VDO+NEXT_HUMAN,2} = 0;
            end
            if VDO >= 7 && VDO < 13
                TRAIN_TRAIN_ORI{VDO+NEXT_HUMAN,2} = 1;
            end
            if VDO >= 13 && VDO < 19
                TRAIN_TRAIN_ORI{VDO+NEXT_HUMAN,2} = 2;
            end
            if VDO >= 19 && VDO < 25
                TRAIN_TRAIN_ORI{VDO+NEXT_HUMAN,2} = 3;
            end
        end
        NEXT_HUMAN = NEXT_HUMAN+24;
    end
    % RANDOM DATA %
    Random_ROW = [];
    Random_ROW = randperm(312);
    
    % CHECK NUMBER %
    x = unique(Random_ROW);
    N = numel(x);
    count = zeros(N,1);
    for k = 1:N
        count(k) = sum(Random_ROW==x(k));
    end
    
    create_path = append('E:\THESIS\RESULT\SEED_IV\METHOD01\15.CROSS_VALIDATION_DATA_62\',num2str(File_path));
    mkdir(create_path)
    K_FOLD = 4;
    SIZE_TRAIN_TEST = size(Random_ROW,2)/K_FOLD;
    SIZE_TRAIN_TRAIN = size(TRAIN_TRAIN_ORI,1) - SIZE_TRAIN_TEST;
    % separate TRAIN_TEST && TRAIN_TRAIN %
    NEXT_FOLD = 0;
    for Order_K_FOLD = 1:K_FOLD
        TRAIN_TRAIN_COL = Random_ROW;
        TRAIN_TEST_ROW = [];
        for COL = 1:SIZE_TRAIN_TEST
            TRAIN_TEST_ROW(1,COL) = Random_ROW(1,COL+NEXT_FOLD);
            TRAIN_TRAIN_COL(1,COL+NEXT_FOLD) = 0;
        end
        TRAIN_TRAIN_ROW = [];
        COL_NEW = 1;
        for COL = 1:size(TRAIN_TRAIN_COL,2)
            if TRAIN_TRAIN_COL(1,COL) ~= 0
                TRAIN_TRAIN_ROW(1,COL_NEW) =  TRAIN_TRAIN_COL(1,COL);
                COL_NEW = COL_NEW+1;
            end
        end
        TRAIN_TEST = {};
        for COL = 1:SIZE_TRAIN_TEST
            TRAIN_TEST{COL,1} = TRAIN_TRAIN_ORI{TRAIN_TEST_ROW(1,COL),1};
            TRAIN_TEST{COL,2} = TRAIN_TRAIN_ORI{TRAIN_TEST_ROW(1,COL),2};
        end
        TRAIN_TRAIN = {};
        for COL = 1:size(TRAIN_TRAIN_ROW,2)
            TRAIN_TRAIN{COL,1} = TRAIN_TRAIN_ORI{TRAIN_TRAIN_ROW(1,COL),1};
            TRAIN_TRAIN{COL,2} = TRAIN_TRAIN_ORI{TRAIN_TRAIN_ROW(1,COL),2};
        end
        NEXT_FOLD = NEXT_FOLD+SIZE_TRAIN_TEST;
        % SAVE_DATA %
        create_TRAIN_TRAIN_DATA = append(create_path,'\TRAIN_TRAIN_FOLD_',num2str(Order_K_FOLD),'.mat');
        create_TRAIN_TEST_DATA = append(create_path,'\TRAIN_TEST_FOLD_',num2str(Order_K_FOLD),'.mat');
        save(create_TRAIN_TRAIN_DATA,'TRAIN_TRAIN','-v7.3')
        save(create_TRAIN_TEST_DATA,'TRAIN_TEST','-v7.3')
    end
end
