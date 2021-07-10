params ["_sidePos", "_distFromCent", "_bIsRebels"];
format["%1 called by %2 on %3", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;

_allBuildings = nil;
_allBuildings = nearestObjects [_sidePos, TRGM_VAR_BasicBuildings, _distFromCent];

_unitCount = count _allBuildings;
if (_unitCount > 10) then {
    _unitCount = 10;
};

_iCount = 0; //_unitCount
_randBuilding = nil;

_bAllCivsBad = random 1 < .25;

_bRebelLeaderPicked = false;
while {_iCount <= _unitCount} do
{
    //spanwn civ in random building pos
    _randBuilding = selectRandom _allBuildings;
    _sInitString = "";

    if (random 1 < .20) then {

        if (_bIsRebels) then {
                _sInitString = "_this spawn TRGM_SERVER_fnc_badReb;";

        }
        else {
            _sInitString = "_this spawn TRGM_SERVER_fnc_badCiv; _this addAction [localize ""STR_TRGM2_civillians_fnbadCivAddSearchAction_Button"",{[_this select 0, _this select 1] spawn TRGM_SERVER_fnc_badCivSearch;}, nil,1.5,true,true,"""",""true"",5]; removeHeadgear _this;Removevest _this;";
        };
    }
    else {
        if (_bIsRebels) then {
            if (!_bRebelLeaderPicked) then {
                _sInitString = "_this addaction [localize ""STR_TRGM2_trendFunctions_TalkToLeader"",{[_this select 0, _this select 1] spawn TRGM_SERVER_fnc_talkRebLead;}, nil,1.5,true,true,"""",""true"",5]; _this addEventHandler [""killed"", {_this spawn TRGM_SERVER_fnc_insKilled;}]; removeHeadgear _this;";
                _bRebelLeaderPicked = true;
            }
            else {
                _sInitString = "_this addEventHandler [""killed"", {_this spawn TRGM_SERVER_fnc_insKilled;}]; removeHeadgear _this;Removevest _this;";
            };
        }
        else {
            _sInitString = "_this addEventHandler [""killed"", {_this spawn TRGM_SERVER_fnc_civKilled;}]; _this addaction [localize ""STR_TRGM2_civillians_fnbadCivAddSearchAction_Button"",{[_this select 0, _this select 1] spawn TRGM_SERVER_fnc_searchGoodCiv;}, nil,1.5,true,true,"""",""true"",5]; removeHeadgear _this;Removevest _this;";
        };
    };
    _sideCivGroup = nil;
    if (_bIsRebels) then {
        _sideCivGroup = createGroup TRGM_VAR_FriendlySide;
    }
    else {
        _sideCivGroup = createGroup Civilian;
    };
    _allBuildingPos = _randBuilding buildingPos -1;

    if (_bIsRebels) then {
        _wayPosInit = selectRandom _allBuildingPos;
        if (!isNil "_wayPosInit") then {
            //_SpawnedRifleman = [_sideCivGroup, sRiflemanFriendInsurg, _wayPosInit, [], 10, "NONE"] call TRGM_GLOBAL_fnc_createUnit;
            _SpawnedRifleman = [_sideCivGroup, sRiflemanFriendInsurg, _wayPosInit, [], 10, "NONE"] call TRGM_GLOBAL_fnc_createUnit;
            [_SpawnedRifleman] joinSilent (_sideCivGroup);
            if (!_bRebelLeaderPicked) then {
                _SpawnedRifleman addaction [localize "STR_TRGM2_trendFunctions_TalkToLeader",{[_this select 0, _this select 1] spawn TRGM_SERVER_fnc_talkRebLead}];
                _SpawnedRifleman addEventHandler ["killed", {_this spawn TRGM_SERVER_fnc_insKilled;}];
                //_SpawnedRifleman forceAddUniform _sCivUniform;
                removeHeadgear _SpawnedRifleman;
                _bRebelLeaderPicked = true;
            }
            else {
                _sInitString = "_this addEventHandler [""killed"", {_this spawn TRGM_SERVER_fnc_insKilled;}]; removeHeadgear _this;Removevest _this;";
                _SpawnedRifleman addEventHandler ["killed", {_this spawn TRGM_SERVER_fnc_insKilled;}];

                _SpawnedRifleman spawn TRGM_SERVER_fnc_badReb;

                Removevest _SpawnedRifleman;
                removeHeadgear _SpawnedRifleman;
                _SpawnedRifleman setVariable ["IsRebel", true, true];
                _bRebelLeaderPicked = true;
            };

        };
    }
    else {
        _wayPosInit = selectRandom _allBuildingPos;
        if (!isNil "_wayPosInit") then {
            _sCivClass = sCivilian;
            if (typeName _sCivClass isEqualTo "ARRAY") then {
                _sCivClass = selectRandom sCivilian;
            };
            private _newCiv = [_sideCivGroup, _sCivClass, _wayPosInit, [], 0, "NONE"] call TRGM_GLOBAL_fnc_createUnit;
            _newCiv call compile _sInitString;
        };
    };

    //set waypoints to other buildings
    _iCountWaypoints = 0;
    while {_iCountWaypoints <= 4} do
    {
        _randBuilding2 = selectRandom _allBuildings; //pick one building from our buildings array
        _allBuildingPos2 = _randBuilding2 buildingPos -1;

        _wpSideCiv = nil;
        //_wpSideCiv = _sideCivGroup addWaypoint [_randBuilding2 buildingPos (selectRandom _allBuildingPos2), 0]; //This line has error "0 eleemnts provided, 3 expected"
        try {
            //_wpSideCiv = _sideCivGroup addWaypoint [selectRandom _allBuildingPos2, 0]; //This line has error "0 eleemnts provided, 3 expected"
            _wayPosInit = selectRandom _allBuildingPos2;
            if (!isNil "_wayPosInit") then {
                _wpSideCiv = _sideCivGroup addWaypoint [_wayPosInit, 0]; //This line has error "0 eleemnts provided, 3 expected"
            }

        }
        catch {
            [format ["Script issue: %1",selectRandom _allBuildingPos2]] call TRGM_GLOBAL_fnc_notify;
        };
        //_wp1 = _group addWaypoint [_wp1Pos, 0];

        [_sideCivGroup, _iCountWaypoints] setWaypointSpeed "LIMITED";
        [_sideCivGroup, _iCountWaypoints] setWaypointBehaviour "SAFE";
        if (_iCountWaypoints isEqualTo 4) then{[_sideCivGroup, 8] setWaypointType "CYCLE";};
        _iCountWaypoints = _iCountWaypoints + 1;
    };
    _sideCivGroup setBehaviour "SAFE";

    _iCount = _iCount + 1;
};

true;