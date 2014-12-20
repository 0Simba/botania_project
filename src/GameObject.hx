package ;

/**
 * ...
 * @author Jaf
 */
class GameObject
{

    // static public var GraphicTile:Class;
    public var graphicTile:engine.isoEngine.Tile;

    // static private var components:Map<String, Class<Void>>;


    public function new () {};

    public function addComponent (name:String) {
        if (name == "graphicTile") {
            graphicTile = new engine.isoEngine.Tile();
        }
    }
}