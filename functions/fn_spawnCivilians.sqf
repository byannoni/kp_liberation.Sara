/*
    File: fn_spawnCivilians.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-12-03
    Last Update: 2020-04-05
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Spawns civilians at given sector.

    Parameter(s):
        _sector - Sector to spawn the civilians at [STRING, defaults to ""]

    Returns:
        Spawned civilian units [ARRAY]
*/

params [
    ["_sector", "", [""]]
];

if (_sector isEqualTo "") exitWith {["Empty string given"] call BIS_fnc_error; []};

private _civs = [];
private _sPos = markerPos _sector;

// Amount and spread depending if capital or city/factory
private _amount = round ((3 + (floor (random 7))) * GRLIB_civilian_activity);
private _spread = 75;
if (_sector in sectors_bigtown) then {
    _amount = _amount + 10;
    _spread = _spread * 2.5;
};
_amount = _amount * (sqrt (GRLIB_unitcap));

private _houses_pos = [];

{
    _houses_pos append (_x buildingPos -1);
} foreach nearestObjects [_sPos, ["house"], _spread];

// Spawn civilians
private _grp = grpNull;
private _in_house = 0;
private _pos = [0, 0, 0];

for "_i" from 1 to _amount do {
    _grp = createGroup [GRLIB_side_civilian, true];
    _in_house = 5 > random 10;

    if (_in_house) then {
        _pos = selectRandom _houses_pos;
    } else {
        _pos = _sPos vectorAdd [
            _spread - random (2 * _spread),
            _spread - random (2 * _spread),
            -(_sPos select 2)
        ];
    };

    _civs pushBack (
        [selectRandom civilians, _pos, _grp] call KPLIB_fnc_createManagedUnit
    );

    if (_in_house) then {
        // Set in building
        {
            doStop _x;
            _x setUnitPos "MIDDLE";
            _x disableAI "path";
        } foreach units _grp;
    } else {
        [_grp] call add_civ_waypoints;
    };
};

_civs
