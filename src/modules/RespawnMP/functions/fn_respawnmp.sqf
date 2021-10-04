/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-01-05
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
    case "getRespawnPositions" : {
		_params params [["_target",player,[objNull,grpNull,sideUnknown,missionNamespace]]];

		private _sideTarget = switch (typeName _target) do {
			case (typeName objNull);
			case (typeName grpNull): { _target call BIS_fnc_objectSide };
			case (typeName sideUnknown): { _target };
			default { player call BIS_fnc_objectSide };
		};

        private _respawnPositions = [];
        private _respawnMarkers = [_sideTarget] call BIS_fnc_getRespawnMarkers;
        {
            private _respawnName = markerText _x;
            if (_respawnName isEqualTo "") then { _respawnName = format ["Grid #%1",mapGridPosition (_x call BIS_fnc_position)]; };
            _respawnPositions pushBack [_x,_respawnName,false];
        } forEach _respawnMarkers;

        // BIS Positions
        private _respawnPositionsArray = [_target] call BIS_fnc_getRespawnPositions;
        private _respawnPositionsNames = [_target,1] call BIS_fnc_getRespawnPositions;
        {
            private _respawnName = switch (true) do {
                case !((_respawnPositionsNames select _forEachIndex) isEqualTo "") : { _respawnPositionsNames select _forEachIndex; };
                case (["isMHQdeployed",[_x,false]] call MPSF_fnc_mhq) : { format ["MHQ %1 %2",([_x] call MPSF_fnc_getCfgText),"(Deployed)"]; };
                case (_x isEqualType objNull) : { format ["%1",([_x] call MPSF_fnc_getCfgText)]; };
                case (_x isEqualType grpNull) : { format ["%1 (%2)",groupID _x,name leader _x]; };
                default { format ["Grid #%1 %2",mapGridPosition (_x call BIS_fnc_position),typeName _x]; };
            };
            _respawnPositions pushBack [
                _x
                ,_respawnName
                ,if (_x isEqualType []) then {(_x select 2 > 1000)} else {false}
            ];
        } forEach _respawnPositionsArray;

        _respawnPositions;
    };
	case "setPosition" : {
		_params params [["_target",objNull,[objNull]],["_position",[0,0,0],[[],objNull,grpNull,""]],["_halo",false,[false]]];

		if (isNull _target) exitWith {false};

		switch (true) do {
			case (_position isEqualType objNull) : { _position = vehicle _position };
			case (_position isEqualType grpNull) : { _position = leader _position };
		};

		if (_position isEqualTo [0,0,0]) exitWith {false};

		switch (true) do {
			case (_position isEqualType objNull) : {
				// Move to Leader/Vehicle
				if !(locked _position > 1) then {
					if (_target moveInAny _position) exitWith {true};
				};

				private _zPos = (ASLToAGL getPosASL _position) select 2;
				private _bb = boundingBox _position;
				private _moveDirectionSelect = speed _position < 0 && !(_position isKindOf "CAManBase");

				if (_zPos >= 50) exitWith {
					private _spawnPos = _position modelToWorldVisual [5/2 - random 5,(_bb select _moveDirectionSelect select 1),(_bb select 0 select 2) * 1.25];
					if (_spawnPos isEqualTo [0,0,0]) exitWith {false};
					isNil {
						private _para = createVehicle ["Steerable_Parachute_F", _spawnPos, [], 0, "CAN_COLLIDE"];
						_para setDir (_para getDir _position);
						_target moveInDriver _para;
						_para setVelocity velocity _position;
					};
					true
				};

				//--- vehicle is on the ground, move next to it
				private _offset = (getPos _position distance getPosVisual _position) + 1.5;
				private _spawnPos = (_position getRelPos [ //--- get spawn position now, to make it more robust in scheduled
					(_bb select _moveDirectionSelect select 1)
					+
					([-_offset, _offset] select _moveDirectionSelect), //--- avoid appearing in front of a moving vehicle
					linearConversion [0, 100, round random 100, -15, 15]
				]) vectorAdd [0, 0, _zPos];

				if (isNil "_spawnPos" || {_spawnPos isEqualTo [0,0,0]}) exitWith {false};

				_target setVehiclePosition [_spawnPos, [], 0, "NONE"];
				_target setDir (_target getDir _position);

				true
			};
			case (_position isEqualType "") : {
				if !(isNull (missionNamespace getVariable [_position,objNull])) exitWith {
					["setPosition",[_target,missionNamespace getVariable [_position,objNull],_halo]] call MPSF_fnc_respawnMP;
				};
				private _markerPos = markerPos _position;
				if (_markerPos isEqualTo [0,0,0]) exitWith {};
				markerSize _position params ["_markerX", "_markerY"];
				_target setDir markerDir _position;
				_target setVehiclePosition [_markerPos, [], (_markerX * _markerY) / 2, "NONE"];
				true
			};
			case (_position isEqualTypeArray [0,0,0]) : {
				switch (true) do {
					case (_position select 2 >= 500) : {
						[_target,_position,(_position select 2)] call MPSF_fnc_respawnHALO;
					};
					case (_position select 2 >= 50) : {
						isNil {
							private _para = createVehicle ["Steerable_Parachute_F",_position,[],0,"CAN_COLLIDE"];
							_para setDir getDir _target;
							_target moveInDriver _para;
							true
						};
						_target setPosASL AGLToASL _position;
					};
					default {
						_target setPosASL AGLToASL _position;
					};
				};
				true
			};
		};

		(missionNamespace getVariable ["MPSF_itemAmrelTablet_var_respawnMPSelectedPosition",[]]) params [["_selectedTarget",objNull,[objNull,"",[]]],["_selectedName","",[""]],["_selectedHalo",false,[false]]];

		//[_selectedName,format ["%1",name player],mapGridPosition player] spawn BIS_fnc_infoText;
		[
			[
				[_selectedName, "<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t>"],
				[mapGridPosition player, "<t align = 'center' shadow = '1' size = '0.7'>GRID %1</t><br/>"],
				[format ["%1",name player], "<t align = 'center' shadow = '1' size = '1.0'>%1</t>", 15]
			]
		] spawn BIS_fnc_typeText;

		true;
	};
