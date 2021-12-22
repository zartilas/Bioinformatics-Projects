clear
clc
CDS1=fastaread("lactalbumin_alpha.fasta");
CDS2=fastaread("c_lysozyme.fasta");
seq1=CDS1.Sequence;
seq2=CDS2.Sequence;
if (strlength(seq2)>strlength(seq1))
    temp = seq2;
    seq2 = seq1;
    seq1 = temp;
end

%the scoring matrix for each letter in the form of:
%     A C G T
%   A 
%   C
%   G
%   T

sm = [1 -1 -1 -1;
      -1 1 -1 -1;
      -1 -1 1 -1;
      -1 -1 -1 1];
  
tic;
count = 0;

%%add 1 to dimensions because we have the first empty block
m = strlength(seq1)+1; 
n = strlength(seq2)+1+(m-1-strlength(seq2));

max_time = ((n-1) * (m-1));

%%initialize our matrix with zeros
F = zeros(m,n);

blocks = [];

for i = 2:m
   for j = 2:n
       try
        F(i,j) = sm(nt2int(seq1(i-1)),nt2int(seq2(j-1)));
        catch
           F(i,j) = -1;
       end
   end
end

scores = [];
Seq1 = [];
Seq2 = [];
a = 2;
b =1;
for i = m:-1:2
    score = 0;
    l = i; 
    sequence1 = [];
    sequence2 = [];
    for j = 2:a
        score = score + F(l,j);
        try
            sequence1 = [sequence1 seq1(l-1)];
            sequence2 = [sequence2 seq2(j-1)];
        catch
            sequence2 = [sequence2 '-'];
        end
        l = l+1;
    end
    a = a+1;
    scores = [scores score];
    Seq1 =[Seq1 string(sequence1)];
    Seq2 =[Seq2 string(sequence2)];
end
toc
disp(newline)
%%end of matrix initialization
maximum = max(scores);
indexes = find(scores ==maximum);
final1 = [];
final2 = [];
for q = 1:length(indexes)
    final1 = [final1 Seq1(indexes(q))];
    final2 = [final2 Seq2(indexes(q))];
end
final = [final1 ; final2];

disp("The best sequences with the highest score of global-alignment are: ");
disp(final);
disp("With maximum score of: "+maximum);