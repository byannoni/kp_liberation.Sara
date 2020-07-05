/*handles the results of civilian reputation missions*/

if (isDedicated) exitWith {};

params ["_notiftype", ["_obj_position", getpos player]];

switch (_notiftype) do {
    case 0: {
        waitUntil {!isNil "secondary_objective_position_marker"};
        waitUntil {count secondary_objective_position_marker > 0};
        waitUntil {secondary_objective_position_marker distance zeropos > 1000};
        "lib_cr_sar" call BIS_fnc_showNotification;
        _secondary_marker = createMarker ["secondarymarker", secondary_objective_position_marker];
        _secondary_marker setMarkerColor GRLIB_color_enemy_bright;
        _secondary_marker setMarkerType "hd_objective";
		};
    default {[format ["remote_call_civrep.sqf -> no valid value for _notiftype: %1", _notiftype], "ERROR"] remoteExecCall ["KPLIB_fnc_log", 2];};
};