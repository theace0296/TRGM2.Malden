_posOfAO =  _this select 0;
_eventType = _this select 1; //1=fullWar  2=AOOnly  3=WarzoneOnly 4=warzoneOnlyFullWar
format["%1 called by %2 on %3", _fnc_scriptName, _fnc_scriptNameParent, (["Client", "Server"] select isServer)] call TRGM_GLOBAL_fnc_log;
call TRGM_SERVER_fnc_initMissionVars;

_nearLocations = nearestLocations [_posOfAO, ["NameCity","NameCityCapital","NameVillage"], 1500];

_eventLocationPos = nil;
if (!isNil("TRGM_VAR_ForceWarZoneLoc")) then {
    _eventLocationPos = _posOfAO;
}
else {
    {
        _xLocPos = locationPosition _x;
        if (_xLocPos distance _posOfAO > 950) then {
            _eventLocationPos = _xLocPos;
            //[str(_xLocPos distance _posOfAO)] call TRGM_GLOBAL_fnc_notify;
        };
    } forEach _nearLocations;


    if (isNil("_eventLocationPos")) then {
        _buildings = nearestObjects [_posOfAO, TRGM_VAR_BasicBuildings, 2000];
        {
            _xLocPos = position _x;
            _bIsClearFromAOCamp = true;
            if (!isNil "TRGM_VAR_AOCampPos") then {
                if (_xLocPos distance TRGM_VAR_AOCampPos < 500) then {
                    _bIsClearFromAOCamp = false;
                };
            };
            if (_xLocPos distance _posOfAO > 950 && _bIsClearFromAOCamp) then {
                _eventLocationPos = _xLocPos;
            };
        } forEach _buildings;
    };
};

if (isNil("_eventLocationPos")) then {_eventType = 2};


//(call sTeamleaderToUse)
//(call sRiflemanToUse)
//(call sMachineGunManToUse)
//(call sTank3TankToUse)

//TankorAPC
//(call FriendlyCheckpointUnits)

//TESTTESTeventLocationPos = _eventLocationPos;

TRGM_VAR_WarzonePos = _eventLocationPos;

if (_eventType isEqualTo 1 || _eventType isEqualTo 3 || _eventType isEqualTo 4) then {
    _mrkEnemy = createMarker ["mrkWarzoneEnemy", _eventLocationPos];
    _mrkEnemy setMarkerText "!!WARNING!! KEEP CLEAR";
    _mrkEnemy setMarkerShape "ICON";
    _mrkEnemy setMarkerColor "ColorEAST";
    _mrkEnemy setMarkerType "mil_warning";

    _mrkFriendlyPos = _eventLocationPos getPos [200 * sqrt random 1, random 360];
    _mrkFriendly = createMarker ["mrkWarzoneFriendly", _mrkFriendlyPos];
    _mrkFriendly setMarkerShape "ICON";
    _mrkFriendlyDir = [_mrkFriendlyPos, _eventLocationPos] call BIS_fnc_DirTo;
    _mrkFriendly setMarkerDir _mrkFriendlyDir;
    _mrkFriendly setMarkerColor "ColorWEST";
    _mrkFriendly setMarkerType "mil_arrow2";
};


_objPos = _eventLocationPos getPos [100 * sqrt random 1, random 360];
//_Obj1 = "land_helipadempty_f" createVehicle _objPos;
//nul = [_Obj1] execVM "RandFramework\Alias\ALambientbattle\alias_flaks.sqf";

