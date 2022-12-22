clc
clear all
close all

%% SELECT_TRAIN_TEST_DATA
for File_path = 1:3
    path_name = append('D:\KUNG_LOBSTER69\DATA_SET\SEED\SEED_IV\eeg_raw_data\',num2str(File_path));
    open_fullfile = dir(fullfile(path_name,'*.mat'));
    file_name = {open_fullfile.name};
    NEXT_HUMAN = 0;
    for Human = 1:15
        Human_load = load(append(path_name,'\',file_name{Human}));
        Human_struct2cell = struct2cell(Human_load);
        for VDO = 1:size(Human_struct2cell,1);
            DATA_VDO(VDO + NEXT_HUMAN,1) =  Human_struct2cell(VDO,1);
        end
        NEXT_HUMAN = NEXT_HUMAN + size(Human_struct2cell,1);
    end
    % SAVE_DATA
    create_path = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD02\01.DATA_VDO\',num2str(File_path));
    create_DATA_VDO = append(create_path,'\DATA_VDO.mat');
    mkdir(create_path)
    save(create_DATA_VDO,'DATA_VDO','-v7.3')
end