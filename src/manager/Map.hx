package manager;

import entities.Tile;

class Map
{

	private static var instance: Map;

	public var tiles:Array<Tile>;
	public var cols:Int;


	static private var alreadySet:Bool;

	public function set (nbCols:Int, nbRows:Int): Void {
		if (alreadySet) {
			trace("Le manager de la map à déjà été initialisé");
			return;
		}
		alreadySet = true;

		for (i in 0...nbCols * nbRows) {
			tiles[i] = new Tile();
			tiles[i].addComponents("graphicTile");
		}
		cols = nbCols;
	}

	public function fill (name:String) {
		for (i in 0...tiles.length) {
            var x:Int = i % cols;
            var y:Int = Math.floor(i / cols);

			tiles[i].graphicTile.addGround(name);
			tiles[i].graphicTile.place(x, y);
		}
	}





	private function new()
	{
		tiles = new Array<Tile>();
		cols  = 0;
		alreadySet = false;
	}

	public static function getInstance (): Map {
		if (instance == null) instance = new Map();
		return instance;
	}

	public function destroy (): Void {
		instance = null;
	}

}