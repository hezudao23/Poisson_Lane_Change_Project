%% Visualization of the car with its position, 09/05/2018
% by Yunlong Huang
% #1 c_X is the center x coordinate relative to the Low Left Corner
% of the Lanes
% #2 c_Y is the center y coordinate relative to the Low Left Corner
% of the Lanes
% #3 Orientation_Diff is the orietation difference of the car 
%relative to the global coordinate.
% #4 Ego_Truth_value if the vehicle is the ego vehicle the value is true,
% otherwise, it is false
%% Given that a family car with Body_Length = 4.7 (meters) 
% Body_Width = 1.7 (meters)
%% Orientation_Diff
% Y
% |      Y'  |
% |       Y' |    X'
% |        Y'|  X'       The orientation of car (i.e. state.theta)
% |          O-----------
% |
% |_______________________________X
%-------------------------------------------------------------------------%
function Vehicle_handle = Plot_Vechile(Vehicle_State)

    %% Initializtion for test  
    if nargin < 1
        c_X = 20;
        c_Y = 2.5 * 3.7;
        theta = 0;
        Ego_Truth_Value = false;
    else
        c_X = Vehicle_State.x;
        c_Y = Vehicle_State.y;
        theta = Vehicle_State.theta;
    end
    %% In real simulation, we need to throw exception for...
    %% "Not enough inputs"

    Body_Length = 4.7;
    Body_Width = 1.7;
    Rotation_Matrix = [cos(theta), -sin(theta);...
                       sin(theta), cos(theta)];
    %% We would like to generate the four vertexs for the vehicles
    Tmp = 0.5 * [1, 1, -1, -1; -1, 1, 1, -1];
    Displacement = [Body_Length; Body_Width];
    Four_Displacements = Displacement .* Tmp;
    Global_Displacements = Rotation_Matrix * Four_Displacements;
    Four_Vertices = Global_Displacements + [c_X; c_Y];

    if Vehicle_State.Id == 1
        color = 'm';
    else
        color = 'b';
    end
    
    Vehicle_handle = patch(Four_Vertices(1, :), Four_Vertices(2, :), color);
    hold on;
    

end