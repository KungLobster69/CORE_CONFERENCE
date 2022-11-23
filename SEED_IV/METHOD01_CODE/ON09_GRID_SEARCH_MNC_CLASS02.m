clc
clear all
close all

for File_path = 1%:3
    path_name = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV\METHOD01\07.CONVERT2STR\',num2str(File_path));
    TRAIN_TRAIN_CONVERT2STR_name = append(path_name,'\TRAIN_TRAIN_CONVERT2STR.mat');
    TRAIN_TRAIN_CONVERT2STR_load = load(TRAIN_TRAIN_CONVERT2STR_name);
    TRAIN_TRAIN_CONVERT2STR = TRAIN_TRAIN_CONVERT2STR_load.TRAIN_TRAIN_CONVERT2STR;
    NEXT_HUMAN = 0;
    %% Create Class Label
    for HUMAN = 1:13
        for VDO = 1:24
            if VDO <= 6
                CLASS_LABEL_ALL{VDO+NEXT_HUMAN,1} = 0;
            elseif VDO > 6 && VDO <= 12
                CLASS_LABEL_ALL{VDO+NEXT_HUMAN,1} = 1;
            elseif VDO > 12 && VDO <= 18
                CLASS_LABEL_ALL{VDO+NEXT_HUMAN,1} = 2;
            elseif VDO > 18 && VDO <= 24
                CLASS_LABEL_ALL{VDO+NEXT_HUMAN,1} = 3;
            end
        end
        NEXT_HUMAN = NEXT_HUMAN+24;
    end
    for ROW_TRAIN_TRAIN_CONVERT2STR = 1:size(TRAIN_TRAIN_CONVERT2STR,1)
        TRAIN_TRAIN_CONVERT2STR{ROW_TRAIN_TRAIN_CONVERT2STR,2} = CLASS_LABEL_ALL{ROW_TRAIN_TRAIN_CONVERT2STR,1};
    end
    %% SUM VDO BY CLASS
    TRAIN_CLASS00 = {};
    TRAIN_CLASS01 = {};
    TRAIN_CLASS02 = {};
    TRAIN_CLASS03 = {};
    ROW_TRAIN_CLASS00 = 1;
    ROW_TRAIN_CLASS01 = 1;
    ROW_TRAIN_CLASS02 = 1;
    ROW_TRAIN_CLASS03 = 1;
    for ROW_TRAIN_TRAIN_CONVERT2STR = 1:size(TRAIN_TRAIN_CONVERT2STR,1)
        CHECK_CLASS = TRAIN_TRAIN_CONVERT2STR{ROW_TRAIN_TRAIN_CONVERT2STR,2};
        if CHECK_CLASS == 0
            TRAIN_CLASS00{ROW_TRAIN_CLASS00,1} =  TRAIN_TRAIN_CONVERT2STR{ROW_TRAIN_TRAIN_CONVERT2STR,1};
            ROW_TRAIN_CLASS00 = ROW_TRAIN_CLASS00+1;
        elseif CHECK_CLASS == 1
            TRAIN_CLASS01{ROW_TRAIN_CLASS01,1} =  TRAIN_TRAIN_CONVERT2STR{ROW_TRAIN_TRAIN_CONVERT2STR,1};
            ROW_TRAIN_CLASS01 = ROW_TRAIN_CLASS01+1;
        elseif CHECK_CLASS == 2
            TRAIN_CLASS02{ROW_TRAIN_CLASS02,1} =  TRAIN_TRAIN_CONVERT2STR{ROW_TRAIN_TRAIN_CONVERT2STR,1};
            ROW_TRAIN_CLASS02 = ROW_TRAIN_CLASS02+1;
        elseif CHECK_CLASS == 3
            TRAIN_CLASS03{ROW_TRAIN_CLASS03,1} =  TRAIN_TRAIN_CONVERT2STR{ROW_TRAIN_TRAIN_CONVERT2STR,1};
            ROW_TRAIN_CLASS03 = ROW_TRAIN_CLASS03+1;
        end
    end
    
    create_path = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV\METHOD01\09.GRID_SEARCH\GRID_SEARCH_MNC\',num2str(File_path));
    
    PARAMETER_m = [1.5;2;2.5];
    PARAMETER_n = [1.5;2;2.5;3;3.5;4];
    PARAMETER_c = [5;10;15];
    
    for ROW_m = 1:size(PARAMETER_m,1)
        for ROW_n = 1:size(PARAMETER_n,1)
            for ROW_c02 = 1:size(PARAMETER_c,1)
                
                c02 = PARAMETER_c(ROW_c02);
                options = [PARAMETER_m(ROW_m);PARAMETER_n(ROW_n);100;1]; %[m;n;iterration;erorr]
                
                create_PARAMETER_MAIN = append(create_path,'\PARAMETER_MAIN_M_',num2str(PARAMETER_m(ROW_m)),'_N_',num2str(PARAMETER_n(ROW_n)),'_C_',num2str(PARAMETER_c(ROW_c02)),'_CLASS02.mat');
                PARAMETER_MAIN = {ROW_m,ROW_n,ROW_c02};
                save(create_PARAMETER_MAIN,'PARAMETER_MAIN','-v7.3')
                
                GRID_SEARCH_MNC_CLASS02 = {};
                
                [V02, U02, T02, E02] = F02_sgPFCMed_MNC_CLASS02(TRAIN_CLASS02,c02,options,File_path);
                
                GRID_SEARCH_MNC_CLASS02{1,1} = V02;
                GRID_SEARCH_MNC_CLASS02{2,1} = U02;
                GRID_SEARCH_MNC_CLASS02{3,1} = T02;
                GRID_SEARCH_MNC_CLASS02{4,1} = E02;
                
                create_GRID_SEARCH_MNC_CLASS02 = append(create_path,'\PROTOTYPE_M_',num2str(PARAMETER_m(ROW_m)),'_N_',num2str(PARAMETER_n(ROW_n)),'_C_',num2str(PARAMETER_c(ROW_c02)),'_CLASS02.mat');
                save(create_GRID_SEARCH_MNC_CLASS02,'GRID_SEARCH_MNC_CLASS02','-v7.3')
                
            end
        end
    end
end