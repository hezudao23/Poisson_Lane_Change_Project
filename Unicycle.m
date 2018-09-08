%% In this one, we would like to update the vehicle state based on the 
%  "Unicycle Model"
% ------------------------------------------------------------------------
%   \dot{x} = v * cos(theta)
%   \dot{y} = v * sin(theta)
%   \dot{theta} = omega
%   \dot{v} = alpha
% ------------------------------------------------------------------------
%% The state parameters of a vehicle
%  state.Id -> 1, 2, 3, we woud like to give an index of the cars 
%  state.Ego - > true / false whether it is the Ego car or not
%  state.x -> x coordinate
%  state.y -> y coordinate
%  state.v -> the velocity "v"
%  state.theta -> the orientation theta
%  state.omega -> the control of the angular velocity "omega"
%  state.alpha -> the accleration
%  state.lane_change_duration ->time duration of lane change 5sec
%  state.lane_change_timer -> to record how long the vehilce has...
%                             to change lane
%  state.lane_change_direction -> -1 to the right lane, 
%                                  +1 to the left lane,
%                                  0 to stay in the lane
%  state.lambda -> the seed/ parameter lambda,
%                        randoml generating -1, 0, +1 
%                        for lane change. 
%  Delta_t is the sampling interval
function New_State = Unicycle(Old_State, Delta_t)
    New_State = Old_State;    
    
    New_State.x = Old_State.x + ...
        Old_State.v * Delta_t * cos(Old_State.theta);
    New_State.y = Old_State.y + ...
        Old_State.v * Delta_t * sin(Old_State.theta);
    New_State.theta = Old_State.theta + ...
        Delta_t * Old_State.omega;
    New_State.v = Old_State.v + ...
        Delta_t * Old_State.alpha;
    % here we did not updae the control omega and alpha
    %% if this is a dummy car doing lane change, we need to keep its ...
    % ... timer works well.
    if Old_State.lane_change_direction ~= 0
        Old_State.lane_change_timer = Delta_t ...
            + Old_State.lane_change_timer;
        if Old_State.lane_change_timer >= Old_State.lane_change_duration
            Old_State.lane_change_direction = 0;
            Old_State.lane_change_timer = 0;
        end
    end
    
end