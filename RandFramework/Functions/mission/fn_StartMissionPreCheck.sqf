_isFinal = _this select 0;
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

_bAllow = true;

if (isMultiplayer) then {

	_bSLAlive = false;
	_bK1_1Alive = false;
	if (!isnil "sl") then { //sl is leader of K1 - k2_1 is leader of K2
		_bSLAlive = alive sl;
	};
	if (!isnil "k2_1") then {
		_bK1_1Alive = alive k2_1;
	};

	if (_bSLAlive && str(player) != "sl") then {
		hint (localize "STR_TRGM2_attemptendmission_Kilo1");
		_bAllow = false;
	};

	if (!_bSLAlive && _bK1_1Alive && str(player) != "k2_1") then {
		hint (localize "STR_TRGM2_attemptendmission_Kilo2");
		_bAllow = false;
	};
	if (!_bSLAlive && !_bK1_1Alive && (leader (group player))!=player) then {
			hint (localize "STR_TRGM2_attemptendmission_Kilo1");
			_bAllow = false;
	};


};

if (_bAllow) then {
	if (_isFinal) then {
		TREND_FinalMissionStarted=true; publicVariable "TREND_FinalMissionStarted";
	};

	chopper1 setVariable ["baseLZ", getPos heliPad1, true];
	[chopper1] spawn TREND_fnc_flyToBase;
	chopper1 setPos getPos heliPad1;
	chopper2 setPos getPos airSupportHeliPad;
	"transportChopper" setMarkerPos getPos chopper1;
	chopper1 engineOn false;
	chopper2 engineOn false;
	_escortPilot = driver chopper2;
	{
		deleteWaypoint _x
	} foreach waypoints group _escortPilot;
	sleep 0.2;
	[] remoteExec ["TREND_fnc_StartMission",0,true];
	//hint (localize "STR_TRGM2_attemptendmission_Ending");
	//[] spawn TREND_fnc_endMission;
};

true;