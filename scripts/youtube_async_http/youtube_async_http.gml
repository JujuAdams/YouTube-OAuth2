/// Place this script in the Async HTTP event of a persistent instance
/// 
/// @jujuadams 2020-01-18

var _http_status = async_load[? "http_status"];
var _status      = async_load[? "status"     ];
var _result      = async_load[? "result"     ];

if (_status == 0)
{
    if (_http_status == 200)
    {
        var _json = json_decode(_result);
        if (_json < 0)
        {
            __youtube_error("Could not decode response JSON, aborting");
        }
        else
        {
            switch(global.__youtube_state)
            {
                case YOUTUBE_STATE.DEVICE_CODE_PENDING:
                    global.__youtube_device_code      = _json[? "device_code"     ];
                    global.__youtube_user_code        = _json[? "user_code"       ];
                    global.__youtube_verification_url = _json[? "verification_url"];
                    global.__youtube_polling_interval = 1100*_json[? "interval"   ]; //Convert seconds to milliseconds, and poll slightly slower than is strictly necessary
                    global.__youtube_expires          = current_time + 900*_json[? "expires_in"]; //Convert seconds to milliseconds, and expire a bit early
                    global.__youtube_last_poll        = current_time;
                    
                    __youtube_message("Received device code \"", global.__youtube_device_code, "\", user code \"", global.__youtube_user_code, "\", expires ", global.__youtube_expires);
                    if (global.__youtube_user_code_to_clipboard) clipboard_set_text(global.__youtube_user_code);
                    url_open(global.__youtube_verification_url);
                    
                    global.__youtube_state = YOUTUBE_STATE.USER_CODE_PENDING;
                break;
                
                case YOUTUBE_STATE.EXCHANGING_AUTH_CODE:
                    global.__youtube_auth_code     = "";
                    global.__youtube_access_token  = _json[? "access_token"];
                    global.__youtube_token_type    = _json[? "token_type"  ];
                    global.__youtube_refresh_token = _json[? "refresh_token"];
                    global.__youtube_expires       = current_time + 900*_json[? "expires_in"]; //Convert seconds to milliseconds, and expire a bit early
                    global.__youtube_access_token_received = true;
                    
                    __youtube_message("Received access token \"", global.__youtube_access_token, "\", expires ", global.__youtube_expires);
                    __youtube_message("Ready to make requests!");
                    
                    global.__youtube_state = YOUTUBE_STATE.ACCESS_TOKEN_RECEIVED;
                    
                    if (script_exists(global.__youtube_callback)) script_execute(global.__youtube_callback, _json);
                break;
                
                case YOUTUBE_STATE.USER_CODE_PENDING:
                    if (ds_map_exists(_json, "error"))
                    {
                        __youtube_message("Polling error: ", _json[? "error"]);
                    }
                    else
                    {
                        global.__youtube_device_code   = "";
                        global.__youtube_access_token  = _json[? "access_token"];
                        global.__youtube_token_type    = _json[? "token_type"  ];
                        global.__youtube_refresh_token = _json[? "refresh_token"];
                        global.__youtube_expires       = current_time + 900*_json[? "expires_in"]; //Convert seconds to milliseconds, and expire a bit early
                        global.__youtube_access_token_received = true;
                        
                        __youtube_message("Received access token \"", global.__youtube_access_token, "\", expires ", global.__youtube_expires);
                        __youtube_message("Ready to make requests!");
                        
                        global.__youtube_state = YOUTUBE_STATE.ACCESS_TOKEN_RECEIVED;
                    }
                    
                    if (script_exists(global.__youtube_callback)) script_execute(global.__youtube_callback, _json);
                break;
                
                case YOUTUBE_STATE.REFRESHING_ACCESS_TOKEN:
                    global.__youtube_access_token = _json[? "access_token"];
                    global.__youtube_token_type   = _json[? "token_type"  ];
                    global.__youtube_expires      = current_time + 900*_json[? "expires_in"]; //Convert seconds to milliseconds, and expire a bit early
                    
                    __youtube_message("Received refreshed access token \"", global.__youtube_access_token, "\", expires ", global.__youtube_expires);
                    __youtube_message("Ready to make requests!");
                    
                    global.__youtube_state = YOUTUBE_STATE.ACCESS_TOKEN_RECEIVED;
                break;
                
                case YOUTUBE_STATE.OPERATION_PENDING:
                    __youtube_message("Operation complete");
                    global.__youtube_state = YOUTUBE_STATE.ACCESS_TOKEN_RECEIVED;
                    
                    if (script_exists(global.__youtube_callback)) script_execute(global.__youtube_callback, _json);
                break;
                
                default:
                    __youtube_message("Warning! Unexpected async HTTP event received");
                break;
            }
            
            ds_map_destroy(_json);
        }
    }
    else
    {
        __youtube_message(_result);
        __youtube_error("HTTP " + string(_http_status) + " received. Check output log for more details");
        
        //Ensure the localhost server is destroyed
        __youtube_server_destroy();
        
        if (global.__youtube_state == YOUTUBE_STATE.OPERATION_PENDING)
        {
            global.__youtube_state = YOUTUBE_STATE.ACCESS_TOKEN_RECEIVED;
        }
        else
        {
            global.__youtube_state = YOUTUBE_STATE.INITIALISED;
        }
        
        var _map = ds_map_create();
        if (script_exists(global.__youtube_callback)) script_execute(global.__youtube_callback, _map);
        ds_map_destroy(_map);
    }
}