params[
    "_position",
    ["_useAtLocation",false],
    ["_distanceConsideredInArea",400]
];
format["%1 called by %2 on %3", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;

_location = (nearestLocations [ _position, [ "NameVillage", "NameCity","NameCityCapital","NameMarine","Hill"],5000,_position]) select 0;
_locationName =  text (_location);
_locationPosition = position _location;

_text = "";
if (_position distance2D _locationPosition > _distanceConsideredInArea) then {
    _relDir = _locationPosition getDir _position;
    _text = format [localize "STR_TRGM2_location_fngetLocationName_DirOfName",[_relDir,true] call TRGM_GLOBAL_fnc_directionToText,_locationName];
} else {
    _format =  ["%1",localize "STR_TRGM2_location_fngetLocationName_At"] select _useAtLocation;
    _text = format [_format,_locationName];
};
_text;