
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
[0.1,localize "STR_TRGM2_SupplyDropVehInit_Hint"] spawn TREND_fnc_AdjustBadPoints;