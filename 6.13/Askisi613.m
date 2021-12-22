clear
clc
sequence1=fastaread("liver.fasta");
sequence2=fastaread("muscle.fasta");
Seq1=sequence1.Sequence;
Seq2=sequence2.Sequence;
m=strlength(Seq1);
n=strlength(Seq2);
prompt = "Select which player will play first, select '1' for Player1 or '2' for Player2 (1/2): ";
choice = input(prompt);
while (choice ~= 1 ) && (choice ~= 2)
    choice = input(prompt);
end
disp("Initial sequences : " +newline+"1st: "+ Seq1 +newline+ "2nd: "+Seq2+newline);
while (m~=0) && (n~=0)
    if choice == 1
        disp("Player 1 made a move");
        [Seq1,Seq2] = Player(Seq1,Seq2,m,n);
        disp("New sequences: "+newline+"1st: " + Seq1 +newline+ "2nd: " + Seq2+newline);
        choice = 2;
    else
        disp("Player 2 made a move");
        [Seq1,Seq2] = Player(Seq1,Seq2,m,n);
        disp("New sequences: "+newline+"1st: "+ Seq1 +newline+"2nd: "+ Seq2+newline);
        choice = 1;
    end
    m = strlength(Seq1);
    n = strlength(Seq2);
end

if choice == 1
    disp("Player 2 made the last move and won");
elseif choice ==2 
    disp("Player 1 made the last move and won");
end
function [new_Seq1,new_Seq2] = Player(Seq1,Seq2,L1,L2)
    if L1 == L2 
        for i = 1:L1
            Seq1 = Seq1(2:end);
            Seq2 = Seq2(2:end);
        end
    elseif L2 == 0
        for i = 1 :L2
            Seq2 = Seq2(2:end);
        end
    elseif L1 == 0
        for i = 1 :L1
            Seq1 = Seq1(2:end);
        end
    else
        move = randi([1 3],1);
        if move == 1
            num = randi([1 min(L1,L2)],1);
            for i = 1:num
                Seq1 = Seq1(2:end);
                Seq2 = Seq2(2:end);
            end
        elseif move == 2
            num = randi([1 L1],1);
            for i = 1:num
                Seq1 = Seq1(2:end);
            end
        else 
            if(loser(L1-1,L2)) 
                Seq1 = Seq1(2:end);
            elseif(loser(L1,L2-1))
                Seq2 = Seq2(2:end);
            else  
                Seq1 = Seq1(2:end);
                Seq2 = Seq2(2:end);
            end
        end
    end
new_Seq1 = Seq1;
new_Seq2 = Seq2;
end

function loser = loser(L1,L2) 
    if L1 == L2
        loser = 0;
    elseif L1 ==0 && L2>0
        loser = 0;
    elseif L2 == 0 && L1 >0
        loser = 0;
    else
        loser = 1;
    end
end