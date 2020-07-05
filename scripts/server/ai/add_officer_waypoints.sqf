//gives officer group series of 5 waypoints to go to and loiter at for between 30 and 60 seconds
private _grp = _this;
private _basepos = getpos (leader _grp);

while {(count (waypoints _grp)) != 0} do {deleteWaypoint ((waypoints _grp) select 0);};
{_x doFollow leader _grp} foreach units _grp;

private _wpPositions = [
    _basepos getPos [random 50, random 360],
    _basepos getPos [random 50, random 360],
    _basepos getPos [random 50, random 360],
    _basepos getPos [random 50, random 360],
    _basepos getPos [random 50, random 360]
];

private _waypoint = _grp addWaypoint [_wpPositions select 0, 10];
_waypoint setWaypointType "LOITER";
_waypoint setWaypointBehaviour "SAFE";
_waypoint setWaypointSpeed "LIMITED";
_waypoint setWaypointCombatMode "GREEN";
_waypoint setWaypointCompletionRadius 5;
_waypoint setWaypointTimeout [30, 45, 60];

_waypoint = _grp addWaypoint [_wpPositions select 1, 10];
_waypoint setWaypointType "LOITER";
_waypoint setWaypointBehaviour "SAFE";
_waypoint setWaypointSpeed "LIMITED";
_waypoint setWaypointCombatMode "GREEN";
_waypoint setWaypointCompletionRadius 5;
_waypoint setWaypointTimeout [30, 45, 60];

_waypoint = _grp addWaypoint [_wpPositions select 2, 10];
_waypoint setWaypointType "LOITER";
_waypoint setWaypointBehaviour "SAFE";
_waypoint setWaypointSpeed "LIMITED";
_waypoint setWaypointCombatMode "GREEN";
_waypoint setWaypointCompletionRadius 5;
_waypoint setWaypointTimeout [30, 45, 60];

_waypoint = _grp addWaypoint [_wpPositions select 3, 10];
_waypoint setWaypointType "LOITER";
_waypoint setWaypointBehaviour "SAFE";
_waypoint setWaypointSpeed "LIMITED";
_waypoint setWaypointCombatMode "GREEN";
_waypoint setWaypointCompletionRadius 5;
_waypoint setWaypointTimeout [30, 45, 60];

_waypoint = _grp addWaypoint [_wpPositions select 4, 10];
_waypoint setWaypointType "CYCLE";
_waypoint setWaypointBehaviour "SAFE";
_waypoint setWaypointSpeed "LIMITED";
_waypoint setWaypointCombatMode "GREEN";
_waypoint setWaypointCompletionRadius 5;
_waypoint setWaypointTimeout [30, 45, 60];