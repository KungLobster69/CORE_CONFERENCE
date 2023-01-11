clc
clear
close all

for File_path = 3
    path_name = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD01\04.WAVELET_LV\',num2str(File_path));
    BAND_VDO_name = append(path_name,'\BAND_VDO_WAVELET_LV5.mat');
    BAND_VDO_load = load(BAND_VDO_name);
    BAND_VDO = BAND_VDO_load.BAND_VDO;
    Moment_VDO = {};
    for ROW_VDO = 1:size(BAND_VDO,1)
        BAND_CH = BAND_VDO{ROW_VDO,1};
        Moment_CH = {};
        for ROW_CH = 1:size(BAND_CH,1)
            CH = BAND_CH{ROW_CH,1};
            size_CH = size(CH,2);
            size_window = 100; % เปลี่ยนขนาด size_window %
            size_end = round((size_CH/size_window)+0.5);
            END_Interval = 0;
            MOMENT = [];
            for Interval = 1:size_end
                START = 1+END_Interval;
                END = size_window+END_Interval;
                if Interval < size_end
                    calculate_band = CH(START:END);
                    calculate_Mean = mean(calculate_band);
                    calculate_Variance = var(calculate_band);
                    calculate_Skewness = skewness(calculate_band);
                    calculate_Kurtosis = kurtosis(calculate_band);
                    MOMENT(Interval,:) = [calculate_Mean,calculate_Variance,calculate_Skewness,calculate_Kurtosis];
                else
                    calculate_band = CH(START:size_CH);
                    calculate_Mean = mean(calculate_band);
                    calculate_Variance = var(calculate_band);
                    calculate_Skewness = skewness(calculate_band);
                    calculate_Kurtosis = kurtosis(calculate_band);
                    MOMENT(Interval,:) = [calculate_Mean,calculate_Variance,calculate_Skewness,calculate_Kurtosis];
                end
                END_Interval = END_Interval+size_window;
            end
            Moment_CH{ROW_CH,1} = MOMENT;
        end
        Moment_VDO{ROW_VDO,1} = Moment_CH;
        Moment_VDO(ROW_VDO,2) = BAND_VDO(ROW_VDO,2);
    end
    % SAVE_DATA
    create_path = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD01\05.CALCULATE_MOMENT\',num2str(File_path));
    create_CALCULATE_MOMENT = append(create_path,'\Moment_VDO_LV5_100.mat');
    mkdir(create_path)
    save(create_CALCULATE_MOMENT,'Moment_VDO','-v7.3')
end