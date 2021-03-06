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
		// haxe.Timer.delay(init.Config.load, 3000);
		init.Config.load();
	}

	static public function ConfigLoaded () {
		deltaTime = 0;
		// Put here all asynchronous loading function. They have to call Main.ready. (increment nbAsynchronousCallback)
		var width:Int  = Math.floor(Math.max(js.Browser.window.innerWidth * 0.98, Config.display.canvas.size.width));
		var height:Int = Math.floor(Math.max(js.Browser.window.innerHeight * 0.98, Config.display.canvas.size.height));
		IsoEngine.init(width, height);
		init.Assets.load();
	}
	static public function ready () {
		nbCall++;
		if (nbCall == nbAsynchronousCallback) {
					// Put here all synchronous loading function.

				//init
			utils.AjaxRequest.initLog();
			init.ShopDatas.load();
			PlayerDatas.load();
			init.ForTest.load();
			init.Map.load();
			init.PopUp.load();
			init.CircleHud.load();
			init.Filters.load();

				//manager
			manager.Hud.init();
			manager.MouseTile.init();
			manager.Sounds.init();
			manager.FTUEController.getInstance();

			entities.MergeAnimation.init();
			entities.Seagulls.initLoop();

			isoEngine = IsoEngine.getInstance();
			Keyboard.init();

				// on components loaded
			entities.popUps.HeaderPopUp.onComponentsLoaded();
			entities.popUps.FtuePopUp.setTitleAndShow("Bienvenu dans le monde de Botania. ici vous pourrez faire votre jardin de reve.
        Commençons tout de suite.");

			lastTS = Date.now().getTime();

			init.LoaderDisplay.loaded();
			FB.getLoginStatus(onFacebookConnect);
	    }
	}


	static private function onFacebookConnect (pResponse:Dynamic) {
		trace(pResponse);
		if (pResponse.status == "connected") {
			init.ForTest.loadLast();
			Browser.window.requestAnimationFrame(cast gameLoop);
		}
		else if (pResponse.status == "not_authorized") {
			FB.login(onFacebookConnect, {scope: 'user_friends, email'});
			trace("Not authorized");
		}
		else {
			trace("Connection problem");
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
