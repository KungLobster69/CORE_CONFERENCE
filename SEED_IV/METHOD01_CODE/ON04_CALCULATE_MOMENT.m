clc
clear all
close all

for File_path = 1:3
    % CALCULATE_MOMENT
    path_name = append('E:\THESIS\RESULT\SEED_IV\METHOD01\03.Wavelet_LV3_DATA\',num2str(File_path));
    TRAIN_TRAIN_WAVELET_LV3_name = append(path_name,'\TRAIN_TRAIN_WAVELET_LV3.mat');
    TRAIN_TRAIN_WAVELET_LV3_load = load(TRAIN_TRAIN_WAVELET_LV3_name);
    TRAIN_TRAIN_WAVELET_LV3 = TRAIN_TRAIN_WAVELET_LV3_load.TRAIN_TRAIN_WAVELET_LV3;
    TRAIN_TRAIN_MOMENT_DATA = {};
    for HUMAN = 1:13
        WAVELET_HUMAN = TRAIN_TRAIN_WAVELET_LV3{HUMAN,1};
        TRAIN_TRAIN_MOMENT_VDO = {};
        for VDO = 1:24
            WVAELET_VDO = WAVELET_HUMAN{VDO,1};
            TRAIN_TRAIN_MOMENT_CH = {};
            for CH = 1:62
                WAVELET_CH = WVAELET_VDO{CH,1};
                TRAIN_TRAIN_MOMENT_BAND = {};
                for BAND = 1:4
                    WAVELET_BAND = WAVELET_CH{BAND,1};
                    len_fix = 500;
                    SIZE_WAVELET_BAND = size(WAVELET_BAND,2);
                    END_SIZE = round((SIZE_WAVELET_BAND/len_fix)+0.5);
                    END_Interval = 0;
                    MOMENT = [];
                    for Interval = 1:END_SIZE
                        START = 1+END_Interval;
                        END = len_fix+END_Interval;
                        if Interval < END_SIZE
                            calculate_band = WAVELET_BAND(START:END);
                            calculate_Mean = mean(calculate_band);
                            calculate_Variance = var(calculate_band);
                            calculate_Skewness = skewness(calculate_band);
                            calculate_Kurtosis = kurtosis(calculate_band);
                            MOMENT(Interval,:) = [calculate_Mean,calculate_Variance,calculate_Skewness,calculate_Kurtosis];
                        else
                            calculate_band = WAVELET_BAND(START:SIZE_WAVELET_BAND);
                            calculate_Mean = mean(calculate_band);
                            calculate_Variance = var(calculate_band);
                            calculate_Skewness = skewness(calculate_band);
                            calculate_Kurtosis = kurtosis(calculate_band);
                            MOMENT(Interval,:) = [calculate_Mean,calculate_Variance,calculate_Skewness,calculate_Kurtosis];
                        end
                        END_Interval = END_Interval+len_fix;
                    end
                    TRAIN_TRAIN_MOMENT_BAND{BAND,1} = MOMENT;
                end
                TRAIN_TRAIN_MOMENT_CH{CH,1} = TRAIN_TRAIN_MOMENT_BAND;
            end
            TRAIN_TRAIN_MOMENT_VDO{VDO,1} = TRAIN_TRAIN_MOMENT_CH;
        end
        TRAIN_TRAIN_MOMENT_DATA{HUMAN,1} = TRAIN_TRAIN_MOMENT_VDO;
    end
    %% SAVE_DATA
    create_path = append('E:\THESIS\RESULT\SEED_IV\METHOD01\04.CALCULATE_MOMENT\',num2str(File_path));
    create_wavelet = append(create_path,'\TRAIN_TRAIN_MOMENT_DATA.mat');
    mkdir(create_path)
    save(create_wavelet,'TRAIN_TRAIN_MOMENT_DATA','-v7.3')
end