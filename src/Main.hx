package ;

import engine.isoEngine.IsoEngine;
import js.Browser;

/**
 * ...
 * @author Jaf
 */

class Main
{

	private static var instance:Main;
	private static var isoEngine:IsoEngine;

	static function main ():Void {
		Main.getInstance();
	}


	private function new () {
		isoEngine = new IsoEngine(1120, 630);//IsoEngine.getInstance(1120, 630);
		isoEngine.load(["./assets/isoTiles.json"], assetLoaded);

	}

	function assetLoaded () {
		isoEngine.setMap(128, 5, 5, "isometricPattern.jpg");
		Browser.window.requestAnimationFrame(cast gameLoop);
	}


	public static function getInstance (): Main {
		if (instance == null) instance = new Main();
		return instance;
	}


	function gameLoop() {
		Browser.window.requestAnimationFrame(cast gameLoop);
		isoEngine.render();
	}


	public function destroy (): Void {
		instance = null;
	}

}