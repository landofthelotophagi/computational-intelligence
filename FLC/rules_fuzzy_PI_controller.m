function rules = rules_fuzzy_PI_controller()
% this functions creates a table of all the rules of the fuzzy controller

% fuzzy rules array
% first row - output values when E is PL
rules_array = [1 7 5 1 1; % dE is NL
               2 7 6 1 1; % dE is NM
               3 7 7 1 1; % dE is NS
               4 7 8 1 1; % dE is ZR
               5 7 9 1 1; % dE is PS
               6 7 9 1 1; % dE is PM
               7 7 9 1 1; % dE is PL
% second row - output values when E is PM
               1 6 4 1 1; % dE is NL
               2 6 5 1 1; % dE is NM
               3 6 6 1 1; % dE is NS
               4 6 7 1 1; % dE is ZR
               5 6 8 1 1; % dE is PS
               6 6 9 1 1; % dE is PM
               7 6 9 1 1; % dE is PL
% third row - output values when E is PS
               1 5 3 1 1; % dE is NL
               2 5 4 1 1; % dE is NM
               3 5 5 1 1; % dE is NS
               4 5 6 1 1; % dE is ZR
               5 5 7 1 1; % dE is PS
               6 5 8 1 1; % dE is PM
               7 5 9 1 1; % dE is PL
% fourth row - output values when E is ZR
               1 4 2 1 1; % dE is NL
               2 4 3 1 1; % dE is NM
               3 4 4 1 1; % dE is NS
               4 4 5 1 1; % dE is ZR
               5 4 6 1 1; % dE is PS
               6 4 7 1 1; % dE is PM
               7 4 8 1 1; % dE is PL
% fifth row - output values when E is NS
               1 3 1 1 1; % dE is NL
               2 3 2 1 1; % dE is NM
               3 3 3 1 1; % dE is NS
               4 3 4 1 1; % dE is ZR
               5 3 5 1 1; % dE is PS
               6 3 6 1 1; % dE is PM
               7 3 7 1 1; % dE is PL
% sixth row - output values when E is NM
               1 2 1 1 1; % dE is NL
               2 2 1 1 1; % dE is NM
               3 2 2 1 1; % dE is NS
               4 2 3 1 1; % dE is ZR
               5 2 4 1 1; % dE is PS
               6 2 5 1 1; % dE is PM
               7 2 6 1 1; % dE is PL
% seventh row - output values when E is NL
               1 1 1 1 1; % dE is NL
               2 1 1 1 1; % dE is NM
               3 1 1 1 1; % dE is NS
               4 1 2 1 1; % dE is ZR
               5 1 3 1 1; % dE is PS
               6 1 4 1 1; % dE is PM
               7 1 5 1 1];% dE is PL
     
rules = rules_array;
end