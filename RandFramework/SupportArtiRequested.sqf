// This is a legacy script to allow use with older versions of TRGM that still have execVM functions in the mission.sqm
// Any edits should be done in the main function.
params ["_artiVeh"];
[_artiVeh] spawn TRGM_CLIENT_fnc_supportArtiRequested;