/*
 * Author: Jonpas
 * Adds custom tag. Has to be executed on one machine only.
 *
 * Arguments:
 * 0: Unique Identifier <STRING>
 * 1: Display Name <STRING>
 * 2: Required Item <STRING>
 * 3: Textures Paths <ARRAY>
 * 4: Icon Path <STRING> (default: "")
 *
 * Return Value:
 * Sucessfully Added Tag <BOOL>
 *
 * Example:
 * ["ace_victoryRed", "Victory Red", "ACE_SpraypaintRed", ["path\to\texture1.paa", "path\to\texture2.paa"], "path\to\icon.paa"] call ace_tagging_fnc_addCustomTag
 *
 * Public: Yes
 */
#include "script_component.hpp"

params [
    ["_identifier", "", [""]],
    ["_displayName", "", [""]],
    ["_requiredItem", "", [""]],
    ["_textures", [], [[]]],
    ["_icon", "", [""]]
];

// Verify
if (_identifier == "") exitWith {
    ACE_LOGERROR("Failed adding custom tag - missing identifier");
};

if (_displayName == "") exitWith {
    ACE_LOGERROR_1("Failed adding custom tag: %1 - missing displayName",_identifier);
};

if (_requiredItem == "") exitWith {
    ACE_LOGERROR_1("Failed adding custom tag: %1 - missing requiredItem",_identifier);
};
if (!isClass (configFile >> "CfgWeapons" >> _requiredItem)) exitWith {
    ACE_LOGERROR_2("Failed adding custom tag: %1 - requiredItem %2 does not exist",_identifier,_requiredItem);
};

if (_textures isEqualTo []) exitWith {
    ACE_LOGERROR_1("Failed adding custom tag: %1 - missing textures",_identifier);
};

_identifier = [_identifier] call EFUNC(common,stringRemoveWhiteSpace);
_requiredItem = toLower _requiredItem;

// Add
[QGVAR(applyCustomTag), [_identifier, _displayName, _requiredItem, _textures, _icon]] call CBA_fnc_globalEventJIP;
