clc
clear all
close all

for File_path = 1:3
    path_name = append('E:\THESIS\RESULT\SEED_IV\METHOD01\05.CLUSTERING_62GROUP\',num2str(File_path));
    TRAIN_TRAIN_BAND_name = append(path_name,'\TRAIN_TRAIN_BAND.mat');
    TRAIN_TRAIN_CLUSTERING_name = append(path_name,'\TRAIN_TRAIN_CLUSTERING.mat');
    TRAIN_TRAIN_BAND_load = load(TRAIN_TRAIN_BAND_name);
    TRAIN_TRAIN_CLUSTERING_load = load(TRAIN_TRAIN_CLUSTERING_name);
    TRAIN_TRAIN_BAND = TRAIN_TRAIN_BAND_load.TRAIN_TRAIN_BAND;
    TRAIN_TRAIN_CLUSTERING = TRAIN_TRAIN_CLUSTERING_load.TRAIN_TRAIN_CLUSTERING;
    SIZE_TRAIN_TRAIN_BAND = size(TRAIN_TRAIN_BAND,1);
    END_BAND = 0 ;
    for BAND = 1:SIZE_TRAIN_TRAIN_BAND
        SIZE_BAND = size(TRAIN_TRAIN_BAND{BAND},1);
        CLUSTERING_BAND = [];
        for SAMPLE = 1:SIZE_BAND
            CLUSTERING_BAND(SAMPLE,1) = TRAIN_TRAIN_CLUSTERING(SAMPLE+END_BAND,1);
        end
        END_BAND = END_BAND+SIZE_BAND;
        TRAIN_TRAIN_CLUSTERING_BAND{BAND,1} = CLUSTERING_BAND;
    end
    NEXT_HUMAN = 0;
    NEXT_VDO = 0;
    for HUMAN = 1:13
        for VDO = 1:24
            CLUSTERING_CH = {};
            CLUSTERING_CH_CELL2MAT = [];
            for CH = 1:248
                CLUSTERING_CH{CH,1} = TRAIN_TRAIN_CLUSTERING_BAND{CH+NEXT_VDO,1};
            end
            CLUSTERING_CH_CELL2MAT = cell2mat(CLUSTERING_CH);
            TRAIN_TRAIN_CLUSTERING_VDO{VDO+NEXT_HUMAN,1} = CLUSTERING_CH_CELL2MAT;
            NEXT_VDO = NEXT_VDO+248;
        end
        NEXT_HUMAN = NEXT_HUMAN+24;
    end
    
    %% SAVE_DATA
    create_path = append('E:\THESIS\RESULT\SEED_IV\METHOD01\06.SORT_BY_VDO_62\',num2str(File_path));
    create_TRAIN_TRAIN_CLUSTERING_VDO = append(create_path,'\TRAIN_TRAIN_CLUSTERING_VDO.mat');
    mkdir(create_path)
    save(create_TRAIN_TRAIN_CLUSTERING_VDO,'TRAIN_TRAIN_CLUSTERING_VDO','-v7.3')
end