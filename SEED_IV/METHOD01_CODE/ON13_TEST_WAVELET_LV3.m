clc
clear all
close all

%% Wavelet transform LV.3
for File_path = 1:3
    path_name = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV\METHOD01\12.TEST_DATA_SORT_VDO_BY_CLASS\',num2str(File_path));
    test_name = append(path_name,'\TEST_DATA_SORT_VDO_BY_CLASS.mat');
    test_load = load(test_name);
    test_struct2cell = struct2cell(test_load);
    test_data = test_struct2cell{1};
    TEST_WAVELET_LV3 = {};
    for human = 1:2
        VDO_matrix = {};
        for VDO = 1:24
            BAND_martrix = {};
            VDO_DATA = test_data{VDO,human};
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
        TEST_WAVELET_LV3{human,1} =  VDO_matrix;
    end
    %% SAVE_DATA
    create_path = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV\METHOD01\13.TEST_Wavelet_LV3_DATA\',num2str(File_path));
    create_wavelet = append(create_path,'\TEST_WAVELET_LV3.mat');
    mkdir(create_path)
    save(create_wavelet,'TEST_WAVELET_LV3','-v7.3')
end