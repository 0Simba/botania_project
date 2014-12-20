package ;

/**
 * ...
 * @author Baptiser
 */
class GameObject
{

    // static public var GraphicTile:Class;
    public var graphicTile:engine.isoEngine.Tile;

	public function new()
	{
	}

    public function addComponent (name:String) {
        if (name == "graphicTile") {
            graphicTile = new engine.isoEngine.Tile();
        }
    }
}