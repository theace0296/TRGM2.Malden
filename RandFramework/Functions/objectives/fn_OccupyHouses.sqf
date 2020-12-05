_sidePos = _this select 0;
_distFromCent = _this select 1;
_unitCounts = _this select 2;
_InsurgentSide = _this select 3;
_bThisMissionCivsOnly = _this select 4;

_unitCount = selectRandom _unitCounts;

_iCount = 0; //_unitCount
_allBuildings = nil;
_sAreaMarkerName = nil;
_randBuilding = nil;



if (!_bThisMissionCivsOnly) then {
	while {_iCount <= _unitCount} do
	{
		_allBuildings = nearestObjects [_sidePos, ["House"] + TREND_BasicBuildings, _distFromCent];
		//_allBuildings = nearestObjects [_sidePos, ["house"], _distFromCent];
		_randBuilding = selectRandom _allBuildings;
		if (!isNil "_randBuilding") then {
			_randBuildingPos = getPos _randBuilding;
			if ((_randBuilding distance getMarkerPos "mrkHQ") > TREND_BaseAreaRange && !(_randBuildingPos in TREND_OccupiedHousesPos)) then { //"mrkHQ", TREND_BaseAreaRange
			//if ((_randBuilding distance getMarkerPos "mrkHQ") > TREND_BaseAreaRange) then { //"mrkHQ", TREND_BaseAreaRange

				TREND_OccupiedHousesPos = TREND_OccupiedHousesPos + [_randBuildingPos];
				//hint format["test:%1",(_randBuilding distance getMarkerPos "mrkHQ")];
				//sleep 1;

				_thisGroup = nil;
				_thisGroup = createGroup _InsurgentSide;
				sRiflemanToUse createUnit [position _randBuilding, _thisGroup];
				if (selectRandom [true,false]) then {sRiflemanToUse createUnit [position _randBuilding, _thisGroup];};
					//HERE!!!! copy and paste the zen init script into a placed unig, then run and see if he is in building!!! (esc out of TRGM dialog)
				//sRiflemanToUse createUnit [position _randBuilding, _thisGroup, "[getPosATL this, units group this, 10, false, false] spawn TREND_fnc_Zen_OccupyHouse;"];

				_teamLeaderUnit = _thisGroup createUnit [sRiflemanToUse,_randBuildingPos,[],0,"NONE"];
				[_randBuildingPos, units group _teamLeaderUnit, -1, true, false,true] spawn TREND_fnc_Zen_OccupyHouse;



				_iCountNoOfCPs = selectRandom[0,0,0,0,1];  //number of checkpoints (so high chance of not being any, or one may be near an occupied building)
				if ((_sidePos distance _randBuilding) > 400) then {_iCountNoOfCPs = selectRandom[0,0,1];};
				//spawn inner random sentrys
				//if (!_bIsMainObjective) then {_iCountNoOfCPs = selectRandom [0,1];};
				if (_iCountNoOfCPs > 0) then {_dAngleAdustPerLoop = 360 / _iCountNoOfCPs;};
				while {_iCountNoOfCPs > 0} do {
					_thisAreaRange = 50;
					_checkPointGuidePos = _sidePos;
					_iCountNoOfCPs = _iCountNoOfCPs - 1;
					_flatPos = nil;
					_flatPos = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,TREND_CheckPointAreas + TREND_SentryAreas,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;


					if (_flatPos select 0 > 0) then {
						_thisPosAreaOfCheckpoint = _flatPos;
						_thisRoadOnly = false;
						_thisSide = east;
						_thisUnitTypes = [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sEngineerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse];
						_thisAllowBarakade = selectRandom [false];
						_thisIsDirectionAwayFromAO = true;
						[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,false,UnarmedScoutVehicles,50,false] spawn TREND_fnc_setCheckpoint;
					}
				};
			};
		};
		_iCount = _iCount + 1;
	};
};


true;