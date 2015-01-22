package init;

import pixi.loaders.JsonLoader;
import js.html.Event;
import haxe.Json;

class Config
{
	public static var sourceFilesPath:String = "../assets/config/json/";
	public static var sourceFiles:Json;

	public static var player:Dynamic = "toLoad";
	public static var currencies:Dynamic = "toLoad";
	public static var translate:Dynamic = "toLoad";
	public static var tile:Dynamic = "toLoad";

	static public function load ():Void {
		for (key in Reflect.fields(Config)) {
				var path = Reflect.field(Config, key);
			if (path == "toLoad") {
				trace(key);
				var tempSourceFiles:JsonLoader = new JsonLoader(sourceFilesPath + key + ".json");
		        tempSourceFiles.addEventListener("loaded", function (pEvent:Event) {
		        	onLoadComplete(pEvent, key);
	        	});
		        tempSourceFiles.load();
			}
		}
	}
	
/*	static public function loadDatas (pEvent:Event):Void {


		sourceFiles = cast(pEvent.target,JsonLoader).json;
		for(f in Reflect.fields(sourceFiles)){
			var path:String = Reflect.field( sourceFiles , f );
			var toLoad = new JsonLoader(path);
			toLoad.addEventListener("loaded", onLoadComplete);
	        toLoad.load();
		}
	}
*/	
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

