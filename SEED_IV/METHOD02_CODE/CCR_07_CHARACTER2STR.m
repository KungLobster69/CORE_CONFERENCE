clc
clear all
close all

k = [50,60,70,80];
for COL_K = 1:size(k,2)
    path_name = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD02\06.CLUSTERING_CHARACTER');
    CLUSTERING_CHARACTER_name = append(path_name,'\CHARACTER_VDO_LV5_200_',num2str(k(COL_K)),'.mat');
    CLUSTERING_CHARACTER_load = load(CLUSTERING_CHARACTER_name);
    CLUSTERING_CHARACTER = CLUSTERING_CHARACTER_load.CHARACTER_VDO;
    CONVERT2STR = {};
    for ROW_VDO = 1:size(CLUSTERING_CHARACTER,1)
        CLUSTERING_CHARACTER_VDO = CLUSTERING_CHARACTER{ROW_VDO,1};
        STR_VDO = '';
        for SAMPLR_CLUSTERING_CHARACTER_VDO = 1:size(CLUSTERING_CHARACTER_VDO,1)
            DATA_NUM = CLUSTERING_CHARACTER_VDO(SAMPLR_CLUSTERING_CHARACTER_VDO,1);
            if DATA_NUM == 1
                string = 'A';
            elseif DATA_NUM == 2
                string = 'B';
            elseif DATA_NUM == 3
                string = 'C';
            elseif DATA_NUM == 4
                string = 'D';
            elseif DATA_NUM == 5
                string = 'E';
            elseif DATA_NUM == 6
                string = 'F';
            elseif DATA_NUM == 7
                string = 'G';
            elseif DATA_NUM == 8
                string = 'H';
            elseif DATA_NUM == 9
                string = 'I';
            elseif DATA_NUM == 10
                string = 'J';
            elseif DATA_NUM == 11
                string = 'K';
            elseif DATA_NUM == 12
                string = 'L';
            elseif DATA_NUM == 13
                string = 'M';
            elseif DATA_NUM == 14
                string = 'N';
            elseif DATA_NUM == 15
                string = 'O';
            elseif DATA_NUM == 16
                string = 'P';
            elseif DATA_NUM == 17
                string = 'Q';
            elseif DATA_NUM == 18
                string = 'R';
            elseif DATA_NUM == 19
                string = 'S';
            elseif DATA_NUM == 20
                string = 'T';
            elseif DATA_NUM == 21
                string = 'U';
            elseif DATA_NUM == 22
                string = 'V';
            elseif DATA_NUM == 23
                string = 'W';
            elseif DATA_NUM == 24
                string = 'X';
            elseif DATA_NUM == 25
                string = 'Y';
            elseif DATA_NUM == 26
                string = 'Z';
            elseif DATA_NUM == 27
                string = 'a';
            elseif DATA_NUM == 28
                string = 'b';
            elseif DATA_NUM == 29
                string = 'c';
            elseif DATA_NUM == 30
                string = 'd';
            elseif DATA_NUM == 31
                string = 'e';
            elseif DATA_NUM == 32
                string = 'f';
            elseif DATA_NUM == 33
                string = 'g';
            elseif DATA_NUM == 34
                string = 'h';
            elseif DATA_NUM == 35
                string = 'i';
            elseif DATA_NUM == 36
                string = 'j';
            elseif DATA_NUM == 37
                string = 'k';
            elseif DATA_NUM == 38
                string = 'l';
            elseif DATA_NUM == 39
                string = 'm';
            elseif DATA_NUM == 40
                string = 'n';
            elseif DATA_NUM == 41
                string = 'o';
            elseif DATA_NUM == 42
                string = 'p';
            elseif DATA_NUM == 43
                string = 'q';
            elseif DATA_NUM == 44
                string = 'r';
            elseif DATA_NUM == 45
                string = 's';
            elseif DATA_NUM == 46
                string = 't';
            elseif DATA_NUM == 47
                string = 'u';
            elseif DATA_NUM == 48
                string = 'v';
            elseif DATA_NUM == 49
                string = 'w';
            elseif DATA_NUM == 50
                string = 'x';
            elseif DATA_NUM == 51
                string = 'y';
            elseif DATA_NUM == 52
                string = 'z';
            elseif DATA_NUM == 53
                string = '??';
            elseif DATA_NUM == 54
                string = '??';
            elseif DATA_NUM == 55
                string = '??';
            elseif DATA_NUM == 56
                string = '??';
            elseif DATA_NUM == 57
                string = '??';
            elseif DATA_NUM == 58
                string = '??';
            elseif DATA_NUM == 59
                string = '??';
            elseif DATA_NUM == 60
                string = '??';
            elseif DATA_NUM == 61
                string = '??';
            elseif DATA_NUM == 62
                string = '??';
            elseif DATA_NUM == 63
                string = '??';
            elseif DATA_NUM == 64
                string = '??';
            elseif DATA_NUM == 65
                string = '??';
            elseif DATA_NUM == 66
                string = '??';
            elseif DATA_NUM == 67
                string = '??';
            elseif DATA_NUM == 68
                string = '??';
            elseif DATA_NUM == 69
                string = '??';
            elseif DATA_NUM == 70
                string = '??';
            elseif DATA_NUM == 71
                string = '??';
            elseif DATA_NUM == 72
                string = '??';
            elseif DATA_NUM == 73
                string = '??';
            elseif DATA_NUM == 74
                string = '??';
            elseif DATA_NUM == 75
                string = '??';
            elseif DATA_NUM == 76
                string = '??';
            elseif DATA_NUM == 77
                string = '??';
            elseif DATA_NUM == 78
                string = '??';
            elseif DATA_NUM == 79
                string = '??';
            elseif DATA_NUM == 80
                string = '??';
            end
            STR_VDO(SAMPLR_CLUSTERING_CHARACTER_VDO) = strcat(string);
        end
        CONVERT2STR{ROW_VDO,1} = STR_VDO;
        CONVERT2STR{ROW_VDO,2} = CLUSTERING_CHARACTER{ROW_VDO,2};
    end
    % SAVE_DATA %
    create_path = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD02\07.CONVERT2STR');
    create_TRAIN_STR = append(create_path,'\TRAIN_STR_LV5_200_',num2str(k(COL_K)),'.mat');
    mkdir(create_path)
    save(create_TRAIN_STR,'CONVERT2STR','-v7.3')
end