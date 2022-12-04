clc
clear all
close all

for File_path = 3%:3
    path_name = append('E:\THESIS\RESULT\SEED_IV\METHOD01\04.CALCULATE_MOMENT\',num2str(File_path));
    TRAIN_TRAIN_MOMENT_name = append(path_name,'\TRAIN_TRAIN_MOMENT_DATA.mat');
    TRAIN_TRAIN_MOMENT_load = load(TRAIN_TRAIN_MOMENT_name);
    TRAIN_TRAIN_MOMENT = TRAIN_TRAIN_MOMENT_load.TRAIN_TRAIN_MOMENT_DATA;
    NEXT_HUMAN = 0;
    for HUMAN = 1:13
        MOMENT_HUMAN = TRAIN_TRAIN_MOMENT{HUMAN,1};
        NEXT_VDO = 0;
        for VDO = 1:24
            MOMENT_VDO = MOMENT_HUMAN{VDO,1};
            NEXT_CH = 0;
            for CH = 1:62
                MOMENT_CH = MOMENT_VDO{CH,1};
                for BAND = 1:4
                    MOMENT_BAND = MOMENT_CH{BAND,1};
                    TRAIN_TRAIN_BAND{BAND+NEXT_CH+NEXT_VDO+NEXT_HUMAN,1} = MOMENT_BAND;
                end
                NEXT_CH = NEXT_CH+4;
            end
            NEXT_VDO = NEXT_VDO+248;
        end
        NEXT_HUMAN = NEXT_HUMAN+5952;
    end
    
    TRAIN_TRAIN_BAND_CELL2MAT = cell2mat(TRAIN_TRAIN_BAND);
    k = 62;
    [TRAIN_TRAIN_CLUSTERING,TRAIN_TRAIN_CENTER] = kmeans(TRAIN_TRAIN_BAND_CELL2MAT,k,'MaxIter',100);
    
    %% COUNT MEMBERSHIP
    x = unique(TRAIN_TRAIN_CLUSTERING);
    N = numel(x);
    count = zeros(N,1);
    for i = 1:N
        count(i) = sum(TRAIN_TRAIN_CLUSTERING == x(i));
    end
    disp([ x(:) count ]);
    
%     %% SAVE_DATA
%     create_path = append('E:\THESIS\RESULT\SEED_IV\METHOD01\05.CLUSTERING_62GROUP\',num2str(File_path));
%     create_TRAIN_TRAIN_BAND = append(create_path,'\TRAIN_TRAIN_BAND.mat');
%     create_TRAIN_TRAIN_CLUSTERING = append(create_path,'\TRAIN_TRAIN_CLUSTERING.mat');
%     create_TRAIN_TRAIN_CENTER = append(create_path,'\TRAIN_TRAIN_CENTER.mat');
%     mkdir(create_path)
%     save(create_TRAIN_TRAIN_BAND,'TRAIN_TRAIN_BAND','-v7.3')
%     save(create_TRAIN_TRAIN_CLUSTERING,'TRAIN_TRAIN_CLUSTERING','-v7.3')
%     save(create_TRAIN_TRAIN_CENTER,'TRAIN_TRAIN_CENTER','-v7.3')
end