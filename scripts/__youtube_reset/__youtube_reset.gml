/// @param executeCallback

var _execute_callback = argument0;

if (_execute_callback && script_exists(global.__youtube_callback))
{
    var _map = ds_map_create();
    script_execute(global.__youtube_callback, _map);
    ds_map_destroy(_map);
}

__youtube_server_destroy();

global.__youtube_state                 = YOUTUBE_STATE.INITIALISED;
global.__youtube_callback              = -1;
global.__youtube_user_code             = "";
global.__youtube_access_token_received = false;
global.__youtube_expires               = -1;