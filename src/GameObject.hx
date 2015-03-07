package ;

class GameObject
{

    public function new () {}

    public function callServer (requestName:String, datas:Dynamic, acceptedCallback, refusedCallback) {
        utils.AjaxRequest.exec(requestName, haxe.Json.stringify(datas), function (response) {
            if (response.accepted) {
                acceptedCallback(response);
            }
            else {
                refusedCallback(response);
            }
        });
    }

    public function destroy () {
        trace("GameObject destroy -> empty");
        trace(this);
    }
}
