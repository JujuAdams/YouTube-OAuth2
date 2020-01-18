/// This callback is executed once the authorisation flow has been completed. Completed doesn't necessarily mean successful!
/// 
/// @param YouTubeJSON  The JSON returned by YouTube after a query has completed. An empty ds_map indicates that an error occured

var _json = argument0; //Not used in this script

if (youtube_has_access_token())
{
    youtube_api_my_live_broadcasts(callback_get_livechatid);
}