/// Place this script in the Step event of a persistent instance
/// 
/// @jujuadams 2020-01-18

switch(global.__youtube_state)
{
    case YOUTUBE_STATE.USER_CODE_PENDING:
        if (current_time > global.__youtube_last_poll + global.__youtube_polling_interval)
        {
            __youtube_poll_device_code();
            global.__youtube_last_poll = current_time;
        }
        
        if (current_time > global.__youtube_expires)
        {
            __youtube_error("User code expired");
            __youtube_reset(true);
        }
    break;
    
    case YOUTUBE_STATE.INSTALLED_APP_PENDING:
    case YOUTUBE_STATE.EXCHANGING_AUTH_CODE:
        if (current_time > global.__youtube_expires)
        {
            __youtube_error("Authorisation flow expired");
            __youtube_reset(true);
        }
    break;
    
    case YOUTUBE_STATE.ACCESS_TOKEN_RECEIVED:
        if (current_time > global.__youtube_expires) __youtube_refresh_access_token();
    break;
    
    case YOUTUBE_STATE.OPERATION_PENDING:
    break;
}