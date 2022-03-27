function rules = rules_fuzzy_PI_controller()
% this functions creates a table of all the rules of the fuzzy controller

% fuzzy rules array
% first row - output values when theta is N
% and dh is S
rules_array = [1 1 1 1 1 1; % dv is S
               1 2 1 1 1 1; % dv is M
               1 3 1 1 1 1; % dv is L
% and dh is M
               2 1 1 3 1 1; % dv is S
               2 2 1 3 1 1; % dv is M
               2 3 1 3 1 1; % dv is L
% and dh is L
               3 1 1 3 1 1; % dv is S
               3 2 1 3 1 1; % dv is M
               3 3 1 3 1 1; % dv is L
% first row - output values when theta is ZR
% and dh is S
               1 1 2 3 1 1; % dv is S
               1 2 2 3 1 1; % dv is M
               1 3 2 3 1 1; % dv is L
% and dh is M
               2 1 2 2 1 1; % dv is S
               2 2 2 2 1 1; % dv is M
               2 3 2 1 1 1; % dv is L
% and dh is L
               3 1 2 2 1 1; % dv is S
               3 2 2 1 1 1; % dv is M
               3 3 2 1 1 1; % dv is L
% first row - output values when theta is P
% and dh is S
               1 1 3 2 1 1; % dv is S
               1 2 3 2 1 1; % dv is M
               1 3 3 2 1 1; % dv is L
% and dh is M
               2 1 3 1 1 1; % dv is S
               2 2 2 1 1 1; % dv is M
               2 3 3 1 1 1; % dv is L
% and dh is L
               3 1 3 1 1 1; % dv is S
               3 2 3 1 1 1; % dv is M
               3 3 3 1 1 1];% dv is L
         
rules = rules_array;
end