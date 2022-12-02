clc
clear all
close all

for File_path = 1:2
    path_name = append('E:\THESIS\RESULT\SEED_IV\METHOD01\16.Edit_Distance_DATA\',num2str(File_path));
    Edit_Distance_DATA_name = append(path_name,'\Edit_Distance_DATA.mat');
    Edit_Distance_DATA_load = load(Edit_Distance_DATA_name);
    Edit_Distance_DATA = Edit_Distance_DATA_load.Edit_Distance_DATA;
    for Order_K_FOLD = 1:4
        Edit_Distance_FOLD = Edit_Distance_DATA{Order_K_FOLD,1};
        Class_label_TRAIN = Edit_Distance_DATA{Order_K_FOLD,2};
        Class_label_TEST = Edit_Distance_DATA{Order_K_FOLD,3};
        % Select Sample KNN %
        Edit_Distance_Sort = sort(Edit_Distance_FOLD);
        KNN = 1;
        for Number_KNN = 1:20
            Sample_KNN = [];
            for ROW = 1:KNN
                Sample_KNN(ROW,:) = Edit_Distance_Sort(ROW,:);
            end
            % deletion %
            Edit_Distance_Deletion = [];
            for COL = 1:size(Edit_Distance_FOLD,2)
                for ROW_01 = 1:size(Edit_Distance_FOLD,1)
                    for ROW_02 = 1:size(Sample_KNN,1)
                        if Edit_Distance_FOLD(ROW_01,COL) - Sample_KNN(ROW_02,COL) <= 0
                            Edit_Distance_Deletion(ROW_01,COL) = 0;
                        else
                            Edit_Distance_Deletion(ROW_01,COL) = Edit_Distance_FOLD(ROW_01,COL);
                        end
                    end
                end
            end
            % search ZERO %
            ROW_ZERO = [];
            for COL = 1:size(Edit_Distance_Deletion,2)
                ROW_NEW = 1;
                for ROW = 1:size(Edit_Distance_Deletion,1)
                    if Edit_Distance_Deletion(ROW,COL) == 0
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
                    ROW_ZERO_LABEL(ROW,COL) = Class_label_TRAIN{Sample_ROW_ZERO,1};
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
            for ROW = 1:size(Class_label_TEST,1)
                if Class_label_TEST{ROW,1} == ROW_U(ROW,1)
                    ACC = ACC+1;
                end
            end
            PERCENT_ACC = (ACC/size(Class_label_TEST,1))*100;
            PERCENT_ACC_FOLD(Number_KNN,Order_K_FOLD) = PERCENT_ACC;
            KNN = KNN+2;
        end
    end
    PERCENT_ACC_FOLD(:,5) = max(PERCENT_ACC_FOLD,[],2);
    PERCENT_ACC_FILE{File_path,1} = PERCENT_ACC_FOLD;
end