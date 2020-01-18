/// Retrieves details about the user's live broadcasts, then passes that data to the callback script
/// 
/// @param callback  A script to call when the async event is returned
/// 
/// @jujuadams 2020-01-18

return youtube_GET("https://www.googleapis.com/youtube/v3/liveBroadcasts?part=id&mine=true", argument0);