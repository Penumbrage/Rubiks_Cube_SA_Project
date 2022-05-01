% function [R_new, moves_new, C_new] = proj_sim_anneal_func(R, moves, Temp)
    % cell array of possible moves to choose from
    possible_moves = {'U', 'U''', 'U2', 'D', 'D''', 'D2', 'R', 'R''', 'R2'...
                        'L', 'L''', 'L2', 'F', 'F''', 'F2', 'B', 'B''', 'B2'};

    R = rubgen(3, 100);
    C_curr = proj_cost_func(R);

    moves = {};
    for i = 1:100
        moves(i) = possible_moves(randi(18));
    end

    moves_new = moves;

    while C_curr > 0
        for i = 1:100
            moves_new(i) = possible_moves(randi(18));
            R_new = rubrot(R, moves_new);
            C_new = proj_cost_func(R_new);
            if C_new < C_curr
                moves = moves_new;
                C_curr = C_new;
            else
                for j = 1:18
                    moves_new(j) = possible_moves(j);
                    R_new = rubrot
            end
            disp("cost"); disp(C_curr);
        end
    end

%     % Choose a randomized move to apply to the current move string
%     next_move = possible_moves(randi(18));
% 
%     % Apply this current move to the current state of the Rubik's cube
%     R_test = rubrot(R, next_move);
% 
%     % Evaluate the current cost with this move applied
%     Cost_test = proj_cost_func(R_test);
% 
%     % Evaluate previous cost with previous state
%     Cost_original = proj_cost_func(R);
% 
%     % Evaluate cost difference
%     Cost_diff = Cost_test - Cost_original;
% 
%     % Evaluate if cost is better (i.e. smaller) than previous cost and
%     % decide whether to keep the current move
%     if Cost_diff > 0            % bad move, evaluate probability of accepting move
%         prob_reject = exp(-Cost_diff/Temp);
%         if rand < prob_reject   % accept bad move
%             moves_new = [moves, next_move];
%             R_new = R_test;
%             C_new = Cost_test;
%             R = R_test;
%         else                    % reject next move and maintain current matrix
%             R_new = R;
%             moves_new = moves;
%             C_new = Cost_original;
%         end
%     else                        % good move, accept move
%         R_new = R_test;
%         moves_new = [moves, next_move];
%         C_new = Cost_test;
%         R = R_test;
%     end
% % end