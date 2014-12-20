package ;
import js.Browser;
import engine.isoEngine.IsoEngine;

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
		isoEngine = IsoEngine.getInstance();
		init.Assets.load();
	}

	static public function ready () {
        Browser.window.requestAnimationFrame(cast gameLoop);
	}


	public static function getInstance (): Main {
		if (instance == null) instance = new Main();
		return instance;
	}


	static private function gameLoop() {
		Browser.window.requestAnimationFrame(cast gameLoop);
		isoEngine.render();
	}


	public function destroy (): Void {
		instance = null;
	}

}