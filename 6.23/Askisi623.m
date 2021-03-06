clear
clc
CDS1=fastaread("c_lysozyme.fasta");
CDS2=fastaread("lactalbumin_alpha.fasta");
seq1=CDS1.Sequence;
seq2=CDS2.Sequence;

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
%add 1 to dimensions because we have the first empty block
m = strlength(seq1)+1; 
n = strlength(seq2)+1;

max_time = ((n-1) * (m-1));
%initialize our matrix with zeros
F = zeros(m,n);

blocks = [];
for j = 0:n-1
    F(1,j+1) = -j;
end
for j = 0:m-1
    F(j+1,1) = -j;
end
%compare the top left, top and left cells of each cell and assign the one
%with the maximum score of similarity
for i = 2:m
    for j = 2:n
        match = F(i-1,j-1)+sm(nt2int(seq1(i-1)),nt2int(seq2(j-1)));
        delete = F(i-1,j) - 1;
        insert = F(i,j-1) - 1;
        max_blocks = [match,insert,delete];
        F(i,j) = max(max_blocks);
        count = count+1;
        %disp("Completed: "+count+"/"+max_time)
    end
       
end
toc
disp(newline)
%end of matrix initialization

% find the best sequence wiht the highest score 
tic
AlignmentA = [];
AlignmentB = [];
Alignment = [];
i = m;
j = n;
score = F(i,j);
[score,index] = max(F(:,n));
i = find(F(:,n)==score, 1, 'last' );
score = 0;

while (j > 1)
    
  if (i > 1 && j > 1 && (F(i,j) == F(i-1,j-1) + sm(nt2int(seq1(i-1)),nt2int(seq2(j-1)))))
  
    AlignmentA = [seq1(i-1) AlignmentA];
    AlignmentB = [seq2(j-1) AlignmentB];
    if (seq1(i-1) == seq2(j-1)),
        Alignment = ['|' Alignment];
    else
        Alignment = [':' Alignment];
    end
    score = score + F(i,j);
    i = i - 1;
    j = j - 1;
    
  
  elseif (j > 1 && i > 1 && ((F(i,j) == F(i-1,j) - 1)))
  
    AlignmentA = [seq1(i-1) AlignmentA];
    AlignmentB = ['-' AlignmentB];
    Alignment = [' ' Alignment];
    score = score + F(i,j);
    i = i - 1;
    
  
  elseif (j > 1 && ((F(i,j) == F(i,j-1) - 1)))
  
    AlignmentA = ['-' AlignmentA];
    AlignmentB = [seq2(j-1) AlignmentB];
    Alignment = [' ' Alignment];
    score = score + F(i,j);
    j = j - 1;
    
  end
end

toc
disp(newline)
i = 1;
while AlignmentB(i) == '-',
    i = i+1;
end
 
final =[AlignmentA(i:end);Alignment(i:end);AlignmentB(i:end)];
disp("The best sequence alignment is: ");
disp(final );
disp("With score of: "+score);