if (keyboard_check_pressed(ord("1")))
{
    //Start the "device" authorisation flow, see: https://developers.google.com/youtube/v3/live/guides/auth/devices
    //We call get_live_broadcasts() once we're authorised
    youtube_start_device_auth(YOUTUBE_SCOPE.READONLY, callback_get_live_broadcasts);
}

if (keyboard_check_pressed(ord("2")))
{
    //Start the "installed app" authorisation flow, see: https://developers.google.com/youtube/v3/live/guides/auth/installed-apps
    //We call get_live_broadcasts() once we're authorised
    youtube_start_installed_app_auth(YOUTUBE_SCOPE.READONLY, "http://www.jujuadams.com/", callback_get_live_broadcasts);
}

//Run some update logic. This keeps access tokens active etc.
youtube_step();