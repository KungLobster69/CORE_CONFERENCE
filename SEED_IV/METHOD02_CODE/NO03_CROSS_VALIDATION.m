clc
clear all
close all

for File_path = 1%:3
    path_name = append('E:\THESIS\RESULT\SEED_IV\METHOD02\02.TAC_CLASS_LABEL\',num2str(File_path));
    DATA_VDO_name = append(path_name,'\DATA_VDO.mat');
    DATA_VDO_load = load(DATA_VDO_name);
    DATA_VDO = DATA_VDO_load.DATA_VDO;
    
    % RANDOM DATA %
    Random_ROW = [];
    Random_ROW = randperm(312);
    check_num = unique(Random_ROW);
    create_path = append('E:\THESIS\RESULT\SEED_IV\METHOD02\03.CROSS_VALIDATION_DATA_K(4)\',num2str(File_path));
    mkdir(create_path)
    K_FOLD = 4;
    SIZE_TRAIN_TEST = size(Random_ROW,2)/K_FOLD;
    SIZE_TRAIN_TRAIN = size(DATA_VDO,1) - SIZE_TRAIN_TEST;
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
            TRAIN_TEST{COL,1} = DATA_VDO{TRAIN_TEST_ROW(1,COL),1};
            TRAIN_TEST{COL,2} = DATA_VDO{TRAIN_TEST_ROW(1,COL),2};
        end
        TRAIN_TRAIN = {};
        for COL = 1:size(TRAIN_TRAIN_ROW,2)
            TRAIN_TRAIN{COL,1} = DATA_VDO{TRAIN_TRAIN_ROW(1,COL),1};
            TRAIN_TRAIN{COL,2} = DATA_VDO{TRAIN_TRAIN_ROW(1,COL),2};
        end
        NEXT_FOLD = NEXT_FOLD+SIZE_TRAIN_TEST;
    end
end