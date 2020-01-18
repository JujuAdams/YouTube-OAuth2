/// @jujuadams 2020-01-18

if (global.__youtube_state != YOUTUBE_STATE.USER_CODE_PENDING)
{
    __youtube_error("Cannot poll device code, not in correct state");
    return -1;
}

var _string  = "client_id=" + global.__youtube_client_id;
    _string += "&client_secret=" + global.__youtube_client_secret;
    _string += "&code=" + string(global.__youtube_device_code);
    _string += "&grant_type=http://oauth.net/grant_type/device/1.0";

var _result = http_post_string("https://accounts.google.com/o/oauth2/token", _string);
__youtube_message("Sent HTTP POST to poll device code");

return _result;