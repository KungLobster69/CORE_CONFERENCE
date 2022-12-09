clc
clear
close all

for File_path = 1:3
    path_name = append('E:\THESIS\RESULT\SEED_IV_CONFERENCE\METHOD01\05.CALCULATE_MOMENT\',num2str(File_path));
    Moment_VDO_name = append(path_name,'\Moment_VDO_LV3_100.mat');
    Moment_VDO_load = load(Moment_VDO_name);
    Moment_VDO = Moment_VDO_load.Moment_VDO;
    NEXT_VDO = 0;
    All_Moment = [];
    for ROW_VDO = 1:size(Moment_VDO,1)
        Moment_CH = Moment_VDO{ROW_VDO,1};
        NEXT_MOMENT = 0;
        for ROW_CH = 1:size(Moment_CH,1)
            Moment = Moment_CH{ROW_CH,1};
            for ROW_MOMENT = 1:size(Moment,1)
                All_Moment(ROW_MOMENT+NEXT_MOMENT+NEXT_VDO,:) = Moment(ROW_MOMENT,:);
            end
            NEXT_MOMENT = NEXT_MOMENT + size(Moment,1);
        end
        MAX_CHARACTER_VDO(ROW_VDO,1) =  NEXT_MOMENT;
        NEXT_VDO = NEXT_VDO + NEXT_MOMENT;
    end
    
    k = 40; % CLUSTERING GROUP %
    CLUSTERING_CHARACTER = [];
    CENTER_CHARACTER = [];
    [CLUSTERING_CHARACTER,CENTER_CHARACTER] = kmeans(All_Moment,k,'MaxIter',100);
    % COUNT MEMBERSHIP
    x = unique(CLUSTERING_CHARACTER);
    N = numel(x);
    count = zeros(N,1);
    for i = 1:N
        count(i) = sum(CLUSTERING_CHARACTER == x(i));
    end
    disp([ x(:) count ]);
    
    NEXT_VDO = 0;
    CHARACTER_VDO = {};
    for ROW_MAX_CHARACTER_VDO = 1:size(MAX_CHARACTER_VDO,1)
        SAMPLE_CHARACTER_VDO = [];
        for ROW_size_VDO = 1:MAX_CHARACTER_VDO(ROW_MAX_CHARACTER_VDO,1)
            SAMPLE_CHARACTER_VDO(ROW_size_VDO,1) = CLUSTERING_CHARACTER(ROW_size_VDO+NEXT_VDO,1);
        end
        CHARACTER_VDO{ROW_MAX_CHARACTER_VDO,1} = SAMPLE_CHARACTER_VDO;
        NEXT_VDO = NEXT_VDO + MAX_CHARACTER_VDO(ROW_MAX_CHARACTER_VDO,1);
    end
    % SAVE_DATA
    create_path = append('E:\THESIS\RESULT\SEED_IV_CONFERENCE\METHOD01\06.CLUSTERING_CHARACTER\',num2str(File_path));
    create_CHARACTER_VDO = append(create_path,'\CHARACTER_VDO_LV3_100_40',num2str(k),'.mat');
    create_CENTER_CHARACTER = append(create_path,'\CENTER_CHARACTER_LV3_100_40',num2str(k),'.mat');
    mkdir(create_path)
    save(create_CHARACTER_VDO,'CHARACTER_VDO','-v7.3')
    save(create_CENTER_CHARACTER,'CENTER_CHARACTER','-v7.3')
end