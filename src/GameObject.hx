package ;

class GameObject
{

    public var graphicTile:engine.isoEngine.components.Tile;
    public var hudElement:engine.isoEngine.components.Hud;
    public var hudButton:engine.isoEngine.components.Button;
    public var text:engine.isoEngine.components.Text;

    public function new () {};

    public function addComponent (name:String) {
        if (name == "graphicTile") {
            graphicTile = new engine.isoEngine.components.Tile();
        }
        else if (name == "hudElement") {
            hudElement = new engine.isoEngine.components.Hud();
        }
        else if (name == "hudButton") {
            hudButton = new engine.isoEngine.components.Button();
        }
        else if (name == "text") {
            text = new engine.isoEngine.components.Text();
        }
        else {
            trace("GameObject.addComponent -> le component " + name + " n'existe pas");
        }
    }

    public function callServer (requestName:String, datas:Dynamic, acceptedCallback, refusedCallback) {
        utils.AjaxRequest.exec("buildBreaker", haxe.Json.stringify(datas), function (response) {
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
