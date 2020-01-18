/// Place this script in the Async Networking event of a persistent instance
/// 
/// @jujuadams 2020-01-18

switch(async_load[? "type"])
{
    case network_type_connect:
        global.__youtube_out_socket = async_load[? "socket"];
        __youtube_message("New connection on socket ", global.__youtube_out_socket);
    break;
    
    case network_type_data:
        var _buffer = async_load[? "buffer"];
        if (_buffer != undefined)
        {
            var _string = buffer_read(_buffer, buffer_string);
            var _a = string_pos("?code=", _string);
            var _b = string_pos("&scope=", _string);
            
            if ((_a <= 0) || (_b <= 0))
            {
                show_debug_message(_string);
            }
            else
            {
                global.__youtube_auth_code = string_copy(_string, _a+6, _b - (_a+6));
                __youtube_message("Received authorisation code \"", global.__youtube_auth_code, "\"");
                __youtube_exchange_auth_code();
            }
            
            if (global.__youtube_localhost_server >= 0)
            {
                __youtube_message("Sending raw HTTP response");
                
                var _string = "HTTP/1.1 301 Moved Permanently\nLocation: " + global.__youtube_redirect_url + "\n\n";
                
                var _out_buffer = buffer_create(string_byte_length(_string)+1, buffer_fixed, 1);
                buffer_write(_out_buffer, buffer_string, _string);
                
                network_send_raw(global.__youtube_out_socket, _out_buffer, buffer_get_size(_out_buffer));
                buffer_delete(_out_buffer);
            }
            
            __youtube_server_destroy();
        }
    break;
}