/*
 * Author: esteldunedain
 * Collect the temperature of all the spare barrels a unit has and load the
 * coolest on the unit weapon. Runs on the server.
 *
 * Argument:
 * 0: Unit <OBJECT>
 * 1: Weapon <STRING>
 * 2: Weapon temp before switching <NUMBER>
 * 3: Mass of the removed barrel <NUMBER>
 *
 * Return value:
 * None
 *
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", "_weapon", "_weaponTemp", "_barrelMass"];
TRACE_4("loadCoolestSpareBarrel1",_unit,_weapon,_weaponTemp,_barrelMass);

// Find all spare barrel the player has
private _allMags = magazinesDetail _unit;
TRACE_1("loadCoolestSpareBarrel2",_allMags);
_allMags = _allMags select {_x find "ACE Spare Barrel" == 0};
TRACE_1("loadCoolestSpareBarrel3",_allMags);
if ((count _allMags) < 1) exitWith {};

// Determine which on is coolest
private _coolestTemp = 10000;
private _coolestMag = _allMags select 0;
{
    private _temp = 0;
    if ([GVAR(storedSpareBarrels), _x] call CBA_fnc_hashHasKey) then {
        _temp = ([GVAR(storedSpareBarrels), _x] call CBA_fnc_hashGet) select 0;
    };
    TRACE_2("loadCoolestSpareBarrel4",_x,_temp);
    if (_temp < _coolestTemp) then {
        _coolestTemp = _temp;
        _coolestMag = _x;
    };
} forEach _allMags;
TRACE_3("loadCoolestSpareBarrel5",_coolestTemp,_coolestMag,_weaponTemp);

// The new weapon temperature is similar to the coolest barrel
// Publish the new temperature value
_unit setVariable [format [QGVAR(%1_temp), _weapon], _coolestTemp, true];

// Heat up the coolest barrel to the former weapon temperature
[GVAR(storedSpareBarrels), _coolestMag, [_weaponTemp, ACE_Time, _barrelMass]] call CBA_fnc_hashSet;