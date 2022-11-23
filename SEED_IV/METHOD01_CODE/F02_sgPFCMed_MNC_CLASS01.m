function [V, U, T, E] = sgpfcmed(X, c, options, File_path, init_V)
%
%sgPFCMed: String Grammar Possibilistic-Fuzzy C-Medians Clustering.
%
%   [V, U, T, E] = sgPFCMed (X, c, options, inti_V)
%   X: Input String data
%   c: Number of clusters
%   init_V: Initial cluster centers
%   OPTIONS(1): Weighting exponent (m) (default: 2.0)
%   OPTIONS(2): Typicality weight (eta) (default: 4.0)
%   OPTIONS(3): Maximum number of iterations (default: 100)
%   OPTIONS(4): Termination threshold (default: 1e-3)
%   OPTIONS(5): Info display during iteration (default: 1)
%   OPTIONS(6): Use provided init_V (default: 0)
%
%   V: Cluster centers
%   U: Membership degrees
%   T: Typicality (Possibility) values
%   G: Gamma value
%   a,b: custom value
%   E: Termination measure values (max_iter by 1)
%

if nargin < 2
    error('Too few input arguments!');
end

if nargin > 4
    error('Too many input arguments!');
end

n = size(X, 1);


% Change the following to set default options
default_options = [2;	% weighting exponent (m)
    4;      % typicality weight (eta)
    10;	% max. number of iteration
    1e-3;	% termination threshold
    1;      % info display during iteration
    0;     % use provided init_V
    1; %a
    1; %b
    1]; %gamma

if nargin == 2
    options = default_options;
else
    % If "options" is not fully specified, pad it with default values.
    if length(options) < 9
        tmp = default_options;
        tmp(1:length(options)) = options;
        options = tmp;
    end
    % If some entries of "options" are nan's, replace them with defaults.
    nan_index = find(isnan(options)==1);
    options(nan_index) = default_options(nan_index);
end

m = options(1);	        	% Weighting exponent
eta = options(2);	        % Typicality weight (eta)
max_iter = options(3);		% Max. iteration
term_thr = options(4);		% Termination threshold
display = options(5);		% Display info or not
use_init_V = options(6);    % use provided init_V
a = options(7);
b = options(8);
G = options(9);
if m <= 1
    error('The weighting exponent should be greater than 1!');
end

E = zeros(max_iter, 1);	% Array for termination measure values

if use_init_V
    V = init_V;
else
    V = F03_sgPFCMed_InitV (X,c); % Initial cluster centers
end

% Main loop
tic

create_path = append('D:\KUNG_LOBSTER69\RESULT\SEED_IV\METHOD01\09.GRID_SEARCH\GRID_SEARCH_MNC\',num2str(File_path));
create_PARAMETER_FUCNTION = append(create_path,'\PARAMETER_FUCNTION_M_',num2str(options(1)),'_N_',num2str(options(2)),'_C_',num2str(c),'_CLASS01.mat');

E_old = 0;
E_COUNT = 0;
for i = 1:max_iter
    [V, U, T, E(i)] = F04_sgPFCMed_Step(X, V, c, m, eta,a,b,G);
    
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
    
    PARAMETER_FUCNTION = {i,V,U,T,E,X,c,E_old,E_COUNT};
    save(create_PARAMETER_FUCNTION,'PARAMETER_FUCNTION','-v7.3')
end

iter_n = i;	% Actual number of iterations
E(iter_n+1:max_iter) = [];
toc