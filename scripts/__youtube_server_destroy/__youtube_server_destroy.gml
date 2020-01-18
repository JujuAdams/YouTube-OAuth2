/// @jujuadams 2020-01-18

if (global.__youtube_localhost_server >= 0)
{
    __youtube_message("Shutting server ", global.__youtube_localhost_server);
    network_destroy(global.__youtube_localhost_server);
    global.__youtube_localhost_server = -1;
}