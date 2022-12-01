clc
clear all
close all

for File_path = 1%:3
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
        for Number_KNN = 1:10
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
            % Check Class Label %
            for COL = 1:size(ROW_ZERO_LABEL,2)
                COUNT_CLASS00 = 0;
                COUNT_CLASS01 = 0;
                COUNT_CLASS02 = 0;
                COUNT_CLASS03 = 0;
                for ROW = 1:size(ROW_ZERO_LABEL,1)
                    Sample_ROW_ZERO_LABEL = ROW_ZERO_LABEL(ROW,COL);
                    if Sample_ROW_ZERO_LABEL == 0
                        COUNT_CLASS00 = COUNT_CLASS00+1;
                    elseif Sample_ROW_ZERO_LABEL == 1
                        COUNT_CLASS01 = COUNT_CLASS01+1;
                    elseif Sample_ROW_ZERO_LABEL == 2
                        COUNT_CLASS02 = COUNT_CLASS02+1;
                    elseif Sample_ROW_ZERO_LABEL == 3
                        COUNT_CLASS03 = COUNT_CLASS03+1;
                    end
                end
                if COUNT_CLASS00 > COUNT_CLASS01 && COUNT_CLASS00 > COUNT_CLASS02 && COUNT_CLASS00 > COUNT_CLASS03
                    Label_TRAIN_TEST(COL,1) = 0;
                elseif COUNT_CLASS01 > COUNT_CLASS00 && COUNT_CLASS01 > COUNT_CLASS02 && COUNT_CLASS01 > COUNT_CLASS03
                    Label_TRAIN_TEST(COL,1) = 1;
                elseif COUNT_CLASS02 > COUNT_CLASS00 && COUNT_CLASS02 > COUNT_CLASS01 && COUNT_CLASS02 > COUNT_CLASS03
                    Label_TRAIN_TEST(COL,1) = 2;
                elseif COUNT_CLASS03 > COUNT_CLASS00 && COUNT_CLASS03 > COUNT_CLASS02 && COUNT_CLASS03 > COUNT_CLASS01
                    Label_TRAIN_TEST(COL,1) = 3;
                end
            end
            % Check Acc %
            ACC = 0;
            for ROW = 1:size(Class_label_TEST,1)
                if Class_label_TEST{ROW,1} == Label_TRAIN_TEST(ROW,1)
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