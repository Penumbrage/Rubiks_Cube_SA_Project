clear 
clc
close all

%% globalize 2 different cubes
global R
global Rscram

% reset cubes 3x3 0 random moves
R = rubgen(3,0);
[R,scramble] = rubgen(3,23,'Animate',0);
Rscram = rubgen(3,0);

%% proof that sequence of random moves can be generated
% generate and apply 2 random moves for a 3x3
[Rscram,scram] = rubgen(3,2);

% visuallize the random 4 move scramble
Rscram = rubplot(Rscram);

%% proof that moves can be converted and applied to a cube
% convert rubiks cube moves to code moves ex.(U -> z11)
move = rub2move(scram);

% apply moves to R
R1 = rubrot(R,{'R','U'})
R2 = rubrot(R, scram)

% visualize cube from converted random 4 move scramble
figure
rubplot(R1)

% figures should be the same

