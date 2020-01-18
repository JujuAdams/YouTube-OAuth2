/// Returns whether the API is ready to attempt another query to the YouTube API
/// 
/// @jujuadams 2020-01-18

return ((global.__youtube_state == YOUTUBE_STATE.ACCESS_TOKEN_RECEIVED) && youtube_has_access_token());