/*if (random 1 < .50 || _eventType isEqualTo 1 || _eventType isEqualTo 4) then {
    _objPos = _eventLocationPos getPos [100 * sqrt random 1, random 360];
    _Obj8  = "land_helipadempty_f" createVehicle _objPos;
    null = [_Obj8,false] execVM "RandFramework\Alias\ALambientbattle\aaa_search_light.sqf";

    _objPos = _eventLocationPos getPos [100 * sqrt random 1, random 360];
    _Obj9  = "land_helipadempty_f" createVehicle _objPos;
    null = [_Obj9,false] execVM "RandFramework\Alias\ALambientbattle\aaa_search_light.sqf";
};*/
if (random 1 < .50 || _eventType isEqualTo 1 || _eventType isEqualTo 4) then {
    _flatPos1 =  _eventLocationPos getPos [100 * sqrt random 1, random 360];
    _flatPos1 = [_eventLocationPos , 0, 100, 8, 0, 0.5, 0,[],[_flatPos1,_flatPos1]] call TRGM_GLOBAL_fnc_findSafePos;
    tracer1 setPos _flatPos1;

    _flatPos2 =  _eventLocationPos getPos [100 * sqrt random 1, random 360];
    _flatPos2 = [_eventLocationPos , 0, 100, 8, 0, 0.5, 0,[],[_flatPos2,_flatPos2]] call TRGM_GLOBAL_fnc_findSafePos;
    tracer2 setPos _flatPos2;

    _flatPos3 =  _eventLocationPos getPos [100 * sqrt random 1, random 360];
    _flatPos3 = [_eventLocationPos , 0, 100, 8, 0, 0.5, 0,[],[_flatPos3,_flatPos3]] call TRGM_GLOBAL_fnc_findSafePos;
    tracer3 setPos _flatPos3;

    _flatPos4 =  _eventLocationPos getPos [100 * sqrt random 1, random 360];
    _flatPos4 = [_eventLocationPos , 0, 100, 8, 0, 0.5, 0,[],[_flatPos4,_flatPos4]] call TRGM_GLOBAL_fnc_findSafePos;
    tracer4 setPos _flatPos4;

};

_mainAOPos = TRGM_VAR_ObjectivePossitions select 0;

if (_eventType isEqualTo 1 || _eventType isEqualTo 2) then {
    //_objPos = _mainAOPos getPos [100 * sqrt random 1, random 360];
    //_Obj10  = "land_helipadempty_f" createVehicle _objPos;
    //nul = [_Obj10] execVM "RandFramework\Alias\ALambientbattle\alias_flaks.sqf";
};

/*
WarColor = ppEffectCreate ["colorCorrections", 1550];
//WarColor ppEffectAdjust [1, 0.8, -0.001, [0.0, 0.0, 0.0, 0.0], [0.8*2, 0.5*2, 0.0, 0.7], [0.9, 0.9, 0.9, 0.0]];
WarColor ppEffectAdjust [1, 0.8, -0.001, [0.0, 0.0, 0.0, 0.0], [0.8*2, 0.5*2, 0.0, 0.92], [0.9, 0.9, 0.9, 0.0]];
WarColor ppEffectCommit 0;
WarColor ppEffectCommit 0;

WarGrain = ppEffectCreate ["FilmGrain", 2050];
WarGrain ppEffectEnable true;
WarGrain ppEffectAdjust [0.02, 1, 1, 0.1, 1, false];
WarGrain ppEffectCommit 0;

WarColor ppEffectEnable true;
WarGrain ppEffectEnable true;
*/

TRGM_VAR_WarEventActive = true;

[_eventLocationPos] spawn {
    _eventLocationPos = _this select 0;
    while {TRGM_VAR_WarEventActive} do {
        _type = selectRandom ["Bomb_03_F","Missile_AA_04_F","M_Mo_82mm_AT_LG"];
        _xPos = (_eventLocationPos select 0)-125;
        _yPos = (_eventLocationPos select 1)-125;


        if (random 1 < .15) then {
            _li_aaa = _type createVehicleLocal [_xPos+(random 250),_yPos+(random 250),0];
            _li_aaa setDamage 1;
        }
        else {

            _group = createGroup TRGM_VAR_EnemySide;
            _sUnitType = selectRandom [(call sRiflemanToUse),(call sMachineGunManToUse)];
            _tempFireUnit = [_group, _sUnitType,[_xPos+(random 250),_yPos+(random 250),0],[],0,"NONE"] call TRGM_GLOBAL_fnc_createUnit;
            hideObject _tempFireUnit;
            sleep 1;
            _shotsToFire = selectRandom[3,10,15];
            _weapon = currentWeapon _tempFireUnit;
            _ammo = _tempFireUnit ammo _weapon;
            _sleep = selectRandom [0.05,0.1];
            while {_shotsToFire > 0} do {
                _tempFireUnit forceWeaponFire [_weapon, "FullAuto"];
                _shotsToFire = _shotsToFire - 1;
                sleep _sleep;
            };

            deleteVehicle _tempFireUnit;
        };

        _sleep = 1+(random 6);
        _diceRoll = floor(random 12)+1;

        if (_diceRoll isEqualTo 1) then {_sleep = 10+random 5};
        if (_diceRoll > 6) then {_sleep = 0.5+random 1};
        //[str(_sleep)] call TRGM_GLOBAL_fnc_notify;

        sleep _sleep;
      };
};

