format["%1 called by %2 on %3", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;

if (hasInterface) then {
    titleCut ["", "BLACK in", 5];
    _camera cameraEffect ["Terminate","back"];
    sleep 10;
    player allowdamage true;
    player doFollow player;
};