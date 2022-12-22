clc
clear
close all

NEXT_File = 0;
for File_path = 1:3
    path_name = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD02\02.CLASS_LABEL\',num2str(File_path));
    DATA_VDO_name = append(path_name,'\DATA_VDO.mat');
    DATA_VDO_load = load(DATA_VDO_name);
    DATA_VDO = DATA_VDO_load.DATA_VDO;
    if File_path == 1 || File_path == 2
        for ROW_VDO = 1:size(DATA_VDO,1)
            TRAIN_SET{ROW_VDO+NEXT_File,1} = DATA_VDO{ROW_VDO,1};
            TRAIN_SET{ROW_VDO+NEXT_File,2} = DATA_VDO{ROW_VDO,2};
        end
        NEXT_File = NEXT_File + size(DATA_VDO,1);
    end
    if File_path == 3
        for ROW_VDO = 1:size(DATA_VDO,1)
            TEST_SET{ROW_VDO,1} = DATA_VDO{ROW_VDO,1};
            TEST_SET{ROW_VDO,2} = DATA_VDO{ROW_VDO,2};
        end
    end
end
% SAVE_DATA %
create_path = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD02\03.TRAIN_AND_TEST_DATA');
create_TRAIN_VDO = append(create_path,'\TRAIN_SET.mat');
create_TEST_VDO = append(create_path,'\TEST_SET.mat');
mkdir(create_path)
save(create_TRAIN_VDO,'TRAIN_SET','-v7.3')
save(create_TEST_VDO,'TEST_SET','-v7.3')
