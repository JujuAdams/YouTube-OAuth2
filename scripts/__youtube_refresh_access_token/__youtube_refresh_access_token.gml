/// @jujuadams 2020-01-18

if (global.__youtube_state != YOUTUBE_STATE.ACCESS_TOKEN_RECEIVED)
{
    __youtube_error("Cannot refresh access token right now");
    return -1;
}

var _string  = "client_id=" + global.__youtube_client_id;
    _string += "&client_secret=" + global.__youtube_client_secret;
    _string += "&refresh_token=" + global.__youtube_refresh_token;
    _string += "&grant_type=refresh_token";
var _id = http_post_string("https://accounts.google.com/o/oauth2/token", _string);

__youtube_message("Sent HTTP POST to refresh access token");

global.__youtube_state    = YOUTUBE_STATE.REFRESHING_ACCESS_TOKEN;
global.__youtube_callback = -1;

return _id;