clc
clear all
close all

for File_path = 1:3
    k = [50,60,70,80];
    for COL_K = 1:size(k,2)
        path_name = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD01\07.CONVERT2STR\',num2str(File_path));
        TRAIN_STR_name = append(path_name,'\TRAIN_STR_LV3_100_',num2str(k(COL_K)),'.mat');
        TRAIN_STR_load = load(TRAIN_STR_name);
        TRAIN_STR = TRAIN_STR_load.CONVERT2STR;
        DISTANCE_DUPLICATES = [];
        for COL = 1:size(TRAIN_STR,1)
            SAMPLE_COL = TRAIN_STR{COL,1};
            for ROW = 1:size(TRAIN_STR,1)
                SAMPLE_ROW = TRAIN_STR{ROW,1};
                DISTANCE_DUPLICATES(ROW,COL) = F01_EditDistance(SAMPLE_ROW,SAMPLE_COL);
            end
        end
        % SAVE_DATA %
        create_path = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD01\08.DISTANCE_DUPLICATES\',num2str(File_path));
        create_DISTANCE = append(create_path,'\DISTANCE_DUPLICATES_LV3_100_',num2str(k(COL_K)),'.mat');
        mkdir(create_path)
        save(create_DISTANCE,'DISTANCE_DUPLICATES','-v7.3')
    end
end