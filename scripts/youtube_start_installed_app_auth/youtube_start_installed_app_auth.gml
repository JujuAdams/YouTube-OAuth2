/// Starts the "installed app" authorisation flow for YouTube with the given scope
/// See: https://developers.google.com/youtube/v3/live/guides/auth/installed-apps
/// 
/// This method requires a server to be opened on the local machine using the port defined by YOUTUBE_LOCALHOST_PORT
/// As a result, it may fail in situations where an aggressive firewall is in place
/// A web page is also opened to authenticate the user with Google/YouTube
/// 
/// @param authScope    API scope that the application requires. Check YOUTUBE_SCOPE for details
/// @param redirectURL  
/// @param callback     The script to call once authorisation has been granted or denied
/// 
/// @jujuadams 2020-01-18

//enum YOUTUBE_SCOPE
//{
//    READONLY,  //youtube.readonly              "View your YouTube account."
//    FORCE_SSL, //youtube.force-ssl             "Manage your YouTube account. Requires an SSL connection"
//    UPLOAD,    //youtube.upload                "Upload YouTube videos and manage your YouTube videos."
//    YOUTUBE,   //youtube                       "Manage your YouTube account. Functionally identical to youtube.force-ssl"
//    AUDIT,     //youtubepartner-channel-audit  "Retrieve the auditDetails part in a channel resource."
//}

if (global.__youtube_state != YOUTUBE_STATE.INITIALISED)
{
    __youtube_error("Cannot request access token again");
    return -1;
}

var _scope        = argument0;
var _redirect_url = argument1;
var _callback     = argument2;

switch(_scope)
{
    case YOUTUBE_SCOPE.READONLY:  var _scope = "https://www.googleapis.com/auth/youtube.readonly";             break;
    case YOUTUBE_SCOPE.FORCE_SSL: var _scope = "https://www.googleapis.com/auth/youtube.force-ssl";            break;
    case YOUTUBE_SCOPE.UPLOAD:    var _scope = "https://www.googleapis.com/auth/youtube.upload";               break;
    case YOUTUBE_SCOPE.YOUTUBE:   var _scope = "https://www.googleapis.com/auth/youtube";                      break;
    case YOUTUBE_SCOPE.AUDIT:     var _scope = "https://www.googleapis.com/auth/youtubepartner-channel-audit"; break;
    
    default:
        __youtube_error("Scope not recognised (", _scope, ")");
        return -1;
    break;
}

if (!__youtube_server_create()) return -2;

var _url  = "https://accounts.google.com/o/oauth2/auth?";
    _url += "client_id=" + global.__youtube_client_id;
    _url += "&redirect_uri=http://localhost:8888";
    _url += "&scope=" + _scope;
    _url += "&response_type=code";
url_open(_url);

global.__youtube_state        = YOUTUBE_STATE.INSTALLED_APP_PENDING;
global.__youtube_redirect_url = _redirect_url;
global.__youtube_callback     = _callback;
global.__youtube_expires      = current_time + YOUTUBE_LOCALHOST_TIMEOUT;

return 0;