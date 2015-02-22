package utils;


class AjaxRequest
{
    static public function exec (type:String, datas:String = null, callback = null) {
        var url:String = "?action=" + type;
        if (datas != null) url += "&datas=" + StringTools.urlEncode(datas);

        var r = new haxe.Http(url);
        // r.onError = js.Lib.alert;
        r.onData = function (response) {
            displayAndLog(response);
            if (!phpErrorInString(response)) {
                callback(haxe.Json.parse(response));
            }
        }
        r.request(false);

    }


    static private function phpErrorInString (response) {
        var r = new EReg("<font", "g");
        return r.match(response);
    }

    static private function displayAndLog (response) {
        var log = js.Browser.window.document.createElement("p");
        log.innerHTML = response;
        js.Browser.window.document.body.appendChild(cast log);
        // trace(response);
    }
}
