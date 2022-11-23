clc
clear all
close all

for File_path = 1%:3
    path_TEST_CONVERT2STR_name = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV\METHOD01\17.TEST_CONVERT2STR\',num2str(File_path));
    TEST_CONVERT2STR_name = append(path_TEST_CONVERT2STR_name,'\TEST_CONVERT2STR.mat');
    TEST_CONVERT2STR_load = load(TEST_CONVERT2STR_name);
    TEST_CONVERT2STR = TEST_CONVERT2STR_load.TEST_CONVERT2STR;
    path_PROTOTYPE_name = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV\METHOD01\09.GRID_SEARCH\GRID_SEARCH_MNC\',num2str(File_path));
    CLASS00_name = append(path_PROTOTYPE_name,'\PROTOTYPE_M_1.5_N_1.5_C_5_CLASS00.mat');
    CLASS01_name = append(path_PROTOTYPE_name,'\PROTOTYPE_M_1.5_N_1.5_C_5_CLASS01.mat');
    CLASS02_name = append(path_PROTOTYPE_name,'\PROTOTYPE_M_1.5_N_1.5_C_5_CLASS02.mat');
    CLASS03_name = append(path_PROTOTYPE_name,'\PROTOTYPE_M_1.5_N_1.5_C_5_CLASS03.mat');
    DATA_CLASS00_load = load(CLASS00_name);
    DATA_CLASS01_load = load(CLASS01_name);
    DATA_CLASS02_load = load(CLASS02_name);
    DATA_CLASS03_load = load(CLASS03_name);
    DATA_CLASS00 = DATA_CLASS00_load.GRID_SEARCH_MNC_CLASS00;
    DATA_CLASS01 = DATA_CLASS01_load.GRID_SEARCH_MNC_CLASS01;
    DATA_CLASS02 = DATA_CLASS02_load.GRID_SEARCH_MNC_CLASS02;
    DATA_CLASS03 = DATA_CLASS03_load.GRID_SEARCH_MNC_CLASS03;
    CLASS00 = DATA_CLASS00{1,1};
    CLASS01 = DATA_CLASS01{1,1};
    CLASS02 = DATA_CLASS02{1,1};
    CLASS03 = DATA_CLASS03{1,1};
    CLASS_LABEL = {};
    END_CLASS = 5;
    NEXT_CLASS = 0;
    for ROW_CLASS = 1:4
        if ROW_CLASS == 1
            for ROW_CLASS00 = 1:END_CLASS
                CLASS_LABEL{ROW_CLASS00+NEXT_CLASS,1} =  CLASS00{ROW_CLASS00,1};
            end
        end
        if  ROW_CLASS == 2
            for ROW_CLASS01 = 1:END_CLASS
                CLASS_LABEL{ROW_CLASS01+NEXT_CLASS,1} =  CLASS01{ROW_CLASS01,1};
            end
        end
        if  ROW_CLASS == 3
            for ROW_CLASS02 = 1:END_CLASS
                CLASS_LABEL{ROW_CLASS02+NEXT_CLASS,1} =  CLASS02{ROW_CLASS02,1};
            end
        end
        if  ROW_CLASS == 4
            for ROW_CLASS03 = 1:END_CLASS
                CLASS_LABEL{ROW_CLASS03+NEXT_CLASS,1} =  CLASS03{ROW_CLASS03,1};
            end
        end
        NEXT_CLASS = NEXT_CLASS+END_CLASS;
    end
    for ROW_CLASS_LABEL = 1:size(CLASS_LABEL)
        SAMPLE_CLASS_LABEL = CLASS_LABEL{ROW_CLASS_LABEL,1};
        for ROW_TEST_CONVERT2STR = 1:size(TEST_CONVERT2STR)
            SAMPLE_TEST_CONVERT2STR = TEST_CONVERT2STR{ROW_TEST_CONVERT2STR,1};
            Edit_Distance_Matrix(ROW_CLASS_LABEL,ROW_TEST_CONVERT2STR) = F01_EditDistance(SAMPLE_CLASS_LABEL,SAMPLE_TEST_CONVERT2STR);
        end
    end
    MIN_Edit_Distance_Matrix = min(Edit_Distance_Matrix);
    Seach_ROW_Edit_Distance_Matrix = Edit_Distance_Matrix-MIN_Edit_Distance_Matrix;
    TEST_RESULT = [];
    for ROW_seach_row = 1:size(Seach_ROW_Edit_Distance_Matrix,1)
        for CUL_seach_row = 1:size(Seach_ROW_Edit_Distance_Matrix,2)
            value_seach_row = Seach_ROW_Edit_Distance_Matrix(ROW_seach_row,CUL_seach_row);
            if value_seach_row == 0
                TEST_RESULT(CUL_seach_row,1) = ROW_seach_row;
            end
        end
    end
    %% SAVE_DATA
    create_path = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV\METHOD01\18.TEST_EDIT_DISTANCE\',num2str(File_path));
    create_TEST_RESULT = append(create_path,'\TEST_EDIT_DISTANCE_MNC.mat');
    mkdir(create_path)
    save(create_TEST_RESULT,'TEST_RESULT','-v7.3')
end