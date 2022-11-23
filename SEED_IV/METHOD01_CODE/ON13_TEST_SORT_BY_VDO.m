clc
clear all
close all

for File_path = 1:3
    path_name = append('E:\THESIS\RESULT\SEED_IV\METHOD01\12.TEST_CLUSTERING_52GROUP\',num2str(File_path));
    TEST_CLUSTERING_name = append(path_name,'\TEST_CLUSTERING.mat');
    TEST_CLUSTERING_load = load(TEST_CLUSTERING_name);
    TEST_CLUSTERING = TEST_CLUSTERING_load.TEST_CLUSTERING;
    NEXT_HUMAN = 0;
    NEXT_VDO = 0;
    for HUMAN = 1:2
        for VDO = 1:24
            CLUSTERING_CH = {};
            CLUSTERING_CH_CELL2MAT = [];
            for CH = 1:248
                CLUSTERING_CH{CH,1} = TEST_CLUSTERING{CH+NEXT_VDO,1};
            end
            CLUSTERING_CH_CELL2MAT = cell2mat(CLUSTERING_CH);
            TEST_CLUSTERING_VDO{VDO+NEXT_HUMAN,1} = CLUSTERING_CH_CELL2MAT;
            NEXT_VDO = NEXT_VDO+248;
        end
        NEXT_HUMAN = NEXT_HUMAN+24;
    end
        %% SAVE_DATA
        create_path = append('E:\THESIS\RESULT\SEED_IV\METHOD01\13.TEST_SORT_BY_VDO\',num2str(File_path));
        create_TEST_CLUSTERING_VDO = append(create_path,'\TEST_CLUSTERING_VDO.mat');
        mkdir(create_path)
        save(create_TEST_CLUSTERING_VDO,'TEST_CLUSTERING_VDO','-v7.3')
end