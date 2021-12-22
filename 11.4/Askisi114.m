clear 
clc

TRANS = [0.9 0.1; 0.1 0.9]; % Transition Matrix
EMIS = [0.4 0.1 0.4 0.1; 0.2 0.3 0.2 0.3;]'; % Emissions Matrix
STATES = ['a', 'b'] ; % Katastaseis

GOAL = nt2int('GGCT'); %
INITIAL_PROB = [0.5; 0.5]; % Arxikes pithanotites
SEQ = [GOAL]; % Dianisma akolouthias

[SCORE, BEST_PATH] = viterbi(INITIAL_PROB, TRANS, EMIS, GOAL);
disp("Score: " + SCORE)
PATH = '';
for i = 1 : size(GOAL, 2),
    PATH = [PATH  STATES(BEST_PATH(i))];
end
disp("Path: " + PATH)
