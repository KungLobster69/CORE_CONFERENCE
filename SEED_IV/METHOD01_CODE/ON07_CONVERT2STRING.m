clc
clear all
close all

for File_path = 1:3
    path_name = append('E:\THESIS\RESULT\SEED_IV\METHOD01\06.SORT_BY_VDO\',num2str(File_path));
    TRAIN_TRAIN_CLUSTERING_VDO_name = append(path_name,'\TRAIN_TRAIN_CLUSTERING_VDO.mat');
    TRAIN_TRAIN_CLUSTERING_VDO_load = load(TRAIN_TRAIN_CLUSTERING_VDO_name);
    TRAIN_TRAIN_CLUSTERING_VDO = TRAIN_TRAIN_CLUSTERING_VDO_load.TRAIN_TRAIN_CLUSTERING_VDO;
    TRAIN_TRAIN_CONVERT2STR = {};
    for VDO = 1:312
        CLUSTERING_VDO = TRAIN_TRAIN_CLUSTERING_VDO{VDO,1};
        SIZE_CLUSTERING_VDO = size(CLUSTERING_VDO,1);
        CONVERT2STR = '';
        for SAMPLE = 1:SIZE_CLUSTERING_VDO
            data_num = CLUSTERING_VDO(SAMPLE,1);
            if data_num == 1
                string = 'A';
            elseif data_num == 2
                string = 'B';
            elseif data_num == 3
                string = 'C';
            elseif data_num == 4
                string = 'D';
            elseif data_num == 5
                string = 'E';
            elseif data_num == 6
                string = 'F';
            elseif data_num == 7
                string = 'G';
            elseif data_num == 8
                string = 'H';
            elseif data_num == 9
                string = 'I';
            elseif data_num == 10
                string = 'J';
            elseif data_num == 11
                string = 'K';
            elseif data_num == 12
                string = 'L';
            elseif data_num == 13
                string = 'M';
            elseif data_num == 14
                string = 'N';
            elseif data_num == 15
                string = 'O';
            elseif data_num == 16
                string = 'P';
            elseif data_num == 17
                string = 'Q';
            elseif data_num == 18
                string = 'R';
            elseif data_num == 19
                string = 'S';
            elseif data_num == 20
                string = 'T';
            elseif data_num == 21
                string = 'U';
            elseif data_num == 22
                string = 'V';
            elseif data_num == 23
                string = 'W';
            elseif data_num == 24
                string = 'X';
            elseif data_num == 25
                string = 'Y';
            elseif data_num == 26
                string = 'Z';
            elseif data_num == 27
                string = 'a';
            elseif data_num == 28
                string = 'b';
            elseif data_num == 29
                string = 'c';
            elseif data_num == 30
                string = 'd';
            elseif data_num == 31
                string = 'e';
            elseif data_num == 32
                string = 'f';
            elseif data_num == 33
                string = 'g';
            elseif data_num == 34
                string = 'h';
            elseif data_num == 35
                string = 'i';
            elseif data_num == 36
                string = 'j';
            elseif data_num == 37
                string = 'k';
            elseif data_num == 38
                string = 'l';
            elseif data_num == 39
                string = 'm';
            elseif data_num == 40
                string = 'n';
            elseif data_num == 41
                string = 'o';
            elseif data_num == 42
                string = 'p';
            elseif data_num == 43
                string = 'q';
            elseif data_num == 44
                string = 'r';
            elseif data_num == 45
                string = 's';
            elseif data_num == 46
                string = 't';
            elseif data_num == 47
                string = 'u';
            elseif data_num == 48
                string = 'v';
            elseif data_num == 49
                string = 'w';
            elseif data_num == 50
                string = 'x';
            elseif data_num == 51
                string = 'y';
            elseif data_num == 52
                string = 'z';
            elseif data_num == 53
                string = '0';
            elseif data_num == 54
                string = '1';
            elseif data_num == 55
                string = '2';
            elseif data_num == 56
                string = '3';
            elseif data_num == 57
                string = '4';
            elseif data_num == 58
                string = '5';
            elseif data_num == 59
                string = '6';
            elseif data_num == 60
                string = '7';
            elseif data_num == 61
                string = '8';
            elseif data_num == 62
                string = '9';
            end
            CONVERT2STR(SAMPLE) = strcat(string);
        end
        TRAIN_TRAIN_CONVERT2STR{VDO,1} = CONVERT2STR;
    end
    %% SAVE_DATA
    create_path = append('E:\THESIS\RESULT\SEED_IV\METHOD01\07.CONVERT2STR_62\',num2str(File_path));
    create_TRAIN_TRAIN_CONVERT2STR = append(create_path,'\TRAIN_TRAIN_CONVERT2STR.mat');
    mkdir(create_path)
    save(create_TRAIN_TRAIN_CONVERT2STR,'TRAIN_TRAIN_CONVERT2STR','-v7.3')
end