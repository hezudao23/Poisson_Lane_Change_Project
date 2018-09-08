%% This is the file for plot the arena : Straight_lanes type 09/05/22018
%% by Yunlong Huang 
% Parameter #1 x_init, the starting ptoins for visualization
% Parameter #2 Length of the lane    --> L (in the unit of meter)
% Parameter #3 Number of lanes       --> Number_Of_Lane

% Output #1 Lanes_INFO.x_init -> lanes' starting points on x-axis.
% Output #2 Lanes_INFO.L -> length of the lane
% Output #3 Lanes_INFO.Number_Of_Lanes -> Number_Of_Lanes;
% Output #4 Lanes_INFO.Lanes_handle -> the figure handle;
function Lanes_INFO = Plot_Straight_Lanes(x_init, L, Number_Of_Lanes)
    
    Lanes_INFO.x_init = x_init;
    Lanes_INFO.L = L;
    Lanes_INFO.Number_Of_Lanes = Number_Of_Lanes;

    Width_Of_Lane = 3.7; % Normal high ways have 3.7 meter width.
    Lane_Shoulder_Width = Width_Of_Lane;
    
    
    
    %% Initalize the X coordinates for lanes visualization
    Y_base = [0, Lane_Shoulder_Width];
    for i = 1 : Number_Of_Lanes
        Y_base = [Y_base, Y_base(end) + Width_Of_Lane];
    end
    Y_base = [Y_base, Y_base(end) + Lane_Shoulder_Width];

    %% Initialize the Y coordinate for lanes visualization
    
    X_Coordinates = linspace(x_init, L + x_init, 200); % 200 is the resolution 
    %## in total 200 points
    
    Y_Coordinates = ones(1, 200).*Y_base';
    
    Lanes_INFO.Lanes_handle = figure('Name', 'Straight Lanes');
    set(gcf, 'units', 'centimeter', 'position', [1, 1, 30, 15]); 
    % the last one is height and the second last one is the width 
    for i = 1 : length(Y_base)
        plot(X_Coordinates, Y_Coordinates(i, :), '--k');
        hold on;
    end
    %% Fill the road shoulders
    patch([X_Coordinates, flip(X_Coordinates)],...
        [Y_Coordinates(1, :), Y_Coordinates(2, :)], 'c');
    hold on;
    patch([X_Coordinates, flip(X_Coordinates)],...
        [Y_Coordinates(end - 1, :), Y_Coordinates(end, :)], 'c');
    hold on;
    %% 
end
