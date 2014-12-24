package ;

class GameObject
{

    public var graphicTile:engine.isoEngine.components.Tile;
    public var hudElement:engine.isoEngine.components.Hud;

    public function new () {};

    public function addComponent (name:String) {
        if (name == "graphicTile") {
            graphicTile = new engine.isoEngine.components.Tile();
        }
        else if (name == "hudElement") {
            hudElement = new engine.isoEngine.components.Hud();
        }
    }
}