package engine.isoEngine.controls;

import pixi.display.Stage;
import engine.isoEngine.components.Hud;
import utils.Vector2;

class Mouse
{

	static private function onClick () {
		Camera.onClick();
		Hud.onClick();
	}




	public static var status:String = "up";
	public static var position:Vector2;




		/***** YOU DON'T CARE *****/
	static private var stageRef:Stage;

	public static function setRef (stage) {
		stageRef = stage;
		stage.mousemove = mouseMove;
		stage.mousedown = mousedown;
		stage.mouseup   = mouseup;
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