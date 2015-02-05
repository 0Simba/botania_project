package engine.isoEngine.controls;

import pixi.display.Stage;
import engine.isoEngine.components.Hud;
import utils.Vector2;
import js.html.VoidCallback;


class Mouse
{

	static private var onClickCallback:Array<VoidCallback> = new Array<VoidCallback>();

	static private function onClick () {
		for (i in 0...onClickCallback.length) {
			onClickCallback[i]();
		}
	}

	static public function addOnClickEvent (callback:VoidCallback) {
		onClickCallback.push(callback);
	}



	public static var status:String = "up";
	public static var position:Vector2;




		/***** YOU DON'T CARE *****/
	static private var playArea:pixi.display.DisplayObjectContainer;

	public static function setRef (camera:pixi.display.DisplayObjectContainer) {
		playArea = camera;
		camera.interactive = true;
		camera.mousemove = mouseMove;
		camera.mousedown = mousedown;
		camera.mouseup   = mouseup;
	}

	private static function mousedown (mouseData) {
		status = "down";
	}

	private static function mouseup (mouseData) {
		status = "up";
		onClick();
	}

	private static function mouseMove (mouseData) {
		// trace('move');
		// position.x = mouseData.global.x;
		// position.y = mouseData.global.y;
	}

}