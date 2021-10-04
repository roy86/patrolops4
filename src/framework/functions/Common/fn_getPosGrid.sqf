/*
    Author: Grumpy Old Man
*/
params ["_grid"];

private _count = count _grid;
private _banana = _count / 2;
private _multis = [1,10,100];
private _counts = [10,8,6];

private _multi = _multis select (_counts find _count);

private _posX = (parseNumber (_grid select [0,_banana])) * _multi;
private _posY = (parseNumber (_grid select [_banana,_banana + _banana])) * _multi;

[_posX,_posY,0]