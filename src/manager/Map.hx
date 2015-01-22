package manager;

import entities.Tile;
import engine.isoEngine.IsoEngine;
import utils.ArrayCoord;

class Map
{

	private static var instance: Map;

	public var tiles:Array<Tile>;

	public function set (nbCols:Int, nbRows:Int): Void {
		if (isAlreadySet()) { return; };

		addLayer(nbRows + nbCols);

		for (i in 0...nbCols * nbRows) {
            var x:Int = i % nbCols;
            var y:Int = Math.floor(i / nbCols);

			tiles[i] = new Tile(new ArrayCoord(x, y, i));

			// tiles[i].graphicTile.setPlace(x, y, i);
		}
	}

	public function fill (name:String) {
		for (i in 0...tiles.length) {
			tiles[i].graphicTile.addGround(name);
		}
	}

		/***** YOU DON'T CARE *****/
	static private var alreadySet:Bool;
	private var isoEngine:IsoEngine;

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
		alreadySet = false;
		isoEngine = IsoEngine.getInstance();

		bindEvents();
	}


	public static function getInstance (): Map {
		if (instance == null) instance = new Map();
		return instance;
	}


	public function destroy (): Void {
		instance = null;
	}


	private function addLayer (nb) {
		for (i in 0...nb) {
		    isoEngine.displaying.createChildLayer("buildingHeight" + i, "overTiles");
		}
	}


	private function bindEvents () {
		// isoEngine.on("tileMouseEnter", tileOn);
		// isoEngine.on("tileMouseExit" , tileOut);
		// isoEngine.on("tileMouseClick", tileClick);
	}

}
