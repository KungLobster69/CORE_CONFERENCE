clc
clear all
close all

%% Wavelet transform LV.3
for File_path = 1:3
    path_name = append('E:\THESIS\RESULT\SEED_IV\METHOD01\02.TRAIN_DATA_SORT_VDO_BY_CLASS\',num2str(File_path));
    train_name = append(path_name,'\TRAIN_DATA_SORT_VDO_BY_CLASS.mat');
    train_train_load = load(train_name);
    train_struct2cell = struct2cell(train_train_load);
    train_train_data = train_struct2cell{1};
    TRAIN_TRAIN_WAVELET_LV3 = {};
    for human = 1:13
        VDO_matrix = {};
        for VDO = 1:24
            BAND_martrix = {};
            VDO_DATA = train_train_data{VDO,human};
            for CH = 1:62
                SINGAL_CH = VDO_DATA(CH,:);
                LV = 3; % level of wavelet
                [c,l] = wavedec(SINGAL_CH,LV,'db5');
                a3 = appcoef(c,l,'db5');
                [d1,d2,d3] = detcoef(c,l,[1,2,3]);
                BAND_martrix{CH,1} = {d1;d2;d3;a3};
            end
            VDO_matrix{VDO,1} = BAND_martrix;
        end
        TRAIN_TRAIN_WAVELET_LV3{human,1} =  VDO_matrix;
    end
    %% SAVE_DATA
    create_path = append('E:\THESIS\RESULT\SEED_IV\METHOD01\03.Wavelet_LV3_DATA\',num2str(File_path));
    create_wavelet = append(create_path,'\TRAIN_TRAIN_WAVELET_LV3.mat');
    mkdir(create_path)
    save(create_wavelet,'TRAIN_TRAIN_WAVELET_LV3','-v7.3')
end