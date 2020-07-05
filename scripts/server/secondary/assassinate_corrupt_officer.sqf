/*Spawns an officer and two escorts at an OPFOR outpost. Goal is to kill him.
Reward: civ rep
contributors BYannoni and LPatmore-Zarcone*/

//declare variables (28800 is 8 hours)
private _endtimer = time + 28800;
private _reward = [5, false];
private _random = selectRandom sectors_military;
//private _spawn_marker = getmarkerpos _random;
private _spawn_marker = getpos player;


//removes used bases from possible bases, currently disabled
//used_positions pushbackUnique _spawn_marker;


//spawns officer group and sets them patrolling
private _officerGrp = createGroup [GRLIB_side_enemy, true];
private _officersPos = _spawn_marker getPos [5, random 360];

[opfor_officer, _officersPos, _officerGrp, "CAPTAIN", 0.5] call KPLIB_fnc_createManagedUnit;
sleep 0.2;

[opfor_rifleman, _officersPos getPos [1, random 360], _officerGrp, "PRIVATE", 0.5] call KPLIB_fnc_createManagedUnit;
sleep 0.2;

[opfor_rifleman, _officersPos getPos [1, random 360], _officerGrp, "PRIVATE", 0.5] call KPLIB_fnc_createManagedUnit;
sleep 0.2;

_officerGrp call add_officer_waypoints;


//add marker
secondary_objective_position_marker = _spawn_marker getPos [10, 0];
publicVariable "secondary_objective_position_marker";
sleep 1;
GRLIB_secondary_in_progress = 2; publicVariable "GRLIB_secondary_in_progress";
["lib_cr_sar", [markertext _random]] call BIS_fnc_showNotification;
_secondary_marker = createMarker ["secondarymarker", secondary_objective_position_marker];
_secondary_marker setMarkerColor GRLIB_color_enemy_bright;
_secondary_marker setMarkerType "hd_objective";


//end condition
private _officer = leader _officerGrp;
waitUntil {
    sleep 5;
	(!alive _officer) or (_endtimer == time)
};

if (!alive _officer)
	then {
	hint localize "STR_NOTIFICATION_KCO_SUCCESS";
	_reward call F_cr_changeCR;
	}
	else {
	hint localize "STR_NOTIFICATION_KCO_FAILURE";
	};

GRLIB_secondary_in_progress = -1; publicVariable "GRLIB_secondary_in_progress";
sleep 1;
doSaveTrigger = true;

//to do: add QRF, remove markers/units when mission is over, limit to opfor controlled military sites, change time constraint, add alternate versions