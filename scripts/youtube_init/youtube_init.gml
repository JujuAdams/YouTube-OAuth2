/// Initialises the YouTube library
/// You can find clientID and clientSecret via the Credentials page on Google's backend:
/// https://console.developers.google.com/apis/credentials
///
/// @param clientID                 Provided by Google
/// @param clientSecret             Provided by Google
/// @param copyUserCodeToClipboard  (bool) Whether to copy the user code to the clipboard when opening the authorisation web page
/// 
/// @jujuadams 2020-01-18

show_debug_message("Welcome to the YouTube library by @jujuadams! v" + __YOUTUBE_VERSION + " " + __YOUTUBE_DATE);

if (!code_is_compiled() && !YOUTUBE_IGNORE_YYC_WARNING)
{
    __youtube_error("It's very easy to extract strings from GameMaker VM builds.\nPlease use YYC to build games for public release.");
}

global.__youtube_client_id              = argument0;
global.__youtube_client_secret          = argument1;
global.__youtube_user_code_to_clipboard = argument2;

global.__youtube_state                 = YOUTUBE_STATE.INITIALISED;
global.__youtube_user_code             = "";
global.__youtube_access_token_received = false;
global.__youtube_callback              = -1;
global.__youtube_localhost_server      = -1;

enum YOUTUBE_SCOPE
{
    READONLY,  //youtube.readonly              "View your YouTube account."
    FORCE_SSL, //youtube.force-ssl             "Manage your YouTube account. Requires an SSL connection"
    UPLOAD,    //youtube.upload                "Upload YouTube videos and manage your YouTube videos."
    YOUTUBE,   //youtube                       "Manage your YouTube account. Functionally identical to youtube.force-ssl"
    AUDIT,     //youtubepartner-channel-audit  "Retrieve the auditDetails part in a channel resource."
}

#macro __YOUTUBE_VERSION  "1.0.0"
#macro __YOUTUBE_DATE     "2020/01/18"