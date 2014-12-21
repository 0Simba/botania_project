package ;

/**
 * ...
 * @author Jaf
 */
class GameObject
{

    public var graphicTile:engine.isoEngine.Tile;
    public var interactiveTile:engine.isoEngine.InteractiveTile;

    public function new () {};

    public function addComponent (name:String) {
        if (name == "graphicTile") {
            graphicTile = new engine.isoEngine.Tile();
        }
        else if (name == "interactiveTile") {
            interactiveTile = new engine.isoEngine.InteractiveTile();
        }
    }
}