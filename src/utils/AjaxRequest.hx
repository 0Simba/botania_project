package utils;


class AjaxRequest
{
    static public function exec (type:String, datas:String = null, callback = null) {
        var url:String = "?action=" + type;
        if (datas != null) url += "&datas=" + StringTools.urlEncode(datas);

        var response = haxe.Json.parse(haxe.Http.requestUrl(url));

        displayAndLog(response);
        callback(response);
    }


    static private function displayAndLog (response) {
        var log = js.Browser.window.document.createElement("p");
        log.innerHTML = haxe.Json.stringify(response);
        js.Browser.window.document.body.appendChild(cast log);
    }
}
