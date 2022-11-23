clc
clear all
close all

for File_path = 1%:3
    path_name = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV\METHOD01\09.GRID_SEARCH\GRID_SEARCH_MN\',num2str(File_path));
    PARAMETER_MAIN_name = append(path_name,'\PARAMETER_MAIN_M_1.5_N_2_CLASS01.mat');
    PARAMETER_FUNCTION_name = append(path_name,'\PARAMETER_FUCNTION_M_1.5_N_2_CLASS01.mat');
    PARAMETER_MAIN_load = load(PARAMETER_MAIN_name);
    PARAMETER_FUNCTION_load = load(PARAMETER_FUNCTION_name);
    PARAMETER_MAIN = PARAMETER_MAIN_load.PARAMETER_MAIN;
    PARAMETER_FUCNTION = PARAMETER_FUNCTION_load.PARAMETER_FUCNTION;
    ROW_m = PARAMETER_MAIN{1,1};
    ROW_n = PARAMETER_MAIN{1,2};
    ROW_c01 = PARAMETER_MAIN{1,3};
    PARAMETER_i = PARAMETER_FUCNTION{1,1};
    V = PARAMETER_FUCNTION{1,2};
    U = PARAMETER_FUCNTION{1,3};
    T = PARAMETER_FUCNTION{1,4};
    E = PARAMETER_FUCNTION{1,5};
    X = PARAMETER_FUCNTION{1,6};
    E_old = PARAMETER_FUCNTION{1,8};
    E_COUNT = PARAMETER_FUCNTION{1,9};
    
    fprintf('Iteration count = %d, Termination measure value = %f\n', PARAMETER_i, E(PARAMETER_i));
    
    create_path = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV\METHOD01\09.GRID_SEARCH\GRID_SEARCH_MN\',num2str(File_path));
    
    PARAMETER_m = [1.5;2;2.5];
    PARAMETER_n = [1.5;2;2.5;3;3.5;4];
    PARAMETER_c = [15];
    
    for RESUM_ROW_m = ROW_m:size(PARAMETER_m,1)
        for RESUM_ROW_n = ROW_n:size(PARAMETER_n,1)
            for RESUM_ROW_c01 = ROW_c01:size(PARAMETER_c,1)
                c01 = PARAMETER_c(RESUM_ROW_c01);
                options = [PARAMETER_m(RESUM_ROW_m);PARAMETER_n(RESUM_ROW_n);100;1;1;0;1;1;1]; %[m;eta;iterration;term_thr;display;use_init_V;a;b;G]
                
                create_PARAMETER_MAIN = append(path_name,'\PARAMETER_MAIN_M_',num2str(PARAMETER_m(RESUM_ROW_m)),'_N_',num2str(PARAMETER_n(RESUM_ROW_n)),'_CLASS01.mat');
                PARAMETER_MAIN = {RESUM_ROW_m,RESUM_ROW_n,RESUM_ROW_c01};
                save(create_PARAMETER_MAIN,'PARAMETER_MAIN','-v7.3')
                
                GRID_SEARCH_MN_CLASS01 = {};
                
                m = options(1);	        	% Weighting exponent
                eta = options(2);	        % Typicality weight (eta)
                max_iter = options(3);		% Max. iteration
                term_thr = options(4);		% Termination threshold
                display = options(5);		% Display info or not
                use_init_V = options(6);    % use provided init_V
                a = options(7);
                b = options(8);
                G = options(9);
                
                if PARAMETER_i == 0
                    if use_init_V
                        V = init_V;
                    else
                        V = F03_sgPFCMed_InitV (X,c01); % Initial cluster centers
                    end
                end
                
                % Main loop
                tic
                
                create_PARAMETER_FUCNTION = append(path_name,'\PARAMETER_FUCNTION_M_',num2str(options(1)),'_N_',num2str(options(2)),'_CLASS01.mat');
                
                E_old = 0;
                E_COUNT = 0;
                
                for i = PARAMETER_i+1:max_iter
                    [V, U, T, E(i)] = F04_sgPFCMed_Step(X, V, c01, m, eta,a,b,G);
                    
                    if display
                        fprintf('Iteration count = %d, Termination measure value = %f\n', i, E(i));
                    end
                    
                    % check termination condition
                    if E(i) <= term_thr, break; end
                    
                    E_CURRENT = E(i);
                    if E_CURRENT == E_old
                        E_COUNT = E_COUNT+1;
                    end
                    E_old = E_CURRENT;
                    
                    if E_COUNT > 10 ,break; end  %% กำหนดรอบที่ซ้ำให้หลุด LOOP
                    
                    PARAMETER_FUCNTION = {i,V,U,T,E,X,c01,E_old,E_COUNT};
                    save(create_PARAMETER_FUCNTION,'PARAMETER_FUCNTION','-v7.3')
                end
                iter_n = i;	% Actual number of iterations
                E(iter_n+1:max_iter) = [];
                toc
                
                GRID_SEARCH_MN_CLASS01{1,1} = V;
                GRID_SEARCH_MN_CLASS01{2,1} = U;
                GRID_SEARCH_MN_CLASS01{3,1} = T;
                GRID_SEARCH_MN_CLASS01{4,1} = E;
                
                create_GRID_SEARCH_MN_CLASS01 = append(create_path,'\PROTOTYPE_M_',num2str(PARAMETER_m(RESUM_ROW_m)),'_N_',num2str(PARAMETER_n(RESUM_ROW_n)),'_CLASS01.mat');
                save(create_GRID_SEARCH_MN_CLASS01,'GRID_SEARCH_MN_CLASS01','-v7.3')
                
                % Reset Value
                PARAMETER_i = 0;
                V = {};
                U = [];
                T = [];
                E = [];
            end
        end
    end
end