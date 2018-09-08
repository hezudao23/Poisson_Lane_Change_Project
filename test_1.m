%% This is a simple test for the visualization of cars and lanes
L = 300; % the length of the lane is 300 meter

h_1 = Plot_Straight_Lanes(0, L, 4); % Initialize the lanes for beginning

Vehicle_State = Vehicle_Initialize(1,...%index
                                   10, 3.7 * 2.5, ... % x, y coodinate
                                   10, 0, ... % x_speed, y_speed
                                   0, 0, ... % omega, alpha
                                   5,... % 5 seconds for lane change
                                   0, ... % lane change timer starts from 0
                                   1, ... % lane cahnge direction(-1, 1,0 )
                                   5); % "lambda" for Poisson process
for i = 1 : 1000
    %% How to update the plot of lanes based on the ego vehicle
    if ( h_1.L +  h_1.x_init -  Vehicle_State.x ) < 50 % 50 is some horizon
        delete(h_1.Lanes_handle);
        New_x_init = h_1.x_init + h_1.L - 100;
        h_1 = Plot_Straight_Lanes(New_x_init, h_1.L, h_1.Number_Of_Lanes);
    end
    %---------------------------------------------------------------------%
    %% We later also need to consider the change of lane action and control
    % of different vehicles. Thus we need to update their control before
    % update their controls
    if Vehicle_State.lane_change_direction ~= 0 %% 1 or -1
        Vehicle_State = Lane_Change_Action(Vehicle_State);
    end    
    %---------------------------------------------------------------------%
    
    %% We would like to do the normal state update 
    h_2 = Plot_Vechile(Vehicle_State);
    pause(0.2);
    Vehicle_State = Unicycle(Vehicle_State, 0.1);
    delete(h_2);
end

%% We need to have the simulation centered at around the "ego vehicle",
% whose index is 1. 
