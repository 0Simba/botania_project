package engine.isoEngine;

import pixi.display.Stage;
import utils.Vector2;

class Mouse
{


	public static var status:String;
	public static var position:Vector2;


		/***** YOU DON'T CARE *****/
	static private var stageRef:Stage;

	public static function setRef (stage) {
		stageRef = stage;

		stage.mousemove = mouseMove;
	}

	private static function mouseMove (mouseData) {
		// trace('move');
		// position.x = mouseData.global.x;
		// position.y = mouseData.global.y;
	}

}