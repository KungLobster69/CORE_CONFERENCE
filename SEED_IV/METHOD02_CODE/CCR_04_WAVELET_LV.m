clc
clear
close all

path_name = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD02\03.TRAIN_AND_TEST_DATA');
TRAIN_SET_name = append(path_name,'\TRAIN_SET.mat');
TRAIN_SET_load = load(TRAIN_SET_name);
TRAIN_SET = TRAIN_SET_load.TRAIN_SET;
for ROW_VDO = 1:size(TRAIN_SET,1)
    VDO = TRAIN_SET{ROW_VDO,1};
    NEXT_CH = 0;
    BAND_CH = {};
    for ROW_CH = 1:size(VDO,1)
        CH = VDO(ROW_CH,:);
        LV = 5; % level of wavelet
        [c,l] = wavedec(CH,LV,'db5');
        a5 = appcoef(c,l,'db5');
        [d1,d2,d3,d4,d5] = detcoef(c,l,[1,2,3,4,5]);
        BAND_CH{1+NEXT_CH,1} = d1;
        BAND_CH{2+NEXT_CH,1} = d2;
        BAND_CH{3+NEXT_CH,1} = d3;
        BAND_CH{4+NEXT_CH,1} = d4;
        BAND_CH{5+NEXT_CH,1} = d5;
        BAND_CH{6+NEXT_CH,1} = a5;
        NEXT_CH = NEXT_CH+(LV+1);
    end
    BAND_VDO{ROW_VDO,1} =  BAND_CH;
    BAND_VDO(ROW_VDO,2) =  TRAIN_SET(ROW_VDO,2);
end

% SAVE_DATA %
create_path = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD02\04.WAVELET_LV');
create_wavelet = append(create_path,'\BAND_VDO_WAVELET_LV',num2str(LV),'.mat');
mkdir(create_path)
save(create_wavelet,'BAND_VDO','-v7.3')