triangle(A,A,A).
triangle(A,B,C):- (A+B)>C, (A+C)>B, (B+C)>A.