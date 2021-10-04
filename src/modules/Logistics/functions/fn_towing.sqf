/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2019-03-18
    
    Description:
        Sourced solution fom Advanded Towing by Seth Duda, rewritten and optimised for the MSPF framework
*/

#define ROPEMAXDIST 20			

params [["_mode","",[""]],["_params",[],[[],false]]];

switch (_mode) do {
	case "getCornerPoints" : {
		_params params [["_vehicle",objNull,[objNull]]];

		private _widthFactor = 0.75;
		private _lengthFactor = 0.75;
		if(_vehicle isKindOf "Air") then {
			_widthFactor = 0.3;
		};
		if(_vehicle isKindOf "Helicopter") then {
			_widthFactor = 0.2;
			_lengthFactor = 0.45;
		};
		
		private _centerOfMass = getCenterOfMass _vehicle;
		private _bbr = boundingBoxReal _vehicle;
		private _p1 = _bbr select 0;
		private _p2 = _bbr select 1;
		private _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
		private _widthOffset = ((_maxWidth / 2) - abs ( _centerOfMass select 0 )) * _widthFactor;
		private _maxLength = abs ((_p2 select 1) - (_p1 select 1));
		private _lengthOffset = ((_maxLength / 2) - abs (_centerOfMass select 1 )) * _lengthFactor;
		private _rearCorner = [(_centerOfMass select 0) + _widthOffset, (_centerOfMass select 1) - _lengthOffset, _centerOfMass select 2];
		private _rearCorner2 = [(_centerOfMass select 0) - _widthOffset, (_centerOfMass select 1) - _lengthOffset, _centerOfMass select 2];
		private _frontCorner = [(_centerOfMass select 0) + _widthOffset, (_centerOfMass select 1) + _lengthOffset, _centerOfMass select 2];
		private _frontCorner2 = [(_centerOfMass select 0) - _widthOffset, (_centerOfMass select 1) + _lengthOffset, _centerOfMass select 2];
				
		[_rearCorner,_rearCorner2,_frontCorner,_frontCorner2];
	};
	case "getRopePoints" : {
		_params params [["_vehicle",objNull,[objNull]]];

		private _cornerPoints = ["getCornerPoints",[_vehicle]] call MPSF_fnc_towing;
		_cornerPoints params ["_rearCorner","_rearCorner2","_frontCorner","_frontCorner2"];

		private _rearHitchPoint = ((_rearCorner vectorDiff _rearCorner2) vectorMultiply 0.5) vectorAdd  _rearCorner2;
		private _frontHitchPoint = ((_frontCorner vectorDiff _frontCorner2) vectorMultiply 0.5) vectorAdd  _frontCorner2;

		[_frontHitchPoint,_rearHitchPoint];
	};
	case "attachRopes" : {
		_params params [["_vehicle",objNull,[objNull]],["_target",objNull,[objNull]]];

		if !(isNull _vehicle) then {

			if(local _vehicle) then {
				private _cargoHitch = (["getRopePoints",[_target]] call MPSF_fnc_towing) param [0,[0,0,0]];
				private _vehicleHitch = (["getRopePoints",[_vehicle]] call MPSF_fnc_towing) param [1,[0,0,0]];
				private _objDistance = ((_vehicle modelToWorld _vehicleHitch) distance (_target modelToWorld _cargoHitch));

				if(_objDistance > ROPEMAXDIST) then {
					["The tow ropes are too short. Move vehicle closer."] call BIS_fnc_error;
				} else {		
					ropeCreate [_vehicle,_vehicleHitch,_target,_cargoHitch,_objDistance];
					["monitorRopes",[_vehicle,_vehicleHitch,_target,_cargoHitch,_objDistance]] call MPSF_fnc_towing;
					player customChat [missionNamespace getVariable ["MPSF_Radio_channelID",-1],format ["%1 attached to %2",[_target] call MPSF_fnc_getCfgText,[_vehicle] call MPSF_fnc_getCfgText]];
				};
			};

		};
	};
	case "monitorRopes" : {
	};
	case "init" : {};
};