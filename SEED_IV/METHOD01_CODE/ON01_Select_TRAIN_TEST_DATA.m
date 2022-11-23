clc
clear all
close all

%% SELECT_TRAIN_TEST_DATA
for File_path = 1:3
    create_file_path_train = append('E:\THESIS\RESULT\SEED_IV\METHOD01\01.DATA_SET\1.1.TRAIN_DATA\',num2str(File_path));
    create_file_path_test = append('E:\THESIS\RESULT\SEED_IV\METHOD01\01.DATA_SET\1.2.TEST_DATA\',num2str(File_path));
    path_name = append('E:\THESIS\DATA_SET\SEED\SEED_IV\eeg_raw_data\',num2str(File_path));
    open_fullfile = dir(fullfile(path_name,'*.mat'));
    file_name = {open_fullfile.name};
    for File_human = 1:15
        path_human = append(path_name,'\',file_name{File_human});
        if File_human <= 13
            create_file_human_train = append(create_file_path_train,'\human',num2str(File_human));
            create_file_save_train = append(create_file_human_train,'\TRAIN_DATA.mat');
            mkdir(create_file_human_train)
            human_load = load(path_human);
            save(create_file_save_train,'human_load')
        elseif File_human > 13
            create_file_human_test = append(create_file_path_test,'\human',num2str(File_human));
            create_file_save_test = append(create_file_human_test,'\TEST_DATA.mat');
            mkdir(create_file_human_test)
            human_load = load(path_human);
            save(create_file_save_test,'human_load')
        end
    end
end
