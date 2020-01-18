/// @jujuadams 2020-01-18

if (global.__youtube_state != YOUTUBE_STATE.INSTALLED_APP_PENDING)
{
    __youtube_error("Cannot exchange authorisation code at this time");
    return -1;
}

var _string  = "code=" + global.__youtube_auth_code;
    _string += "&client_id=" + global.__youtube_client_id;
    _string += "&client_secret=" + global.__youtube_client_secret;
    _string += "&redirect_uri=http://localhost:" + string(YOUTUBE_LOCALHOST_PORT);
    _string += "&grant_type=authorization_code";
var _id = http_post_string("https://accounts.google.com/o/oauth2/token", _string);

__youtube_message("Exchanging authorisation code for access token");

global.__youtube_state = YOUTUBE_STATE.EXCHANGING_AUTH_CODE;

return 0;