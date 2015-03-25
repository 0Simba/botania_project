package utils;


class AjaxRequest
{
    static private var haveLog:Bool = false;
    static private var logDom:js.html.Element;

    static public function exec (type:String, datas:String = null, callback = null) {
        var url:String = "?action=" + type;
        if (datas != null) url += "&datas=" + StringTools.urlEncode(datas);

        var r = new haxe.Http(url);
        // r.onError = js.Lib.alert;
        r.onData = function (response) {
           //  displayAndLog(response);
            if (!phpErrorInString(response)) {
                callback(haxe.Json.parse(response));
            }
        }
        r.request(false);

    }

    static public function initLog () {
        haveLog   = true;

        var logContainer = js.Browser.window.document.createElement("div");
        logContainer.setAttribute("id", "ajaxRequestContainer");
        js.Browser.window.document.body.appendChild(logContainer);

        var clearButton = js.Browser.window.document.createElement("button");
        clearButton.textContent = "Clear";
        logContainer.appendChild(clearButton);

        logDom    = js.Browser.window.document.createElement("div");
        logDom.setAttribute("id", "ajaxRequestLog");
        logContainer.appendChild(logDom);

        clearButton.onclick = function (a) {
            logDom.innerHTML = "";
        }
    }

    static private function phpErrorInString (response) {
        var r = new EReg("<", "g");
        return r.match(response);
    }

    static private function displayAndLog (response) {
        if (!haveLog) return;

        var log = js.Browser.window.document.createElement("p");
        log.innerHTML = response;
        logDom.appendChild(cast log);
        trace("res");
        trace(response);
    }
}
