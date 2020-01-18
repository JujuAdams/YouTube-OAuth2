/// This callback is executed once the live broadcast query has been returned
/// 
/// @param YouTubeJSON  The JSON returned by YouTube after a query has completed. An empty ds_map indicates that an error occured

var _json = argument0;

//Spit out the JSON so we can see what's what
show_debug_message(json_encode(_json));

livechatid = "???";

var _items = _json[? "items"];
if (_items == undefined)
{
    show_error("Could not find \"items\" in returned JSON\n ", false);
    exit;
}

var _broadcast = _items[| 0];
if (_broadcast == undefined)
{
    show_error("Could not find broadcast=0 in returned JSON\n ", false);
    exit;
}

var _snippet = _broadcast[? "snippet"];
if (_broadcast == undefined)
{
    show_error("Could not find snippet for broadcast in returned JSON\n ", false);
    exit;
}

var _livechatid = _snippet[? "liveChatId"];
if (_livechatid == undefined)
{
    show_error("Could not find liveChatId for snippet in returned JSON\n ", false);
    exit;
}

livechatid = _livechatid;
show_message(livechatid);