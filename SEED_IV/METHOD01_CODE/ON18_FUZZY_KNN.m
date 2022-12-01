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
        for Number_KNN = 1:2
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
            for ROW = 1:KNN
                for COL = 1:size(ROW_ZERO,2)
                    Sample_ROW_ZERO = ROW_ZERO(ROW,COL);
                    ROW_ZERO_LABEL(ROW,COL) = Class_label_TRAIN{Sample_ROW_ZERO,1};
                end
            end
            % Calcurate u %
            m = 2; % default
            Degree = 2/(m-1);
            for COL = 2%:size(Sample_KNN,2)
                % CHECK NUMBER %
                x = unique(ROW_ZERO_LABEL(:,COL));
                N = numel(x);
                count = zeros(N,1);
                for k = 1:N
                    count(k) = sum(ROW_ZERO_LABEL(:,COL)==x(k));
                end
                
            end
            KNN = KNN+2;
        end
    end
end