package utils;


class AjaxRequest
{
    static public function exec (type:String, datas:haxe.Json = null, callback = null) {
        var url:String = "?action=" + type;
        if (datas != null) url += "&datas=" + datas;
        var request = haxe.Http.requestUrl("?action=test");
    }
}
