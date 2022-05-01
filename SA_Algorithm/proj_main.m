%% Solving a Rubik's Cube via Simulated Annealing
%{
Authors: William Wang, Quinton Uradomo
Description: This script runs the main simulated annealing algorithm and
performs the optimization to find a solution to the Rubik's Cube scramble
Inputs: none
Outputs: none
Dependencies: Rubik's cube simulator code (provided in this directory)
%}

%{
NOTE: We are currently using a 3x3x6 matrix to represent the Rubik's Cube
(R). The following descibes what each layer (1 to 6) represents in regard
to the cube.
1. F, front face, red
2. R, right face, blue
3. B, back face, orange
4. L, left face, green
5. U, upper face, white
6. D, bottom face, yellow
%}

clear
clc
close all

%% Run loop through N randomized initial cubes
N = 1;          % number of runs to perform

for i = 1:N
    %% Begin with a randomized cube state
    R = rubgen(3, 100);
    
    % plot the initial cube
    figure
    rubplot(R);
    title("Initial Cube");
    
    %% Initialize problem
    % Temp = 1.8;                % T = 5000 was determined in the paper
    % Delta = 0.9999;               % cooling constant for the temperature
    Temp = 5000;              % These variables were highlighted in the paper
    Delta = 0.95;
    Moves = {};                 % vector to store all the moves performed by the algorithm
    C_best = proj_cost_func(R);    % initialize variable to store best cost (minimum)
    C_curr = C_best;               % initialize variable to store cost of each step
    Cost_vec = C_curr;              % store the cost for every iteration
    Best_cost_vec = C_curr;         % store the best cost over all iterations
    Temp_vec = Temp;                % stores the temperature on every iteration
    Moves_best = Moves;             % stores the moves that give the best cost
    R_Best = R;                     % stores the best state that give the best cost
    
    %% SA main loop
    % evaluate loop until we reach a solution
    Iter = 0;
    while Iter < 300 && C_curr > 0
        % Perform algorithm
        [R, Moves, C_curr] = proj_sim_anneal_func(R, Moves, Temp);
    
        % Store the temperature
        Temp_vec = [Temp_vec, Temp];
    
        % Update the best cost and best moves
        if C_curr < C_best          % We found a better cost
            C_best = C_curr;
            Best_cost_vec = [Best_cost_vec, C_best];
            Moves_best = Moves;
            R_Best = R;
        else                        % Cost is not better
            Best_cost_vec = [Best_cost_vec, C_best];
        end
        
        % Collect cost at every iteration
        Cost_vec = [Cost_vec, C_curr];
    
        % Display costs and temperatures to the screen
        clc
        disp("Current_Cost"); disp(C_curr);
        disp("Current_Temp"); disp(Temp);
    
        % Update the temperature variable
        Temp = Temp*Delta;
        Iter = Iter + 1;
    end
    
    %% plot the best cube
    figure
    rubplot(R_Best);
    title("Best Cube Solution");
    
    %% Plot the temperature for all iterations
    % figure
    % plot(1:length(Temp_vec), Temp_vec, 'LineWidth', 2);
    % xlabel("Function Evaluations");
    % ylabel("Temperature");
    
    %% Plot the cost for all iterations
    figure
    plot(1:length(Cost_vec), Cost_vec, 'LineWidth', 0.7);
    ylim([0, 50]);
    xlabel("Function Evaluations");
    ylabel("Cost");
    title("Cost Over All Evaluations");
    
    %% Plot the best cost
    figure
    plot(1:length(Best_cost_vec), Best_cost_vec, 'LineWidth', 2);
    xlabel("Function Evaluations");
    ylabel("Best Cost");
    title("Best Cost Across All Evaluations");
    
    %% Update variables for the average overall performance
    overall_cost(i,:) = Cost_vec;
    overall_best_cost(i,:) = Best_cost_vec;

end

%% Plot the average costs (best costs)

% Define the CI Equation
CIFcn = @(x,p)prctile(x,abs([0,100]-(100-p)/2));

% (NOTE: The averages for all recorded costs and it's confidence intervals
% are not useful)
% All recorded costs 
% overall_cost_avg = mean(overall_cost, 1);       % mean
% overall_cost_CI = CIFcn(overall_cost, 95);      % 95 percent CI
% 
% figure
% plot(1:length(overall_cost_avg), overall_cost_avg);
% hold on
% plot(1:length(overall_cost_CI), overall_cost_CI);

% Best recorded costs
overall_best_cost_avg = mean(overall_best_cost, 1);     % mean
overall_best_cost_CI = CIFcn(overall_best_cost, 95);    % 95 percent CI

% plot of the average for the best costs for all runs
figure
plot(1:length(overall_best_cost_avg), overall_best_cost_avg, 'LineWidth', 2, ...
    'Color', 'black');
hold on
plot(1:length(overall_best_cost_CI), overall_best_cost_CI, 'LineWidth', 1, ...
    'LineStyle', '--', 'Color', 'black');
xlabel('Function Evaluations');
ylabel('Best Cost');
title('Average Best Costs')
legend('Average', '95% CI');

