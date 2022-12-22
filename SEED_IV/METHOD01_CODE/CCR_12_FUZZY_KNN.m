clc
clear all
close all

for File_path = 2
    path_DISTANCE_FOLD_name = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD01\10.DISTANCE_FOLD\',num2str(File_path));
    path_TRAIN_name = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD01\09.CROSS_VALIDATION\',num2str(File_path));
    K_FOLD = 4;
    for Order_K_FOLD = 1:K_FOLD
        DISTANCE_FOLD_name = append(path_DISTANCE_FOLD_name,'\DISTANCE_FOLD_LV3_200_60_',num2str(Order_K_FOLD),'.mat');
        DISTANCE_FOLD_load = load(DISTANCE_FOLD_name);
        DISTANCE_FOLD = DISTANCE_FOLD_load.Edit_Distance_FOLD;
        
        TRAIN_TRAIN_name = append(path_TRAIN_name,'\TRAIN_TRAIN_LV3_200_60_',num2str(Order_K_FOLD),'.mat');
        TRAIN_TRAIN_load = load(TRAIN_TRAIN_name);
        TRAIN_TRAIN = TRAIN_TRAIN_load.TRAIN_TRAIN;
        CLASS_LABEL_TRAIN = TRAIN_TRAIN(:,2);
        
        TRAIN_TEST_name = append(path_TRAIN_name,'\TRAIN_TEST_LV3_200_60_',num2str(Order_K_FOLD),'.mat');
        TRAIN_TEST_load = load(TRAIN_TEST_name);
        TRAIN_TEST = TRAIN_TEST_load.TRAIN_TEST;
        CLASS_LABEL_TEST = TRAIN_TEST(:,2);
        
        % Select Sample KNN %
        DISTANCE_FOLD_SORT = sort(DISTANCE_FOLD);
        KNN = 1;
        for Number_KNN = 1:20
            Sample_KNN = [];
            for ROW = 1:KNN
                Sample_KNN(ROW,:) = DISTANCE_FOLD_SORT(ROW,:);
            end
            
            % deletion %
            DISTANCE_FOLD_DELETION = [];
            for COL = 1:size(DISTANCE_FOLD,2)
                for ROW_01 = 1:size(DISTANCE_FOLD,1)
                    for ROW_02 = 1:size(Sample_KNN,1)
                        if DISTANCE_FOLD(ROW_01,COL) - Sample_KNN(ROW_02,COL) <= 0
                            DISTANCE_FOLD_DELETION(ROW_01,COL) = 0;
                        else
                            DISTANCE_FOLD_DELETION(ROW_01,COL) = DISTANCE_FOLD(ROW_01,COL);
                        end
                    end
                end
            end
            
            % search ZERO %
            ROW_ZERO = [];
            for COL = 1:size(DISTANCE_FOLD_DELETION,2)
                ROW_NEW = 1;
                for ROW = 1:size(DISTANCE_FOLD_DELETION,1)
                    if DISTANCE_FOLD_DELETION(ROW,COL) == 0
                        ROW_ZERO(ROW_NEW,COL) = ROW;
                        ROW_NEW = ROW_NEW+1;
                    end
                end
            end
            
            % Compare Class Label %
            ROW_ZERO_LABEL = [];
            for ROW = 1:KNN
                for COL = 1:size(ROW_ZERO,2)
                    Sample_ROW_ZERO = ROW_ZERO(ROW,COL);
                    ROW_ZERO_LABEL(ROW,COL) = CLASS_LABEL_TRAIN{Sample_ROW_ZERO,1};
                end
            end
            
            % Calcurate u %
            ROW_U = [];
            m = 2; % default
            Degree = 2/(m-1);
            for COL = 1:size(Sample_KNN,2)
                U_all = 0;
                U_all_sample = 0;
                for ROW = 1:size(Sample_KNN,1)
                    U_all_sample = 1/(Sample_KNN(ROW,COL)^Degree);
                    U_all = U_all + U_all_sample;
                end
                U_0 = 0;
                U_1 = 0;
                U_2 = 0;
                U_3 = 0;
                U_0_sample = 0;
                U_1_sample = 0;
                U_2_sample = 0;
                U_3_sample = 0;
                for ROW = 1:size(ROW_ZERO_LABEL,1)
                    if ROW_ZERO_LABEL(ROW,COL) == 0
                        U_0_sample = (1/(Sample_KNN(ROW,COL)^Degree))/U_all;
                        U_0 = U_0 + U_0_sample;
                    elseif ROW_ZERO_LABEL(ROW,COL) == 1
                        U_1_sample = (1/(Sample_KNN(ROW,COL)^Degree))/U_all;
                        U_1 = U_1 + U_1_sample;
                    elseif ROW_ZERO_LABEL(ROW,COL) == 2
                        U_2_sample = (1/(Sample_KNN(ROW,COL)^Degree))/U_all;
                        U_2 = U_2 + U_2_sample;
                    elseif ROW_ZERO_LABEL(ROW,COL) == 3
                        U_3_sample = (1/(Sample_KNN(ROW,COL)^Degree))/U_all;
                        U_3 = U_3 + U_3_sample;
                    end
                end
                Check_sum_U = U_0+U_1+U_2+U_3
                if U_0 > U_1 && U_0 > U_2 && U_0 > U_3
                    ROW_U(COL,1) = 0;
                elseif U_1 > U_0 && U_1 > U_2 && U_1 > U_3
                    ROW_U(COL,1) = 1;
                elseif U_2 > U_0 && U_2 > U_1 && U_2 > U_3
                    ROW_U(COL,1) = 2;
                elseif U_3 > U_0 && U_3 > U_1 && U_3 > U_2
                    ROW_U(COL,1) = 3;
                end
            end
            
            % Check Acc %
            ACC = 0;
            for ROW = 1:size(CLASS_LABEL_TEST,1)
                if CLASS_LABEL_TEST{ROW,1} == ROW_U(ROW,1)
                    ACC = ACC+1;
                end
            end
            PERCENT_ACC = (ACC/size(CLASS_LABEL_TEST,1))*100;
            PERCENT_ACC_FOLD(Number_KNN,Order_K_FOLD) = PERCENT_ACC;
            
            KNN = KNN+2;
        end
    end
    PERCENT_ACC_FOLD(:,5) = max(PERCENT_ACC_FOLD,[],2);
    PERCENT_ACC_FILE{File_path,1} = PERCENT_ACC_FOLD;
end