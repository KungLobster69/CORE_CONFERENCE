clc
clear all
close all

k = [50,60,70,80];
for COL_K = 1:size(k,2)
    path_name = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD02\07.CONVERT2STR');
    TRAIN_STR_name = append(path_name,'\TRAIN_STR_LV5_200_',num2str(k(COL_K)),'.mat');
    TRAIN_STR_load = load(TRAIN_STR_name);
    TRAIN_STR = TRAIN_STR_load.CONVERT2STR;
    
    % RANDOM DATA %
    Random_ROW = [];
    Random_ROW = randperm(size(TRAIN_STR,1));
    
    % CHECK NUMBER %
    x = unique(Random_ROW);
    N = numel(x);
    count = zeros(N,1);
    for c = 1:N
        count(c) = sum(Random_ROW==x(c));
    end
    
    K_FOLD = 4; % เปลี่ยนเลขสำหรับ CROSS VALIDATION %
    SIZE_TRAIN_TEST = size(Random_ROW,2)/K_FOLD;
    SIZE_TRAIN_TRAIN = size(TRAIN_STR,1) - SIZE_TRAIN_TEST;
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
            TRAIN_TEST{COL,1} = TRAIN_STR{TRAIN_TEST_ROW(1,COL),1};
            TRAIN_TEST{COL,2} = TRAIN_STR{TRAIN_TEST_ROW(1,COL),2};
        end
        TRAIN_TRAIN = {};
        for COL = 1:SIZE_TRAIN_TRAIN
            TRAIN_TRAIN{COL,1} = TRAIN_STR{TRAIN_TRAIN_ROW(1,COL),1};
            TRAIN_TRAIN{COL,2} = TRAIN_STR{TRAIN_TRAIN_ROW(1,COL),2};
        end
        NEXT_FOLD = NEXT_FOLD+SIZE_TRAIN_TEST;
        % SAVE_DATA %
        create_path = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD02\09.CROSS_VALIDATION');
        mkdir(create_path)
        create_TRAIN_TRAIN_DATA = append(create_path,'\TRAIN_TRAIN_LV5_200_',num2str(k(COL_K)),'_',num2str(Order_K_FOLD),'.mat');
        create_TRAIN_TEST_DATA = append(create_path,'\TRAIN_TEST_LV5_200_',num2str(k(COL_K)),'_',num2str(Order_K_FOLD),'.mat');
        save(create_TRAIN_TRAIN_DATA,'TRAIN_TRAIN','-v7.3')
        save(create_TRAIN_TEST_DATA,'TRAIN_TEST','-v7.3')
    end
end
