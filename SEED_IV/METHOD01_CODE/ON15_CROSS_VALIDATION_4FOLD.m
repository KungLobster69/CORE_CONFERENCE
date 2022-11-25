clc
clear all
close all

for File_path = 1:3
    path_TRAIN_CONVERT2STR_name = append('E:\THESIS\RESULT\SEED_IV\METHOD01\07.CONVERT2STR\',num2str(File_path));
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
    Random_ROW = randi(312,312,1);
    for RANDOM = 1:size(TRAIN_TRAIN_ORI,1)
        Sample_Random_ROW = Random_ROW(RANDOM,1);
        TRAIN_TRAIN_RANDOM(RANDOM,:) = TRAIN_TRAIN_ORI(Sample_Random_ROW,:);
    end
    K_FOLD = 4;
    SIZE_TRAIN_TRAIN_RANDOM = size(TRAIN_TRAIN_RANDOM,1);
    SIZE_TRAIN_TEST = SIZE_TRAIN_TRAIN_RANDOM/K_FOLD;
    SIZE_TRAIN_TRAIN = SIZE_TRAIN_TRAIN_RANDOM - SIZE_TRAIN_TEST;
    create_path = append('E:\THESIS\RESULT\SEED_IV\METHOD01\15.CROSS_VALIDATION_DATA\',num2str(File_path));
    mkdir(create_path)
    NEXT_FOLD = 0;
    for Order_K_FOLD = 1:K_FOLD
        TRAIN_TRAIN = TRAIN_TRAIN_RANDOM;
        % TRAIN TEST DATA %
        for SAMPLE_TRAIN_TEST = 1:SIZE_TRAIN_TEST
            TRAIN_TEST{SAMPLE_TRAIN_TEST,1} = TRAIN_TRAIN_RANDOM{SAMPLE_TRAIN_TEST+NEXT_FOLD,1};
            TRAIN_TEST{SAMPLE_TRAIN_TEST,2} = TRAIN_TRAIN_RANDOM{SAMPLE_TRAIN_TEST+NEXT_FOLD,2};
            TRAIN_TRAIN{SAMPLE_TRAIN_TEST+NEXT_FOLD,1} = {};
            TRAIN_TRAIN{SAMPLE_TRAIN_TEST+NEXT_FOLD,2} = {};
        end
        % Data management %
        for SAMPLE_TRAIN_TRAIN = 1:SIZE_TRAIN_TRAIN_RANDOM
            if SAMPLE_TRAIN_TRAIN <= SIZE_TRAIN_TRAIN
                CHECK_EMPTY = isempty(TRAIN_TRAIN{SAMPLE_TRAIN_TRAIN});
                if CHECK_EMPTY == 1
                    TRAIN_TRAIN{SAMPLE_TRAIN_TRAIN,1} = TRAIN_TRAIN{SAMPLE_TRAIN_TRAIN+SIZE_TRAIN_TEST,1};
                    TRAIN_TRAIN{SAMPLE_TRAIN_TRAIN,2} = TRAIN_TRAIN{SAMPLE_TRAIN_TRAIN+SIZE_TRAIN_TEST,2};
                    TRAIN_TRAIN{SAMPLE_TRAIN_TRAIN+SIZE_TRAIN_TEST,1} = {};
                    TRAIN_TRAIN{SAMPLE_TRAIN_TRAIN+SIZE_TRAIN_TEST,2} = {};
                else
                    TRAIN_TRAIN{SAMPLE_TRAIN_TRAIN,1} = TRAIN_TRAIN{SAMPLE_TRAIN_TRAIN,1};
                    TRAIN_TRAIN{SAMPLE_TRAIN_TRAIN,2} = TRAIN_TRAIN{SAMPLE_TRAIN_TRAIN,2};
                end
            end
        end
        % Delete Empty %
        for i = 1:SIZE_TRAIN_TRAIN
            TRAIN_TRAIN_DELETE_EMPTY{i,1} = TRAIN_TRAIN{i,1};
            TRAIN_TRAIN_DELETE_EMPTY{i,2} = TRAIN_TRAIN{i,2};
        end
        NEXT_FOLD = NEXT_FOLD+SIZE_TRAIN_TEST;
        % SAVE_DATA %
        create_TRAIN_TRAIN_DATA = append(create_path,'\TRAIN_TRAIN_FOLD_',num2str(Order_K_FOLD),'.mat');
        create_TRAIN_TEST_DATA = append(create_path,'\TRAIN_TEST_FOLD_',num2str(Order_K_FOLD),'.mat');
        save(create_TRAIN_TRAIN_DATA,'TRAIN_TRAIN_DELETE_EMPTY','-v7.3')
        save(create_TRAIN_TEST_DATA,'TRAIN_TEST','-v7.3')
    end
end