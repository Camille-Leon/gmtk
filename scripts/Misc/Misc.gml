global.flip_flop = false;

function remap(_val, _from1, _to1, _from2, _to2) {
    return (_from2 + ((_to2 - _from2) / (_to1 - _from1)) * (_val - _from1));
}

function curve(_val1, _val2, _amount, _curvename, _curveindex) {
    return lerp(_val1, _val2, animcurve_channel_evaluate(animcurve_get_channel(_curvename, _curveindex), _amount))
}