%%%%%%%%%%%%%%%%%%%%%%%%%%
% State variables
%%%%%%%%%%%%%%%%%%%%%%%%%%

state_fluent(free_North).
state_fluent(free_NorthWest).
state_fluent(free_West).
state_fluent(free_SouthWest).

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Actions
%%%%%%%%%%%%%%%%%%%%%%%%%%

action(cruise).
action(keep_distance).
action(change_lane).

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Utilities
%%%%%%%%%%%%%%%%%%%%%%%%%%

utility(free_North(1), 5).
utility(rearEnd_crash(1), -30).  
utility(sideSwipe_crash(1), -10).  
utility(keep_distance, -10).
utility(change_lane, -1).

0.99::rearEnd_crash(1) :- not(free_North(1)), cruise, not(keep_distance).
0.95::rearEnd_crash(1) :- not(free_NorthWest(1)), change_lane.
0.95::sideSwipe_crash(1) :- not(free_West(1)), change_lane.

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transitions
%%%%%%%%%%%%%%%%%%%%%%%%%%

% Action: cruise
0.96::free_North(1) :- free_North(0), cruise.
0.05::free_North(1) :- not(free_North(0)), cruise.

% Action: change_lane
0.99::free_North(1) :- free_NorthWest(0), free_West(0), change_lane.
0.05::free_North(1) :- not(free_NorthWest(0)), change_lane.
0.05::free_North(1) :- not(free_West(0)), not(free_SouthWest(0)), change_lane.

% Action: keep_distance
0.5::free_North(1) :- not(free_North(0)), free_West(0), keep_distance.

