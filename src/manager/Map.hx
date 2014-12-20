package manager;

import entities.Tile;

class Map
{

	private static var instance: Map;

	public var tiles:Array<Tile>;
	public var cols:Int;

	public function set (nbCols:Int, nbRows:Int): Void {
		if (isAlreadySet()) { return; };

		for (i in 0...nbCols * nbRows) {
			tiles[i] = new Tile();
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