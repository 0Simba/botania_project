package ;
import js.Browser;
import engine.isoEngine.IsoEngine;

class Main
{
	private static var isoEngine:IsoEngine;

	private static var nbAsynchronousCallback = 1;
	private static var nbCall = 0;


	private function new () {
					// Put here all asynchronous loading function. They have to call Main.ready. (increment nbAsynchronousCallback)
		init.Assets.load();
	}


	static public function ready () {
		nbCall++;
		if (nbCall == nbAsynchronousCallback) {
					// Put here all synchronous loading function.
			init.Map.load();
			isoEngine = IsoEngine.getInstance();
	        Browser.window.requestAnimationFrame(cast gameLoop);
	    }
	}


	static private function gameLoop() {
		Browser.window.requestAnimationFrame(cast gameLoop);
		isoEngine.render();
	}






		/****** YOU DON'T CARE *****/
	private static var instance:Main;

	public static function getInstance (): Main {
		if (instance == null) instance = new Main();
		return instance;
	}

	static function main ():Void {
		Main.getInstance();
	}

	public function destroy (): Void {
		instance = null;
	}
}
