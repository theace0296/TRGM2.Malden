
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
_artiVeh = _this select 0;
_artiVeh addEventHandler [
	"fired",
	"[0.1,localize 'STR_TRGM2_SupportArtiRequested_Hint'] spawn TREND_fnc_AdjustBadPoints; hint (localize ""STR_TRGM2_SupportArtiRequested_Hint"");"
];
