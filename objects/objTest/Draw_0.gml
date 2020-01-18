//Draw the current status of the library to the screen
draw_text(10, 10, "livechatid = " + string(livechatid));

if (youtube_has_access_token())
{
    if (youtube_is_ready())
    {
        draw_text(10, 50, "Access token received, ready to make requests");
    }
    else if (youtube_is_pending())
    {
        draw_text(10, 50, "Operation pending");
    }
}
else switch(youtube_get_state())
{
    case YOUTUBE_STATE.INITIALISED:
        draw_text(10, 50, "Press <1> to begin authorisation using \"device\" flow");
        draw_text(10, 70, "Press <2> to begin authorisation using \"installed app\" flow");
    break;
    
    case YOUTUBE_STATE.USER_CODE_PENDING:
        draw_text(10, 50, "Enter user code into browser = " + youtube_get_user_code() + " (should be on your clipboard)");
        draw_text(10, 70, "(https://accounts.google.com/o/oauth2/device/usercode)");
        draw_text(10, 100, "Next refresh in " + string(global.__youtube_polling_interval - (current_time - global.__youtube_last_poll)) + "ms");
    break;
    
    case YOUTUBE_STATE.INSTALLED_APP_PENDING:
        draw_text(10, 50, "Waiting for response from web page");
    break;
}