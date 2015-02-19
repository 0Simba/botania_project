package utils;


class AjaxRequest
{
    static public function exec (type:String, datas:haxe.Json = null, callback = null) {
        // var request = new haxe.Http("data.xml");
        // request.onError = js.Lib.alert;
        // request.onData = function(r) {
        //     setContent("main",r);
        // }
        // request.request(false);
        var request = haxe.Http.requestUrl("?action=test");
        trace("VALEURS DE RETOUR !");
        trace(request);
    }
}
