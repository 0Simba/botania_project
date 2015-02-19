package init;

import pixi.loaders.JsonLoader;
import js.html.Event;
import haxe.Json;

class Config
{
	public static var sourceFilesPath:String = "./assets/config/json/";
	public static var sourceFiles:Json;

	public static var player:Dynamic     = "toLoad";
	public static var currencies:Dynamic = "toLoad";
	public static var translate:Dynamic  = "toLoad";
	public static var display:Dynamic    = "toLoad";
	public static var flower:Dynamic     = "toLoad";
	public static var camera:Dynamic     = "toLoad";
	public static var assets:Dynamic     = "toLoad";
	public static var buildings:Dynamic  = "toLoad";

	static public function load ():Void {
		for (key in Reflect.fields(Config)) {
				var path = Reflect.field(Config, key);
			if (path == "toLoad") {
				var tempSourceFiles:JsonLoader = new JsonLoader(sourceFilesPath + key + ".json");
		        tempSourceFiles.addEventListener("loaded", function (pEvent:Event) {
		        	onLoadComplete(pEvent, key);
	        	});
		        tempSourceFiles.load();
			}
		}
	}

	static private function CheckIsEnded(){
		for (key in Reflect.fields(Config)) {
			var path = Reflect.field(Config, key);
			if (path == "toLoad") {
				return;
			}
		}
		Main.ConfigLoaded();
	}
	static private function onLoadComplete (pEvent:Event, targetKey:String) :Void {
		var tempDatas = cast(pEvent.target, JsonLoader).json;
		var file:Json = cast(pEvent.target,JsonLoader).json;
		Reflect.setField(Config , targetKey , tempDatas);
		CheckIsEnded();
	}
}

