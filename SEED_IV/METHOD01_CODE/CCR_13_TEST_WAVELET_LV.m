clc
clear
close all

for File_path = 1:3
    path_name = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD01\03.TRAIN_AND_TEST_DATA\',num2str(File_path));
    TEST_VDO_name = append(path_name,'\TEST_VDO.mat');
    TEST_VDO_load = load(TEST_VDO_name);
    TEST_VDO = TEST_VDO_load.TEST_VDO;
    for ROW_VDO = 1:size(TEST_VDO,1)
        VDO = TEST_VDO{ROW_VDO,1};
        NEXT_CH = 0;
        for ROW_CH = 1:size(VDO,1)
            CH = VDO(ROW_CH,:);
            LV = 3; % level of wavelet
            [c,l] = wavedec(CH,LV,'db5');
            a3 = appcoef(c,l,'db5');
            [d1,d2,d3] = detcoef(c,l,[1,2,3]);
            BAND_CH{1+NEXT_CH,1} = d1;
            BAND_CH{2+NEXT_CH,1} = d2;
            BAND_CH{3+NEXT_CH,1} = d3;
            BAND_CH{4+NEXT_CH,1} = a3;
            NEXT_CH = NEXT_CH+(LV+1);
        end
        BAND_VDO{ROW_VDO,1} =  BAND_CH;
        BAND_VDO(ROW_VDO,2) =  TEST_VDO(ROW_VDO,2);
    end
    % SAVE_DATA
    create_path = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD01\13.TEST_WAVELET_LV\',num2str(File_path));
    create_wavelet = append(create_path,'\TEST_BAND_VDO_WAVELET_LV',num2str(LV),'.mat');
    mkdir(create_path)
    save(create_wavelet,'BAND_VDO','-v7.3')
end