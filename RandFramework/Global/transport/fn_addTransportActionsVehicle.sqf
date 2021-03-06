params ["_vehicle"];
format["%1 called by %2 on %3", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;

if (!isServer) exitWith {};


/********************* Add Vehicle Actions ****************/
_actionAdapter = {
    params ["_target", "_caller", "_ID", "_arguments"];
    [_target] spawn TRGM_GLOBAL_fnc_selectLz;
};

// add in vehicle Actions
_actions = [

    // Select Destination when in chopper on ground
    [
        localize "STR_TRGM2_transport_fnaddTransportAction_SelectDest",
        _actionAdapter,
        nil,
        -20, //priority
        false,
        true,
        "",
        ["_this in (crew _target) && !([_target] call TRGM_GLOBAL_fnc_helicopterIsFlying)", "[_this] call TRGM_GLOBAL_fnc_isLeaderOrAdmin && _this in (crew _target) && !([_target] call TRGM_GLOBAL_fnc_helicopterIsFlying)"] select (call TRGM_GETTER_fnc_bTransportLeaderOnly),
        -1,
        false,
        ""
    ],

    // Select Destination when in chopper and flying
    [
        localize "STR_TRGM2_transport_fnaddTransportAction_DivertLZ",
        _actionAdapter,
        nil,
        -20, //priority
        false,
        true,
        "",
        ["_this in (crew _target) && ([_target] call TRGM_GLOBAL_fnc_helicopterIsFlying)", "[_this] call TRGM_GLOBAL_fnc_isLeaderOrAdmin && _this in (crew _target) && ([_target] call TRGM_GLOBAL_fnc_helicopterIsFlying)"] select (call TRGM_GETTER_fnc_bTransportLeaderOnly),
        -1,
        false,
        ""
    ]
];


// add actions on vehicle
{
    [_vehicle, _x] remoteExec ["addAction",0,true];
    // TODO: ACE alternative
} foreach _actions;

true;