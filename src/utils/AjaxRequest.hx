package utils;


class AjaxRequest
{
    static public function exec (type:String, datas:String = null, callback = null) {
        var url:String = "?action=" + type;
        if (datas != null) url += "&datas=" + StringTools.urlEncode(datas);

        var response = haxe.Http.requestUrl(url);

        trace(response);
    }
}
