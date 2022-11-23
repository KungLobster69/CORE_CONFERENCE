clc
clear all
close all

for File_path = 1%:3
    path_name = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV\METHOD01\18.TEST_EDIT_DISTANCE\',num2str(File_path));
    TEST_EDIT_DISTANCE_name = append(path_name,'\TEST_EDIT_DISTANCE_MNC.mat');
    TEST_EDIT_DISTANCE_load = load(TEST_EDIT_DISTANCE_name);
    TEST_EDIT_DISTANCE = TEST_EDIT_DISTANCE_load.TEST_RESULT;
    center_train = 5;
    for i = 1:60
        if i <= center_train
            Class_Label(i,1) = 0;
        end
        if i > center_train && i <= center_train*2
            Class_Label(i,1) = 1;
        end
        if i > center_train*2 && i <= center_train*3
            Class_Label(i,1) = 2;
        end
        if i > center_train*3 && i <= center_train*4
            Class_Label(i,1) = 3;
        end
    end
    for ROW_TEST_EDIT_DISTANCE = 1:size(TEST_EDIT_DISTANCE,1)
        for ROW_Class_Label = 1:size(Class_Label,1)
            Sample_TEST_EDIT_DISTANCE = TEST_EDIT_DISTANCE(ROW_TEST_EDIT_DISTANCE,1);
            if Sample_TEST_EDIT_DISTANCE == ROW_Class_Label
                TEST_EDIT_DISTANCE_LABEL(ROW_TEST_EDIT_DISTANCE,1) = Class_Label(ROW_Class_Label,1);
            end
        end
    end
    
    NEXT_i = 0;
    for i = 1:2
        for j = 1:24
            if j <= 6
                Test_Label(j+NEXT_i,1) = 0;
            end
            if j > 6 && j <= 12
                Test_Label(j+NEXT_i,1) = 1;
            end
            if j > 12 && j <= 18
                Test_Label(j+NEXT_i,1) = 2;
            end
            if j > 18 && j <= 24
                Test_Label(j+NEXT_i,1) = 3;
            end
        end
        NEXT_i = NEXT_i+24;
    end
    ACC = 0;
    for i = 1:size(TEST_EDIT_DISTANCE_LABEL,1)
        Sample_TEST_EDIT_DISTANCE_LABEL = TEST_EDIT_DISTANCE_LABEL(i,1);
        Sample_Test_Label = Test_Label(i,1);
        if Sample_TEST_EDIT_DISTANCE_LABEL == Sample_Test_Label
            ACC = ACC+1;
        end
    end
    P_ACC = (ACC/size(TEST_EDIT_DISTANCE_LABEL,1))*100
end