// Trigger
	case "createAction" : {
		_params params [["_logic",objNull,[objNull]]];

		if (isNull _logic) exitWith {};
		if !(isNull (_logic getVariable ["MPSF_RespawnMP_Trigger",objNull])) exitWith {};

		if (hasInterface) then {
			private _trigger = createTrigger ["EmptyDetector",_logic,false];
			_trigger setTriggerArea [4,4,getDir _logic,false];
			_trigger setTriggerActivation ["ANYPLAYER","PRESENT",true];
			_trigger setTriggerStatements ["(vehicle player) in thisList"
				,format["['activateAction',[thisTrigger,thisList]] call MPSF_fnc_RespawnMP;"]
				,format["['deactivateAction',[thisTrigger]] call MPSF_fnc_RespawnMP;"]
			];
			_trigger attachTo [_logic,[0,0,0]];
			_logic setVariable ["MPSF_RespawnMP_Trigger",_trigger];
		};
	};
	case "activateAction" : {
		_params params [["_trigger",objNull],["_list",[],[[]]]];

		if !((vehicle player) in _list) exitWith {};

		private _logic = attachedTo _trigger;
		["MPSF_RespawnMP_Action",vehicle player,format["Redeploy %1",if (vehicle player isEqualTo player) then {"Soldier"} else {[vehicle player] call MPSF_fnc_getCfgText}],[
			["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
			,["\A3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",{}]
			,{ ([] call BIS_fnc_displayMission) createDisplay "RscDisplayRespawnMPMenu"; }
			,{}
			,0.5,false,101
		],[],"speed vehicle player isEqualTo 0 && (vehicle player isEqualTo player || driver vehicle player isEqualTo player)"
		,true] spawn {sleep 0.1; _this call MPSF_fnc_addAction;};
	};
	case "deactivateAction" : {
		["MPSF_RespawnMP_Action",vehicle player] call MPSF_fnc_removeAction;
	};
// Init
	case "init" : {
		_params params [["_logic",objNull,[objNull,[]]]];
		["createAction",[_logic]] call MPSF_fnc_RespawnMP;
	};
    case "postInit" : {
		_params spawn {
			waitUntil {!isNull player};
			["postInit"] call MPSF_fnc_mhq;
            ["postInit"] call MPSF_fnc_rallypoint;
		};

		["MPSF_Framework_Note","Features","Redeployment"
			,format["<font size='16' face='PuristaLight'>Redeployment Options</font><br/><img image='#(argb,8,8,3)color(1,1,1,0.1)' height='1' width='640' /><br/>%1<br/><br/>%2<br/><br/>%3<br/><br/>%4"
			,"The virtual depot is availble to request new vehicles that can be deployed to the AO with customisation. SImply walk up to a Vehicle Depot and access the menu to begin the selection and customisation process."
			,"Vehicles are seporated by type on the left side of the screen and customisation with loadouts on the right."
			,if (["getCfgCompatiblePylons"] call MPSF_fnc_virtualDepot) then {
				"The available ordinance to choose from is set to be limited by the compatibility of the selected hardpoints on the vehicle. You must equip the compatibile ordinance with the selected pylon."
			} else {
				"The available ordinance to choose from is NOT limited by the compatibility of the selected hardpoints on the vehicle. You can equip any ordinance to any pylon desired."
			}
			,if (["getCfgDepotPylonInteraction"] call MPSF_fnc_virtualDepot) then {
				"To access the ordinance selection, walk up to the vehicle and select 'SERVICE VEHICLE' to begin the process. Then walk to each pylon to set the ordinance type before then loading the ordinance onto the pylon. This is a slow process to replicate the procedures of loading a vehicle or aircraft with ordinance."
			} else {
				"To access the ordinance selection, stay in the interface, select a pylon on the aircraft, then access the ordinance option from the menu on the right side of the screen. Setting of ordinance is instant with no delay."
			}
		]] spawn {_this call (missionNamespace getVariable ["MPSF_fnc_createDiaryNote",{false}])};

        ["MPSF_RespawnMP_onRedeploy_EH","onRedeploy",{
            _this spawn {
                params [["_units",[],[[]]],["_position",objNull,[objNull,"",[]]],["_instant",false,[false]]];

                if ({local _x} count _units == 0) exitWith {};

                if (player in _units) then {
                    if (_instant) then {
                        ["#(argb,8,8,3)color(1,1,1,1)",false,nil,0,[0,0.5]] call BIS_fnc_textTiles;
                    } else {
                        ["MPSF_Respawn_displayTransition",true,1] call BIS_fnc_blackOut;
                        uiSleep 2;
                    };
                };

                private _centerPos = _position call BIS_fnc_position;
                {
                    private _target = _x;
                    if (local _target) then {
                        switch (true) do {
                            case (_position isEqualType []) : {
                                private _movePos = _centerPos getPos [5 * _forEachIndex,5 * _forEachIndex];
                                _movePos set [2,(_position select 2)];
                                ["setPosition",[_target,_movePos]] call MPSF_fnc_respawnMP;
                            };
                            case !(_target isKindOf "CaManBase") : {
                                ["setPosition",[_target,_position call BIS_fnc_position]] call MPSF_fnc_respawnMP;
                            };
                            default {
                                ["setPosition",[_target,_position]] call MPSF_fnc_respawnMP;
                            };
                        };
                    };
                } forEach _units;

                if (player in _units) then {
                    // Radio Support
                    ["setRadioState",[player,true]] call MPSF_fnc_respawnMP;
                    if (_instant) then {} else {
                        uiSleep 2;
                        ["MPSF_Respawn_displayTransition",true,1] call BIS_fnc_blackIn;
                    };
                };
            };
        }] call MPSF_fnc_addEventHandler;
    };
};
