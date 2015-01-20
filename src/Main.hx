package ;

import engine.input.Keyboard;
import js.Browser;
import engine.isoEngine.IsoEngine;
import engine.isoEngine.controls.Camera;
import manager.Camera.CameraManager;
class Main
{
	public  static var deltaTime:Float;
	private static var isoEngine:IsoEngine;

	private static var nbAsynchronousCallback = 1;
	private static var nbCall = 0;


	private function new () {
		deltaTime = 0;
					// Put here all asynchronous loading function. They have to call Main.ready. (increment nbAsynchronousCallback)
		IsoEngine.init(1120, 630);
		init.Assets.load();
	}


	static public function ready () {
		nbCall++;
		if (nbCall == nbAsynchronousCallback) {
					// Put here all synchronous loading function.
			init.Map.load();
			init.CircleHud.load();
			manager.Hud.init();
			isoEngine = IsoEngine.getInstance();
			Keyboard.init();

			lastTS = Date.now().getTime();
	        Browser.window.requestAnimationFrame(cast gameLoop);
	    }
	}


	static private function gameLoop() {
		Browser.window.requestAnimationFrame(cast gameLoop);
		deltaTime = (Date.now().getTime() - lastTS) / 100;
		lastTS    = Date.now().getTime();

		isoEngine.render();
		CameraManager.update();
	}






		/****** YOU DON'T CARE *****/
	private static var instance:Main;
	private static var lastTS:Float;

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
