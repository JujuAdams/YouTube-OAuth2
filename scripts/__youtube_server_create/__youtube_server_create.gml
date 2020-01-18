/// @jujuadams 2020-01-18

if (global.__youtube_localhost_server < 0)
{
    global.__youtube_localhost_server = network_create_server_raw(network_socket_tcp, YOUTUBE_LOCALHOST_PORT, 10);
}

if (global.__youtube_localhost_server < 0)
{
    __youtube_error("Failed to create raw TCP server on port ", YOUTUBE_LOCALHOST_PORT);
    return false;
}

__youtube_message("Opened server ", global.__youtube_localhost_server, " on port ", YOUTUBE_LOCALHOST_PORT);
return true;