/// Returns the current operation state of the library, using the YOUTUBE_STATE enum
/// 
/// @jujuadams 2020-01-18

enum YOUTUBE_STATE
{
    INITIALISED,
    DEVICE_CODE_PENDING,
    INSTALLED_APP_PENDING,
    EXCHANGING_AUTH_CODE,
    USER_CODE_PENDING,
    ACCESS_TOKEN_RECEIVED,
    REFRESHING_ACCESS_TOKEN,
    OPERATION_PENDING,
}

return global.__youtube_state;