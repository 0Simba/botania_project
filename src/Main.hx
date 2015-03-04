package ;

import engine.input.Keyboard;
import js.Browser;
import engine.isoEngine.IsoEngine;
import engine.isoEngine.controls.Camera;
import manager.Camera.CameraManager;
import init.Config;
import init.PlayerDatas;
import lib.FB;

class Main
{
	public  static var deltaTime:Float;
	private static var isoEngine:IsoEngine;

	private static var nbAsynchronousCallback = 1;
	private static var nbCall = 0;


	private function new () {
		init.Config.load();
	}

	static public function ConfigLoaded () {
		deltaTime = 0;
		// Put here all asynchronous loading function. They have to call Main.ready. (increment nbAsynchronousCallback)
		IsoEngine.init(Config.display.canvas.size.width, Config.display.canvas.size.height);
		init.Assets.load();
	}
	static public function ready () {
		nbCall++;
		if (nbCall == nbAsynchronousCallback) {
					// Put here all synchronous loading function.
				//init
			init.ForTest.load();
			init.Map.load();
			init.PopUp.load();
			init.CircleHud.load();
				//manager
			manager.Hud.init();
			manager.MouseTile.init();

			isoEngine = IsoEngine.getInstance();
			Keyboard.init();

			utils.AjaxRequest.initLog();
			PlayerDatas.load();

			lastTS = Date.now().getTime();

			trace("on balance le get login");
			FB.getLoginStatus(onFacebookConnect);
	        //Browser.window.requestAnimationFrame(cast gameLoop);
	    }
	}


	static private function onFacebookConnect (pResponse:Dynamic) {
		if (pResponse.status == "connected") {
			trace("Connected !");
			// FB.ui({method : "share", href : "http://developers.facebook.com/docs/"}, function () {
			// 	trace("shared");
			// });
		}
		else if (pResponse.status == "not_authorized") {
			trace("Not authorized");
		}
		else {
			trace("Connection problem");
		}

        Browser.window.requestAnimationFrame(cast gameLoop);
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
