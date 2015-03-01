package engine.isoEngine.controls;

import pixi.display.Stage;
import engine.isoEngine.components.Hud;
import utils.Vector2;
import js.html.VoidCallback;
import engine.events.Events;
import engine.isoEngine.controls.Camera;

class Mouse
{

	static public var events:Events = new Events();



		/***** MAP *****/
	public static var mapStatus:String = "up";
	public static var mapPosition:Vector2;

	private static function mapup (mouseData) {
		mapStatus = "up";
		events.emit("map mouseup", null);
	}
	private static function mapdown (mouseData) {
		mapStatus = "down";
		events.emit("map mousedown", null);
	}
	private static function mapmove (mouseData) {
		mapPosition = new Vector2(mouseData.global.x, mouseData.global.y);
		events.emit("map mousemove", mapPosition);
	}



		/***** STAGE *****/
	public static var stageStatus:String = "up";
	public static var stagePosition:Vector2;


	private static function stageup (mouseData) {
		stageStatus = "up";
		stagePosition = new Vector2(mouseData.global.x, mouseData.global.y);
		events.emit("stage mouseup", stagePosition);
	}
	private static function stagedown (mouseData) {
		stageStatus = "down";

		events.emit("stage mousedown", stagePosition);
	}
	private static function stagemove (mouseData) {
		stagePosition = new Vector2(mouseData.global.x, mouseData.global.y);
		events.emit("stage mousemove", stagePosition);
	}





		/***** YOU DON'T CARE *****/
	static private var playArea:pixi.display.DisplayObjectContainer;

	public static function setMap (camera:pixi.display.DisplayObjectContainer) {
		playArea = camera;
		camera.interactive = true;
		camera.mousemove = mapmove;
		camera.mousedown = mapdown;
		camera.mouseup   = mapup;
	}

	public static function setStage (stage:Stage) {
		stage.interactive = true;
		stage.mousemove = stagemove;
		stage.mousedown = stagedown;
		stage.mouseup   = stageup;
	}

}