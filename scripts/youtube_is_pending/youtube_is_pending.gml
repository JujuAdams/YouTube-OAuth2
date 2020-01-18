/// Returns whether the library is currently performing an API endpoint query
/// A result of <false> doesn't necessarily mean the library is ready to make a query, please us youtube_is_read() for that
/// 
/// @jujuadams 2020-01-18

return ((global.__youtube_state == YOUTUBE_STATE.OPERATION_PENDING) && youtube_has_access_token());