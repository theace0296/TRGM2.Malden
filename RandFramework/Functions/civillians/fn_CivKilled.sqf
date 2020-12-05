params ["_killed","_killer"];

if (isNil "TREND_CivDeathCount") then { TREND_CivDeathCount =   0; publicVariable "TREND_CivDeathCount"; };

_aceSource = _killed getVariable ["ace_medical_lastDamageSource", objNull];
if (!(_aceSource isEqualTo objNull)) then {
	_killer = _aceSource;
};

if (side _killer == west && str(_killed) != str(_killer)) then {
	TREND_bCivKilled =  true; publicVariable "TREND_bCivKilled";

	TREND_CivDeathCount = TREND_CivDeathCount + 1;
	publicVariable "TREND_CivDeathCount";

	[0.1,format[localize "STR_TRGM2_CivKilled_Text", name _killer]] spawn TREND_fnc_AdjustBadPoints;
};

true;