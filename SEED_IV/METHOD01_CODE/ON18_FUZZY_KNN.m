clc
clear all
close all

for File_path = 1:3
    path_name = append('E:\THESIS\RESULT\SEED_IV\METHOD01\16.Edit_Distance_DATA\',num2str(File_path));
    Edit_Distance_DATA_name = append(path_name,'\Edit_Distance_DATA.mat');
    Edit_Distance_DATA_load = load(Edit_Distance_DATA_name);
    Edit_Distance_DATA = Edit_Distance_DATA_load.Edit_Distance_DATA;
    for Order_K_FOLD = 1:4
        Edit_Distance_FOLD = Edit_Distance_DATA{Order_K_FOLD,1};
        Class_label_TRAIN = Edit_Distance_DATA{Order_K_FOLD,2};
        Class_label_TEST = Edit_Distance_DATA{Order_K_FOLD,3};
        % DELETE EMPTY Edit_Distance_FOLD %
        Edit_Distance_Delete_empty = [];
        for COL = 1:size(Edit_Distance_FOLD,2)
            ROW_NEW = 1;
            for ROW = 1:size(Edit_Distance_FOLD,1)
                if Edit_Distance_FOLD(ROW,COL) ~= 0
                    Edit_Distance_Delete_empty(ROW_NEW,COL) = Edit_Distance_FOLD(ROW,COL);
                    ROW_NEW = ROW_NEW +1;
                end
            end
        end
        % DELETE EMPTY Class_label_TRAIN %
        Class_label_TRAIN_Delete_empty = {};
        ROW_NEW = 1;
        for ROW = 1:size(Class_label_TRAIN,1)
            if isempty(Class_label_TRAIN{ROW,1}) == 0
                Class_label_TRAIN_Delete_empty(ROW_NEW,1) = Class_label_TRAIN(ROW,1);
                ROW_NEW = ROW_NEW +1;
            end
        end
        % Select Sample KNN %
        Edit_Distance_Sort = sort(Edit_Distance_Delete_empty);
        KNN = 1;
        for Number_KNN = 1
            Sample_KNN = [];
            for ROW = 1:KNN
                Sample_KNN(ROW,:) = Edit_Distance_Sort(ROW,:);
            end
            % deletion %
            Edit_Distance_Deletion = [];
            for COL = 1:size(Edit_Distance_Delete_empty,2)
                for ROW_01 = 1:size(Edit_Distance_Delete_empty,1)
                    for ROW_02 = 1:size(Sample_KNN,1)
                        if Edit_Distance_Delete_empty(ROW_01,COL) - Sample_KNN(ROW_02,COL) <= 0
                            Edit_Distance_Deletion(ROW_01,COL) = 0;
                        else
                            Edit_Distance_Deletion(ROW_01,COL) = Edit_Distance_Delete_empty(ROW_01,COL);
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
            
        end
    end
end