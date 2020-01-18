//Set up a variable to store our livechatid in
livechatid = "???";

//Initialise the YouTube library
//The client ID and client secret shouldn't be shared with other people!
//Since it's pretty easy to extract strings from VM binaries, please export your game using YYC if you're using this library
youtube_init("clientID",
             "clientSecret",
             true); //Copy the returned user code to the clipboard to make life easier