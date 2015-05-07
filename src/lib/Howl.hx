package lib;

@:native("Howl")
extern class Howl {

	function new(options:HowlOptions):Void;

	function load():Howl;

	@:overload(function(?sprite:Int):Int {})
	function play(?sprite:String):Int;

	function pause(?id:Int):Howl;

	function stop(?id:Int):Howl;

	function mute(?muted:Bool, ?id:Int):Howl;

	@:overload(function(?vol:Float, ?id:Int):Howl {})
	function volume(?vol:Float, ?id:Int):Float;

	@:overload(function(?loop:Bool, ?id:Int):Howl {})
	function loop(?loop:Bool, ?id:Int):Bool;

	@:overload(function(?seek:Bool, ?id:Int):Howl {})
	function seek(?seek:Float, ?id:Int):Float;

	function playing(?id:Int):Bool;

	function duration():Float;

	function unload():Void;

	function fade(from:Float, to:Float, len:Int, ?id:Int):Howl;

	@:overload(function(event:String, fn:Int -> Void, ?id:Int):Howl {})
	function on(event:String, fn:Void -> Void, ?id:Int):Howl;

	@:overload(function(event:String, fn:Int -> Void, ?id:Int):Howl {})
	function off(event:String, ?fn:Void -> Void, ?id:Int):Howl;

	@:overload(function(event:String, fn:Int -> Void, ?id:Int):Howl {})
	function once(event:String, fn:Void -> Void, ?id:Int):Howl;
}

typedef HowlOptions = {
	@:optional var autoplay:Bool;
	@:optional var ext:Array<String>;
	@:optional var html5:Bool;
	@:optional var mute:Bool;
	@:optional var loop:Bool;
	@:optional var pool:Int;
	@:optional var preload:Bool;
	@:optional var rate:Float;
	@:optional var sprite:Dynamic;
	@:optional var src:Array<String>;
	@:optional var volume:Float;
	@:optional var onload:Void -> Void;
	@:optional var onloaderror:Void -> Void;
	@:optional var onend:Int -> Void;
	@:optional var onpause:Int -> Void;
	@:optional var onplay:Int -> Void;
	@:optional var onfaded:Int -> Void;
}