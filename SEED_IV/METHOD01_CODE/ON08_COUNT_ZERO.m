clc
clear all
close all

for File_path = 1:3
    path_name = append('E:\THESIS\RESULT\SEED_IV\METHOD01\08.CHECK_REPEATER\',num2str(File_path));
    CHECK_REPEATER_FILE_name = append(path_name,'\CHECK_REPEATER_FILE.mat');
    CHECK_REPEATER_FILE_load = load(CHECK_REPEATER_FILE_name);
    CHECK_REPEATER = CHECK_REPEATER_FILE_load.CHECK_REPEATER_FILE{1, 1};
    COUNT = 0
    for CUL_CHECK_REPEATER = 1:size(CHECK_REPEATER,2)
        for ROW_CHECK_REPEATER = 1:size(CHECK_REPEATER,1)
            SAMPLE_CHECK_REPEATER = CHECK_REPEATER(ROW_CHECK_REPEATER,CUL_CHECK_REPEATER);
            if SAMPLE_CHECK_REPEATER == 0
                COUNT = COUNT+1
            end
        end
    end
    COUNT_FILE(File_path,1) = COUNT;
end