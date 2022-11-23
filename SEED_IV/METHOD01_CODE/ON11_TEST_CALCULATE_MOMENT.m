clc
clear all
close all

for File_path = 1:3
    % CALCULATE_MOMENT
    path_name = append('E:\THESIS\RESULT\SEED_IV\METHOD01\10.TEST_Wavelet_LV3_DATA\',num2str(File_path));
    TEST_WAVELET_LV3_name = append(path_name,'\TEST_WAVELET_LV3.mat');
    TEST_WAVELET_LV3_load = load(TEST_WAVELET_LV3_name);
    TEST_WAVELET_LV3 = TEST_WAVELET_LV3_load.TEST_WAVELET_LV3  ;
    TEST_MOMENT_DATA = {};
    for HUMAN = 1:2
        WAVELET_HUMAN = TEST_WAVELET_LV3{HUMAN,1};
        TEST_MOMENT_VDO = {};
        for VDO = 1:24
            WVAELET_VDO = WAVELET_HUMAN{VDO,1};
            TEST_MOMENT_CH = {};
            for CH = 1:62
                WAVELET_CH = WVAELET_VDO{CH,1};
                TEST_MOMENT_BAND = {};
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
                    TEST_MOMENT_BAND{BAND,1} = MOMENT;
                end
                TEST_MOMENT_CH{CH,1} = TEST_MOMENT_BAND;
            end
            TEST_MOMENT_VDO{VDO,1} = TEST_MOMENT_CH;
        end
        TEST_MOMENT_DATA{HUMAN,1} = TEST_MOMENT_VDO;
    end
    %% SAVE_DATA
    create_path = append('E:\THESIS\RESULT\SEED_IV\METHOD01\11.TEST_CALCULATE_MOMENT\',num2str(File_path));
    create_moment = append(create_path,'\TEST_MOMENT_DATA.mat');
    mkdir(create_path)
    save(create_moment,'TEST_MOMENT_DATA','-v7.3')
end