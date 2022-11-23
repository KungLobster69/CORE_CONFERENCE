clc
clear all
close all

%% SORT_VDO_BY_CLASS_0,1,2,3
session01_label = [1,2,3,0,2,0,0,1,0,1,2,1,1,1,2,3,2,2,3,3,0,3,0,3];
session02_label = [2,1,3,0,0,2,0,2,3,3,2,3,2,0,1,1,2,1,0,3,0,1,3,1];
session03_label = [1,2,2,1,3,3,3,1,1,2,1,0,2,3,3,0,2,3,0,0,2,0,1,0];
for File_path = 1:3
    path_name = append('E:\THESIS\RESULT\SEED_IV\METHOD01\01.DATA_SET\1.1.TRAIN_DATA\',num2str(File_path));
    for File_human = 1:13
        human_name = append(path_name,'\human',num2str(File_human),'\TRAIN_DATA.mat');
        human_load = load(human_name);
        human_load = human_load.human_load;
        human_load = struct2cell(human_load);
        class00_start = 1;
        class01_start = 7;
        class02_start = 13;
        class03_start = 19;
        for File_VDO_ROW = 1:24
            if File_path == 1
                class = session01_label(File_VDO_ROW);
                if class == 0
                    TRAIN_session01{class00_start,File_human} = human_load{File_VDO_ROW,1};
                    class00_start = class00_start+1;
                end
                if class == 1
                    TRAIN_session01{class01_start,File_human} = human_load{File_VDO_ROW,1};
                    class01_start = class01_start+1;
                end
                if class == 2
                    TRAIN_session01{class02_start,File_human} = human_load{File_VDO_ROW,1};
                    class02_start = class02_start+1;
                end
                if class == 3
                    TRAIN_session01{class03_start,File_human} = human_load{File_VDO_ROW,1};
                    class03_start = class03_start+1;
                end
            end
            if File_path == 2
                class = session02_label(File_VDO_ROW);
                if class == 0
                    TRAIN_session02{class00_start,File_human} = human_load{File_VDO_ROW,1};
                    class00_start = class00_start+1;
                end
                if class == 1
                    TRAIN_session02{class01_start,File_human} = human_load{File_VDO_ROW,1};
                    class01_start = class01_start+1;
                end
                if class == 2
                    TRAIN_session02{class02_start,File_human} = human_load{File_VDO_ROW,1};
                    class02_start = class02_start+1;
                end
                if class == 3
                    TRAIN_session02{class03_start,File_human} = human_load{File_VDO_ROW,1};
                    class03_start = class03_start+1;
                end
            end
            if File_path == 3
                class = session03_label(File_VDO_ROW);
                if class == 0
                    TRAIN_session03{class00_start,File_human} = human_load{File_VDO_ROW,1};
                    class00_start = class00_start+1;
                end
                if class == 1
                    TRAIN_session03{class01_start,File_human} = human_load{File_VDO_ROW,1};
                    class01_start = class01_start+1;
                end
                if class == 2
                    TRAIN_session03{class02_start,File_human} = human_load{File_VDO_ROW,1};
                    class02_start = class02_start+1;
                end
                if class == 3
                    TRAIN_session03{class03_start,File_human} = human_load{File_VDO_ROW,1};
                    class03_start = class03_start+1;
                end
            end
        end
    end
end

%% CHECK DATA
for COL = 1:13
    for ROW = 1:24
        SIZE_VDO_class_session01 = size(TRAIN_session01{ROW,COL},2);
        SIZE_VDO_class_session02 = size(TRAIN_session02{ROW,COL},2);
        SIZE_VDO_class_session03 = size(TRAIN_session03{ROW,COL},2);
        CHECK_VDO_class_session01(ROW,COL) = SIZE_VDO_class_session01;
        CHECK_VDO_class_session02(ROW,COL) = SIZE_VDO_class_session02;
        CHECK_VDO_class_session03(ROW,COL) = SIZE_VDO_class_session03;
    end
end

%% SAVE_DATA
create_path_session01 = 'E:\THESIS\RESULT\SEED_IV\METHOD01\02.TRAIN_DATA_SORT_VDO_BY_CLASS\1';
create_path_session02 = 'E:\THESIS\RESULT\SEED_IV\METHOD01\02.TRAIN_DATA_SORT_VDO_BY_CLASS\2';
create_path_session03 = 'E:\THESIS\RESULT\SEED_IV\METHOD01\02.TRAIN_DATA_SORT_VDO_BY_CLASS\3';
create_train_session01 = append(create_path_session01,'\TRAIN_DATA_SORT_VDO_BY_CLASS.mat');
create_train_session02 = append(create_path_session02,'\TRAIN_DATA_SORT_VDO_BY_CLASS.mat');
create_train_session03 = append(create_path_session03,'\TRAIN_DATA_SORT_VDO_BY_CLASS.mat');
mkdir(create_path_session01)
mkdir(create_path_session02)
mkdir(create_path_session03)
save(create_train_session01,'TRAIN_session01','-v7.3')
save(create_train_session02,'TRAIN_session02','-v7.3')
save(create_train_session03,'TRAIN_session03','-v7.3')