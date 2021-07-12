if (isDedicated || !hasInterface) exitWith {};


//waitUntil { TRGM_VAR_bAndSoItBegins };
//if (TRGM_VAR_iUseRevive == 0) exitWith {["AIS: AIS shutdown, player disabled revive."] call BIS_fnc_logFormat};


if (ais_ace_shutdown) exitWith {diag_log ["AIS: AIS shutdown itself cause ACE mod was detected. ACE and AIS cant work at the same time."]};
if (!(isNil "AIS_MOD_ENABLED")) exitWith {diag_log ["AIS: AIS shutdown itself cause AIS mod was detected. Two instances of AIS cant work at the same time."]};
/*
// expample action
_action = [
    "Text",                            // action text
    player,                            // object which the action is assigned
    2,                                // distance where action is shown (0 means max distance = 15m)
    "true",                            // condition to show the action
    {
        my_code                        // code perform on action
    },
    [],                                // Optional: custom variables run trough
    "<t color='#ff0000'>%1</t>"        // Optional: formated text for setUserActionText
] call AIS_Core_fnc_addAction;
*/

[
    localize "STR_TRGM2_fnpostinit_FirstAid",
    player,
    1.5,
    "cursorTarget isKindOf 'CAManBase' && {cursorTarget getVariable ['ais_unconscious',false]} && {cursorTarget call AIS_System_fnc_allowRevive}",
    {
        [player, cursorTarget] spawn AIS_System_fnc_Revive;
    },
    [],
    "<t color='#E9FDF7'>%1</t><br/><img size='3.5' color='#FDEA1C' image='\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_reviveMedic_ca.paa'/>"
] call AIS_Core_fnc_addAction;

[
    localize "STR_TRGM2_fnpostinit_Stabilize",
    player,
    1.5,
    "cursorTarget isKindOf 'CAManBase' && {cursorTarget getVariable ['ais_unconscious',false]} && {cursorTarget call AIS_System_fnc_allowStabilize}",
    {
        [player, cursorTarget] spawn AIS_System_fnc_Stabilize;
    },
    [],
    "<t color='#E9FDF7'>%1</t><br/><img size='2.5' color='#f0ff0000' image='\a3\ui_f\data\IGUI\Cfg\Actions\bandage_ca.paa'/>"
] call AIS_Core_fnc_addAction;

[
    localize "STR_TRGM2_fnpostinit_Drag",
    player,
    1.8,
    "cursorTarget isKindOf 'CAManBase' && {cursorTarget getVariable ['ais_unconscious',false]} && {cursorTarget call AIS_System_fnc_allowDrag}",
    {
        [player, cursorTarget] call AIS_System_fnc_drag;
    },
    [],
    "<t color='#E9FDF7'>%1</t><br/><img size='2.5' color='#f0bfbfbf' image='\a3\ui_f\data\IGUI\Cfg\Actions\take_ca.paa'/>"
] call AIS_Core_fnc_addAction;

[
    localize "STR_TRGM2_fnpostinit_Carry",
    player,
    0,
    "!(isNull (player getVariable ['ais_DragDrop_Torso', objNull])) && {!(player getVariable ['ais_CarryDrop_Torso', false])}",
    {
        [player] spawn AIS_System_fnc_carry;
    },
    [],
    "<t color='#E9FDF7'>%1</t><br/><img size='2.5' color='#f0bfbfbf' image='\a3\ui_f\data\IGUI\Cfg\Actions\take_ca.paa'/>"
] call AIS_Core_fnc_addAction;

[
    localize "STR_TRGM2_fnpostinit_Release",
    player,
    0,
    "!(isNull (player getVariable ['ais_DragDrop_Torso', objNull]))",
    {
        [player] call AIS_System_fnc_release;
    },
    [],
    "<t color='#E9FDF7'>%1</t><br/><img size='2.5' color='#f0bfbfbf' image='\a3\ui_f\data\IGUI\Cfg\Actions\ico_OFF_ca.paa'/>"
] call AIS_Core_fnc_addAction;

[
    localize "STR_TRGM2_fnpostinit_UnloadInjured",
    player,
    4,
    "(cursorTarget isKindOf 'LandVehicle' || cursorTarget isKindOf 'Air') && {alive cursorTarget} && {cursorTarget call AIS_System_fnc_allowPullOut}",
    {
        [player, cursorTarget] call AIS_System_fnc_unloadInjured;
    },
    [],
    "<t color='#E9FDF7'>%1</t><br/><img size='2.5' color='#f0bfbfbf' image='\a3\ui_f\data\IGUI\Cfg\Actions\unloadAllVehicles_ca.paa'/>"
] call AIS_Core_fnc_addAction;


[
    localize "STR_TRGM2_fnpostinit_LoadInjured",
    player,
    4,
    "!(isNull (player getVariable ['ais_DragDrop_Torso', objNull])) && {cursorTarget isKindOf 'LandVehicle' || cursorTarget isKindOf 'Air'} && {cursorTarget call AIS_System_fnc_allowPullIn}",
    {
        [player, cursorTarget] call AIS_System_fnc_loadInjured;
    },
    [],
    "<t color='#E9FDF7'>%1</t><br/><img size='2.5' color='#f0bfbfbf' image='\a3\ui_f\data\IGUI\Cfg\Actions\Obsolete\ui_action_getincargo.paa'/>"
] call AIS_Core_fnc_addAction;
