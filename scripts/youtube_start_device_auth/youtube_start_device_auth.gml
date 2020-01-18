/// Starts the "device" authorisation flow for YouTube with the given scope
/// See: https://developers.google.com/youtube/v3/live/guides/auth/devices
/// 
/// This method requires that the user inputs a passcode into a web page
/// It's inelegant but more robust than the "installed app" flow
/// 
/// @param authScope  API scope that the application requires. Check YOUTUBE_SCOPE for details
/// @param callback   The script to call once authorisation has been granted or denied
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

var _scope    = argument0;
var _callback = argument1;

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

var _string  = "client_id=" + global.__youtube_client_id;
    _string += "&scope=" + _scope;
var _id = http_post_string("https://accounts.google.com/o/oauth2/device/code", _string);

__youtube_message("Sent HTTP POST to request device code");

global.__youtube_state    = YOUTUBE_STATE.DEVICE_CODE_PENDING;
global.__youtube_callback = _callback;

return _id;