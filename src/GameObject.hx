package ;

class GameObject
{

    public var graphicTile:engine.isoEngine.components.Tile;
    public var hudElement:engine.isoEngine.components.Hud;
    public var hudButton:engine.isoEngine.components.Button;

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
        else {
            trace("GameObject.addComponent -> le component " + name + " n'existe pas");
        }
    }

    public function destroy () {
        trace("GameObject destroy -> empty");
        trace(this);
    }
}
