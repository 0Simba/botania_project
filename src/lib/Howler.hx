package lib;

@:native("Howler")
extern class Howler {

	static function init():Howler;

	static var iOSAutoEnable:Bool;

	static var noAudio:Bool;

	static var usingWebAudio:Bool;

	static var ctx:js.html.audio.AudioContext;

	static function codecs(ext:String):Bool;

	@:overload(function(vol:Float):Howler {})
	static function volume(vol:Float):Float;

	static function mute(muted:Bool):Howler;
}