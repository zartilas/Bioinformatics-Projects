function [MAXIMUM, BEST_PATH, SECOND_PATH] = viterbi(INITIAL_PROB, TRANS, EMIS, GOAL)

    N = size(TRANS, 1);
    M = size(EMIS, 1);
    T = length(GOAL); % Megethos akolouthias
    C = zeros(N, T); % Pinakas pithanotitwn viterbi
    pred = size(N, T); % Provlepsi
    L = size(TRANS, 2);
    INITIAL_PROB = log2(INITIAL_PROB);
    TRANS = log2(TRANS); % Arxikopoisi pithanotitwn se logarithmo me vasi 2
    EMIS = log2(EMIS);
    
    for i = 1 : N
        C(i, 1) = INITIAL_PROB(i);
        
    end
    vp = zeros(T, N, 2);
    endscore = zeros(1, N);
    for t = 1 : T
        
        for i = 1 : N
            v = zeros(1, N);
            for p = 1 : N
                v(p) = C(p, t) + TRANS(p, i) + EMIS(GOAL(t), p);
                vp(t, p, i) = v(p);
               
            end
           
            [C(i,t+1),index] = max(v);
           
            pred(i,t) = index;
           
        end
        
    end
    
   

    %viterbi score
    [maxscore, index] = max((C(:, T + 1)));
    MAXIMUM = maxscore;
    pred(N, T) = index;
    t = T;
    BEST_PATH = [index];
    C
    while t~=0,
        [score, index] = max(vp(t, :, index));
        BEST_PATH = [index BEST_PATH];
        t = t - 1;
        if t == 0,
            break
        end
    end
score = MAXIMUM;