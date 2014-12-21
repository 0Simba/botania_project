package manager;

import entities.Tile;

class Map
{

	private static var instance: Map;

	public var tiles:Array<Tile>;
	public var cols:Int;

	public function set (nbCols:Int, nbRows:Int): Void {
		if (isAlreadySet()) { return; };

		cols = nbCols;
		for (i in 0...nbCols * nbRows) {
			tiles[i] = new Tile();

            var x:Int = i % cols;
            var y:Int = Math.floor(i / cols);

			tiles[i].graphicTile.setPlace(x, y, i);
		}
	}

	public function fill (name:String) {
		for (i in 0...tiles.length) {
			tiles[i].graphicTile.addGround(name);
		}
	}




		/***** YOU DON'T CARE *****/
	static private var alreadySet:Bool;

	private function isAlreadySet():Bool {
		if (alreadySet) {
			trace("Le manager de la map à déjà été initialisé");
			return true;
		}

		alreadySet = true;
		return false;
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