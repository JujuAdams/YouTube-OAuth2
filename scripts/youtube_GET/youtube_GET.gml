/// Queries an endpoint for the Google YouTube Data v3 API
/// See: https://developers.google.com/youtube/v3/
/// 
/// @param url       The API endpoint to query
/// @param callback  A script to call when the async event is returned
/// 
/// @jujuadams 2020-01-18

if (!youtube_is_ready())
{
    __youtube_error("Cannot begin operation, library isn't ready");
    return -1;
}

var _url      = argument0;
var _callback = argument1;

var _header_map = ds_map_create();
_header_map[? "Authorization"] = global.__youtube_token_type + " " + global.__youtube_access_token;

var _result = http_request(_url, "GET", _header_map, "");

ds_map_destroy(_header_map);

global.__youtube_state    = YOUTUBE_STATE.OPERATION_PENDING;
global.__youtube_callback = _callback;

return _result;