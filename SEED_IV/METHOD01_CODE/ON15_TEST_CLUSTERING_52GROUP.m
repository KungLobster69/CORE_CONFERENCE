clc
clear all
close all

for File_path = 1:3
    path_TRAIN_TRAIN_CENTER_name = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV\METHOD01\05.CLUSTERING_52GROUP\',num2str(File_path),'\TRAIN_TRAIN_CENTER.mat');
    path_TEST_MOMENT_DATA_name = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV\METHOD01\14.TEST_CALCULATE_MOMENT\',num2str(File_path),'\TEST_MOMENT_DATA.mat');
    TRAIN_TRAIN_CENTER_load = load(path_TRAIN_TRAIN_CENTER_name);
    TEST_MOMENT_DATA_load = load(path_TEST_MOMENT_DATA_name);
    TRAIN_TRAIN_CENTER = TRAIN_TRAIN_CENTER_load.TRAIN_TRAIN_CENTER;
    TEST_MOMENT_DATA = TEST_MOMENT_DATA_load.TEST_MOMENT_DATA;
    NEXT_HUMAN = 0;
    for HUMAN = 1:2
        MOMENT_HUMAN = TEST_MOMENT_DATA{HUMAN,1};
        NEXT_VDO = 0;
        for VDO = 1:24
            MOMENT_VDO = MOMENT_HUMAN{VDO,1};
            NEXT_CH = 0;
            for CH = 1:62
                MOMENT_CH = MOMENT_VDO{CH,1};
                for BAND = 1:4
                    MOMENT_BAND = MOMENT_CH{BAND,1};
                    TEST_BAND{BAND+NEXT_CH+NEXT_VDO+NEXT_HUMAN,1} = MOMENT_BAND;
                end
                NEXT_CH = NEXT_CH+4;
            end
            NEXT_VDO = NEXT_VDO+248;
        end
        NEXT_HUMAN = NEXT_HUMAN+5952;
    end
    %% Euclidean distance
    for ROW_TEST_BAND = 1:size(TEST_BAND,1)
        select_TEST_BAND = TEST_BAND{ROW_TEST_BAND,1};
        distance = [];
        for ROW_select_TEST_BAND = 1:size(select_TEST_BAND,1)
            value_select_TEST_BAND = select_TEST_BAND(ROW_select_TEST_BAND,:);
            for ROW_TRAIN_TRAIN_CENTER = 1:size(TRAIN_TRAIN_CENTER,1)
                value_TRAIN_TRAIN_CENTER = TRAIN_TRAIN_CENTER(ROW_TRAIN_TRAIN_CENTER,:);
                distance(ROW_TRAIN_TRAIN_CENTER,ROW_select_TEST_BAND) = sqrt(sum(((value_TRAIN_TRAIN_CENTER-value_select_TEST_BAND).^2)));
            end
        end
        min_distanace = min(distance,[],1);
        seach_row = distance - min_distanace;
        TEST_ROW = [];
        for ROW_seach_row = 1:size(seach_row,1)
            for CUL_seach_row = 1:size(seach_row,2)
                value_seach_row = seach_row(ROW_seach_row,CUL_seach_row);
                if value_seach_row == 0 
                    TEST_ROW(CUL_seach_row,1) = ROW_seach_row;
                end
            end
        end
        TEST_CLUSTERING{ROW_TEST_BAND,1} = TEST_ROW;
    end
    %% SAVE_DATA
    create_path = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV\METHOD01\15.TEST_CLUSTERING_52GROUP\',num2str(File_path));
    create_TEST_CLUSTERING = append(create_path,'\TEST_CLUSTERING.mat');
    mkdir(create_path)
    save(create_TEST_CLUSTERING,'TEST_CLUSTERING','-v7.3')
end