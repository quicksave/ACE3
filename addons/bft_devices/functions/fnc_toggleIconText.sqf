/*
 * Author: Gundy
 *
 * Description:
 *   Toggle text next to BFT icons
 *
 * Arguments:
 *   0: Interface ID <STRING>
 *
 * Return Value:
 *   TRUE <BOOL>
 *
 * Example:
 *   ["interfaceID"] call ace_bft_devices_fnc_toggleIconText;
 *
 * Public: No
 */

#include "script_component.hpp"

private ["_interfaceID"];

_interfaceID = _this select 0;
if (GVAR(showBFTtext)) then {GVAR(showBFTtext) = false} else {GVAR(showBFTtext) = true};
[_interfaceID,[["showIconText",GVAR(showBFTtext)]]] call FUNC(setSettings);

true