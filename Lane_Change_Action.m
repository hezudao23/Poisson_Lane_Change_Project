%% Piece of code for the simple sinusoidal lane change
% Based on the feedback linearization : the unicycle model-- 
%   \dot{x} = v * cos(theta)
%   \dot{y} = v * sin(theta)
%   \dot{theta} = omega
%   \dot{v} = alpha
%   can be transformed to be a linear model:
%   \dot{x} = v_{x}
%   \dot{y} = v_{y}
%   \dot{v_{x}} = u_{x}
%   \dot{v_{y}} = u_{y}
%   where 
%   v_{x} = v * cos(theta);
%   v_{y} = v * sin(theta)
%   |alpha|     |cos(tehta),  sin(theta)   ||u_{x}|
%   |     |  =  |                          ||     |
%   |omega|     |-sin(theta)/v,cos(theta)/v||u_{y}|
%%   This may only apply to the dummy cars
function Cur_State= Lane_Change_Action( Old_State ) % [omega, alpha] )
    Cur_State = Old_State;
    W = 3.7;
    t_f = Old_State.lane_change_duration;
    A = Old_State.lane_change_direction * W * pi / 2 / t_f;
    omega_bar = pi / t_f;
    Cur_State.omega = cos(Old_State.theta)/ Old_State.v * A *...
        omega_bar * cos(omega_bar * Old_State.lane_change_timer);
    Cur_State.alpha = sin(Old_State.theta) * A * omega_bar * ...
        cos(omega_bar * Old_State.lane_change_timer);
end