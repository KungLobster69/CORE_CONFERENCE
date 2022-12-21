clc
clear all
close all

for File_path = 1:3
    path_name_Moment = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD01\14.TEST_CALCULATE_MOMENT\',num2str(File_path));
    Moment_VDO_name = append(path_name_Moment,'\TEST_Moment_VDO_LV3_200.mat');
    Moment_VDO_load = load(Moment_VDO_name);
    Moment_VDO = Moment_VDO_load.Moment_VDO;
    path_name_Center = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD01\06.CLUSTERING_CHARACTER\',num2str(File_path));
    Center_name = append(path_name_Center,'\CENTER_CHARACTER_LV3_200_50.mat');
    Center_load = load(Center_name);
    Center = Center_load.CENTER_CHARACTER;
    
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
    
    % Euclidean distance %
    
    CLUSTERING_CHARACTER = [];
    Sample_All_Moment = [];
    for ROW_All_Moment = 1:size(All_Moment,1)
        Sample_Center = [];
        Euclidean_Distance = [];
        for ROW_Center = 1:size(Center,1)
            Sample_All_Moment = All_Moment(ROW_All_Moment,:);
            Sample_Center = Center(ROW_Center,:);
            Euclidean_Distance(ROW_Center,1) =  sqrt(sum((Sample_Center - Sample_All_Moment) .^ 2));
        end
        Min_Euclidean_Distance = min(Euclidean_Distance);
        for ROW_Euclidean_Distance = 1:size(Euclidean_Distance,1)
            if Min_Euclidean_Distance == Euclidean_Distance(ROW_Euclidean_Distance,1)
                CLUSTERING_CHARACTER(ROW_All_Moment,1) = ROW_Euclidean_Distance;
            end
        end
    end
    
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
        CHARACTER_VDO{ROW_MAX_CHARACTER_VDO,2} = Moment_VDO{ROW_MAX_CHARACTER_VDO,2};
        NEXT_VDO = NEXT_VDO + MAX_CHARACTER_VDO(ROW_MAX_CHARACTER_VDO,1);
    end
    
    % SAVE_DATA
    create_path = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV_CONFERENCE\METHOD01\15.TEST_CLUSTERING_CHARACTER\',num2str(File_path));
    create_CHARACTER_VDO = append(create_path,'\TEST_CHARACTER_VDO_LV3_200_50.mat');
    mkdir(create_path)
    save(create_CHARACTER_VDO,'CHARACTER_VDO','-v7.3')
end
