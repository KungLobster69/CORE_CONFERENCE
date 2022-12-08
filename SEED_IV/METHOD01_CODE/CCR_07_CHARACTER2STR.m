clc
clear all
close all

for File_path = 1:3
    path_name = append('E:\THESIS\RESULT\SEED_IV_CONFERENCE\METHOD01\06.CLUSTERING_CHARACTER\',num2str(File_path));
    CLUSTERING_CHARACTER_name = append(path_name,'\CLUSTERING_CHARACTER_500_52.mat');
    MAX_CHARACTER_VDO_name = append(path_name,'\MAX_CHARACTER_VDO_500_52.mat');
    CLUSTERING_CHARACTER_load = load(CLUSTERING_CHARACTER_name);
    MAX_CHARACTER_VDO_load = load(MAX_CHARACTER_VDO_name);
    CLUSTERING_CHARACTER = CLUSTERING_CHARACTER_load.CLUSTERING_CHARACTER;
    MAX_CHARACTER_VDO = MAX_CHARACTER_VDO_load.MAX_CHARACTER_VDO;
    for ROW_MAX_CHARACTER_VDO = 1:size(MAX_CHARACTER_VDO,1)
        
    end
end

    % SAVE_DATA
    create_path = append('E:\THESIS\RESULT\SEED_IV_CONFERENCE\METHOD01\06.CLUSTERING_CHARACTER\',num2str(File_path));
    create_CLUSTERING_CHARACTER = append(create_path,'\CLUSTERING_CHARACTER_500_',num2str(k),'.mat');
    create_CENTER_CHARACTER = append(create_path,'\CENTER_CHARACTER_500_',num2str(k),'.mat');
    create_MAX_CHARACTER_VDO = append(create_path,'\MAX_CHARACTER_VDO_500_',num2str(k),'.mat');
    mkdir(create_path)
    save(create_CLUSTERING_CHARACTER,'CLUSTERING_CHARACTER','-v7.3')
    save(create_CENTER_CHARACTER,'CENTER_CHARACTER','-v7.3')
    save(create_MAX_CHARACTER_VDO,'MAX_CHARACTER_VDO','-v7.3')