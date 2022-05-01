%% Simulated Annealing Cost Function
%{
Authors: William Wang, Quinton Uradomo
Description: This script outlines the cost function that is used in the SA
algorithm
Input: the current state of the cube (R)
Output: cost of the current state of the cube (cost)
Dependencies: Rubik's cube simulator code (provided in this directory)
%}

function cost = proj_cost_func(R)
% cost function based on how many colors in the wrong spot

cost = 0;
% iterate through faces, then the rows and columns of that face
for face = 1:6
    for row = 1:3
        for column = 1:3
            if R(row,column,face) ~= face
                cost = cost+1;
            end
        end
    end
end
end