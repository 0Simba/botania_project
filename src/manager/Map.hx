package manager;

import entities.Tile;
import engine.isoEngine.IsoEngine;
import utils.ArrayCoord;
import engine.isoEngine.components.BackgroundSprite.BackgroudSprite;
import utils.Vector2;

class Map
{

	private static var instance: Map;

	private var tiles:Array<Tile>;
	private var nbCols:Int;
	private var nbRows:Int;

	public function set (_nbCols:Int, _nbRows:Int): Void {
		nbCols = _nbCols; nbRows = _nbRows;

		if (isAlreadySet()) { return; };

		addLayers(nbRows + nbCols);

		for (i in 0...nbCols * nbRows) {
            var x:Int = i % nbCols - Math.floor(nbCols / 2);
            var y:Int = Math.floor(i / nbCols) - Math.floor(nbRows / 2);

			tiles[i] = new Tile(new ArrayCoord(x, y, i));
		}
		addBackground();
	}

	public function get (x:Int, y:Int): Tile {
		var rX = x + Math.floor(nbCols / 2);
		var rY = y + Math.floor(nbRows / 2);
		var i = rX + rY * nbCols;
		return tiles[i];
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


	private function addLayers (nb) {
		var semiNb = Math.ceil(nb / 2);
		for (i in -semiNb...semiNb) {
		    isoEngine.displaying.createChildLayer("buildingHeight" + i, "overTiles");
		}
	}


	private function bindEvents () {
		// isoEngine.on("tileMouseEnter", tileOn);
		// isoEngine.on("tileMouseExit" , tileOut);
		// isoEngine.on("tileMouseClick", tileClick);
	}



	public function addBackground () {
		var totalSize   = new Vector2(3840, 3840);
		var elementSize = new Vector2(1920, 1920);

		BackgroudSprite.setSize(totalSize, elementSize);
		BackgroudSprite.add("map_0_0", new Vector2(-1, -1));
		BackgroudSprite.add("map_0_1", new Vector2(-1, 0));
		BackgroudSprite.add("map_1_0", new Vector2(0, -1));
		BackgroudSprite.add("map_1_1", new Vector2(0, 0));
	}

}