[_eventLocationPos] spawn {
    _eventLocationPos = _this select 0;

    while {TRGM_VAR_WarEventActive} do {

        waitUntil {sleep 2; TRGM_VAR_bAndSoItBegins && TRGM_VAR_CustomObjectsSet && TRGM_VAR_PlayersHaveLeftStartingArea};

        _AirToUse = selectRandom (call FriendlyJet);
        _NoOfVeh = selectRandom [1,2];
        _bSetCaptive = random 1 < .75;
        if (random 1 < .33) then {
            _AirToUse = selectRandom (call FriendlyChopper);
        };
        _pos = _eventLocationPos getPos [3000,random 360];//random 360 and 3 clicks out and no playable units within 2 clicks
        _pos = [_pos select 0,_pos select 1, 365];
        _dir = [_pos, _eventLocationPos] call BIS_fnc_DirTo;//dir from pos to _eventLocationPos
        _WarzoneGroupp1 = createGroup TRGM_VAR_FriendlySide;
        _WarZoneAir1 = createVehicle [_AirToUse, _pos, [], 0, "FLY"];
        _WarZoneAir1 setDir _dir;
        createVehicleCrew _WarZoneAir1;
        crew vehicle _WarZoneAir1 joinSilent _WarzoneGroupp1;
        _WarZoneAir1 flyInHeight 45;
        _WarZoneAir1 setBehaviour "CARELESS";
        _WarZoneAir1 setSpeedMode "FULL";
        _WarZoneAir1 doMove (_pos getPos [60000,_dir]);
        _WarZoneAir1 setCaptive _bSetCaptive;
        _WarZoneAir2 = nil;
        if (_NoOfVeh > 1) then {
            _pos2 = _pos getPos [30,random 360];
            _WarZoneAir2 = createVehicle [_AirToUse, _pos2, [], 0, "FLY"];
            _WarZoneAir2 setDir _dir;
            createVehicleCrew _WarZoneAir2;
            crew vehicle _WarZoneAir2 joinSilent _WarzoneGroupp1;
            _WarZoneAir2 flyInHeight 45;
            _WarZoneAir2 setBehaviour "CARELESS";
            _WarZoneAir2 setSpeedMode "FULL";
            _WarZoneAir2 doMove (_pos getPos [60000,_dir]);
            _WarZoneAir2 setCaptive _bSetCaptive;
        };

        [_WarZoneAir1,_eventLocationPos] spawn {
            _veh = _this select 0;
            _eventLocationPos = _this select 1;
            while {alive _veh} do {
                _curDist = _veh distance _eventLocationPos;
                if (_curDist > 4000) then {
                    {_veh deleteVehicleCrew _x} forEach crew _veh;
                    deleteVehicle _veh;
                };
            };
        };

        if (_NoOfVeh > 1) then {
            [_WarZoneAir2,_eventLocationPos] spawn {
                _veh = _this select 0;
                _eventLocationPos = _this select 1;
                while {alive _veh} do {
                    _curDist = _veh distance _eventLocationPos;
                    if (_curDist > 4000) then {
                        {_veh deleteVehicleCrew _x} forEach crew _veh;
                        deleteVehicle _veh;
                    };
                };
            };
        };

        sleep selectRandom [240,480];

    };
};



/*
{nul = [99999,true] execVM "RandFramework\RikoSandStorm\ROSSandstorm.sqf";} remoteExec ["call", 0];
*/

/*
     WarColor ppEffectEnable false;
     ppEffectDestroy WarColor;

    WarGrain ppEffectEnable false;
    ppEffectDestroy WarGrain;
*/


true;