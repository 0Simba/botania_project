(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var GameObject = function() {
};
GameObject.prototype = {
	addComponent: function(name) {
		if(name == "graphicTile") this.graphicTile = new engine.isoEngine.Tile(); else if(name == "interactiveTile") this.interactiveTile = new engine.isoEngine.InteractiveTile();
	}
};
var Main = function() {
	Main.deltaTime = 0;
	init.Assets.load();
};
Main.ready = function() {
	Main.nbCall++;
	if(Main.nbCall == Main.nbAsynchronousCallback) {
		init.Map.load();
		Main.isoEngine = engine.isoEngine.IsoEngine.getInstance();
		engine.input.Keyboard.init();
		Main.lastTS = new Date().getTime();
		window.requestAnimationFrame(Main.gameLoop);
	}
};
Main.gameLoop = function() {
	window.requestAnimationFrame(Main.gameLoop);
	Main.deltaTime = (new Date().getTime() - Main.lastTS) / 100;
	Main.lastTS = new Date().getTime();
	Main.isoEngine.render();
	manager.CameraManager.update();
};
Main.getInstance = function() {
	if(Main.instance == null) Main.instance = new Main();
	return Main.instance;
};
Main.main = function() {
	Main.getInstance();
};
Main.prototype = {
	destroy: function() {
		Main.instance = null;
	}
};
var IMap = function() { };
var engine = {};
engine.input = {};
engine.input.KeyName = function() { };
engine.input.KeyName.set = function() {
	engine.input.KeyName.list = new haxe.ds.IntMap();
	engine.input.KeyName.list.set(37,"left");
	engine.input.KeyName.list.set(38,"up");
	engine.input.KeyName.list.set(39,"right");
	engine.input.KeyName.list.set(40,"down");
};
engine.input.Keyboard = function() { };
engine.input.Keyboard.onKeyDown = function(pEvent) {
	engine.input.Keyboard.keyChange(pEvent.keyCode,true);
};
engine.input.Keyboard.onKeyUp = function(pEvent) {
	engine.input.Keyboard.keyChange(pEvent.keyCode,false);
};
engine.input.Keyboard.keyChange = function(keyCode,value) {
	var keyName = engine.input.KeyName.list.get(keyCode);
	if(keyName != null) {
		var key = engine.input.KeyName.list.get(keyCode);
		engine.input.Keyboard.key.set(key,value);
	}
};
engine.input.Keyboard.init = function() {
	engine.input.KeyName.set();
	engine.input.Keyboard.key = new haxe.ds.StringMap();
	window.onkeydown = engine.input.Keyboard.onKeyDown;
	window.onkeyup = engine.input.Keyboard.onKeyUp;
};
engine.isoEngine = {};
engine.isoEngine.Camera = function() { };
engine.isoEngine.Camera.setRef = function(peonWhileTrue) {
	engine.isoEngine.Camera.camera = engine.isoEngine.Displaying.getInstance().getCamera();
	engine.isoEngine.Camera.isoEngine = peonWhileTrue;
	engine.isoEngine.Camera.currentPos = new utils.Vector2(-1,-1);
	engine.isoEngine.Camera.setMouse();
};
engine.isoEngine.Camera.move = function(x,y) {
	if(y == null) y = 0;
	if(x == null) x = 0;
	engine.isoEngine.Camera.camera.x += x;
	engine.isoEngine.Camera.camera.y += y;
};
engine.isoEngine.Camera.setMouse = function() {
	engine.isoEngine.Camera.camera.interactive = true;
	engine.isoEngine.Camera.camera.mousemove = engine.isoEngine.Camera.mousemove;
};
engine.isoEngine.Camera.mousemove = function(mouseData) {
	var newPos = engine.isoEngine.Camera.pxToCoord(new utils.Vector2(mouseData.global.x,mouseData.global.y));
	if(engine.isoEngine.Camera.tileChanged(newPos)) {
		var tile = engine.isoEngine.Camera.isoEngine.getMapedTile(engine.isoEngine.Camera.currentPos.x,engine.isoEngine.Camera.currentPos.y);
		if(tile != null) tile.mouseExit();
		tile = engine.isoEngine.Camera.isoEngine.getMapedTile(newPos.x,newPos.y);
		if(tile != null) {
			tile.mouseEnter();
			if(tile.isInteractive) engine.isoEngine.Camera.isoEngine.tileIndicator.overOn(newPos.x,newPos.y); else engine.isoEngine.Camera.isoEngine.tileIndicator.hide();
		} else engine.isoEngine.Camera.isoEngine.tileIndicator.hide();
	}
	engine.isoEngine.Camera.currentPos = newPos;
};
engine.isoEngine.Camera.tileChanged = function(newPos) {
	return newPos.x != engine.isoEngine.Camera.currentPos.x || newPos.y != engine.isoEngine.Camera.currentPos.y;
};
engine.isoEngine.Camera.pxToCoord = function(px) {
	px.x -= engine.isoEngine.Camera.camera.x;
	px.y -= engine.isoEngine.Camera.camera.y;
	var newPos = new utils.Vector2(-1,-1);
	newPos.x = Math.round((px.x - engine.isoEngine.Camera.isoEngine.size) / engine.isoEngine.Camera.isoEngine.size + px.y / (engine.isoEngine.Camera.isoEngine.size / 2));
	newPos.y = Math.round(px.y / (engine.isoEngine.Camera.isoEngine.size / 2) - px.x / engine.isoEngine.Camera.isoEngine.size);
	return newPos;
};
engine.isoEngine.Displaying = function(_stage) {
	this.layers = new haxe.ds.StringMap();
	this.stage = _stage;
	this.createMainLayer("camera");
	this.createChildLayer("tiles","camera");
	this.createChildLayer("overTiles","camera");
};
engine.isoEngine.Displaying.getInstance = function(stage) {
	if(engine.isoEngine.Displaying.instance == null) engine.isoEngine.Displaying.instance = new engine.isoEngine.Displaying(stage);
	return engine.isoEngine.Displaying.instance;
};
engine.isoEngine.Displaying.prototype = {
	displayMcOn: function(mc,layer) {
		this.layers.get(layer).addChild(mc);
	}
	,displayOn: function(movieClip,layerName) {
	}
	,getCamera: function() {
		return this.layers.get("camera");
	}
	,createMainLayer: function(name) {
		var layer = new PIXI.Graphics();
		this.stage.addChild(layer);
		this.layers.set(name,layer);
	}
	,createChildLayer: function(name,parent) {
		var layer = new PIXI.Graphics();
		this.layers.get(parent).addChild(layer);
		this.layers.set(name,layer);
	}
};
engine.isoEngine.InteractiveTile = function() {
};
engine.isoEngine.IsoEngine = function(width,height) {
	this.stage = new PIXI.Stage(13619151);
	this.textures = new haxe.ds.StringMap();
	this.animations = new haxe.ds.StringMap();
	this.mapTiles = new Array();
	this.tileIndicator = engine.isoEngine.TileSelectionIndicator.getInstance();
	this.size = 0;
	this.renderer = PIXI.autoDetectRenderer(width,height);
	window.document.body.appendChild(this.renderer.view);
	this.displaying = engine.isoEngine.Displaying.getInstance(this.stage);
	engine.isoEngine.Mouse.setRef(this.stage);
	engine.isoEngine.Camera.setRef(this);
};
engine.isoEngine.IsoEngine.getInstance = function(_width,_height) {
	if(_height == null) _height = 900;
	if(_width == null) _width = 1600;
	if(engine.isoEngine.IsoEngine.instance == null) engine.isoEngine.IsoEngine.instance = new engine.isoEngine.IsoEngine(_width,_height);
	return engine.isoEngine.IsoEngine.instance;
};
engine.isoEngine.IsoEngine.prototype = {
	setTileSize: function(_size) {
		this.size = _size;
		engine.isoEngine.IsoUtils.setSize(this.size);
	}
	,addTexture: function(name,from) {
		var value = PIXI.Texture.fromFrame(from);
		this.textures.set(name,value);
	}
	,createAnimation: function(name,listTexture) {
		var value = new Array();
		this.animations.set(name,value);
		var _g1 = 0;
		var _g = listTexture.length;
		while(_g1 < _g) {
			var i = _g1++;
			this.animations.get(name).push(this.textures.get(listTexture[i]));
		}
	}
	,load: function(assets,callback) {
		var _g = this;
		assets.push("../assets/selection.json");
		var loader = new PIXI.AssetLoader(assets);
		loader.onComplete = function() {
			_g.tileIndicator.assetLoaded();
			callback();
		};
		loader.load();
	}
	,addMapedTile: function(tile) {
		if(this.mapTiles[tile.coord.x] == null) this.mapTiles[tile.coord.x] = new Array();
		this.mapTiles[tile.coord.x][tile.coord.y] = tile;
	}
	,destroy: function() {
		engine.isoEngine.IsoEngine.instance = null;
	}
	,render: function() {
		this.renderer.render(this.stage);
	}
	,getMapedTile: function(x,y) {
		if(this.mapTiles[x] != null) return this.mapTiles[x][y];
		return null;
	}
};
engine.isoEngine.IsoUtils = function() { };
engine.isoEngine.IsoUtils.coordToPx = function(x,y) {
	var px = new utils.Vector2(0,0);
	px.x = x * engine.isoEngine.IsoUtils.size / 2 - y * engine.isoEngine.IsoUtils.size / 2;
	px.y = x * engine.isoEngine.IsoUtils.size / 4 + y * engine.isoEngine.IsoUtils.size / 4;
	return px;
};
engine.isoEngine.IsoUtils.setSize = function(_size) {
	engine.isoEngine.IsoUtils.size = _size;
};
engine.isoEngine.Mouse = function() { };
engine.isoEngine.Mouse.setRef = function(stage) {
	engine.isoEngine.Mouse.stageRef = stage;
	stage.mousemove = engine.isoEngine.Mouse.mouseMove;
};
engine.isoEngine.Mouse.mouseMove = function(mouseData) {
};
engine.isoEngine.Tile = function() {
	engine.isoEngine.Tile.referent = engine.isoEngine.IsoEngine.getInstance();
	this.isInteractive = false;
};
engine.isoEngine.Tile.prototype = {
	addGround: function(name) {
		this.ground = new PIXI.MovieClip(engine.isoEngine.Tile.referent.animations.get(name));
		this.ground.width = engine.isoEngine.Tile.referent.size;
		this.ground.height = engine.isoEngine.Tile.referent.size / 2;
		engine.isoEngine.Displaying.getInstance().displayMcOn(this.ground,"tiles");
	}
	,changeGround: function(name) {
		this.ground.texture = engine.isoEngine.Tile.referent.textures.get(name);
	}
	,place: function(x,y) {
		var px = engine.isoEngine.IsoUtils.coordToPx(x,y);
		this.ground.x = px.x;
		this.ground.y = px.y;
	}
	,setPlace: function(_x,_y,_i) {
		this.coord = new utils.ArrayCoord(_x,_y,_i);
		this.place(_x,_y);
		if(this.coord.i >= 0) engine.isoEngine.Tile.referent.addMapedTile(this);
	}
	,setInteractive: function(_mouseEnter,_mouseExit) {
		this.mouseEnter = _mouseEnter;
		this.mouseExit = _mouseExit;
		this.isInteractive = true;
	}
	,mouseEnter: function() {
	}
	,mouseExit: function() {
	}
};
engine.isoEngine.TileSelectionIndicator = function() {
};
engine.isoEngine.TileSelectionIndicator.getInstance = function() {
	if(engine.isoEngine.TileSelectionIndicator.instance == null) engine.isoEngine.TileSelectionIndicator.instance = new engine.isoEngine.TileSelectionIndicator();
	return engine.isoEngine.TileSelectionIndicator.instance;
};
engine.isoEngine.TileSelectionIndicator.prototype = {
	overOn: function(x,y) {
		var px = engine.isoEngine.IsoUtils.coordToPx(x,y);
		this.movieClip.x = px.x;
		this.movieClip.y = px.y;
		this.movieClip.visible = true;
	}
	,hide: function() {
		this.movieClip.visible = false;
	}
	,assetLoaded: function() {
		this.isoEngine = engine.isoEngine.IsoEngine.getInstance();
		this.createAnimation(this.isoEngine);
		this.movieClip = new PIXI.MovieClip(this.isoEngine.animations.get("tileIndicator"));
		this.movieClip.width = this.isoEngine.size;
		this.movieClip.height = this.isoEngine.size / 2;
		engine.isoEngine.Displaying.getInstance().displayMcOn(this.movieClip,"overTiles");
	}
	,createAnimation: function(isoEngine) {
		isoEngine.addTexture("over","over");
		var list = new Array();
		list.push("over");
		isoEngine.createAnimation("tileIndicator",list);
	}
};
var entities = {};
entities.Tile = function() {
	GameObject.call(this);
	this.addComponent("graphicTile");
	this.graphicTile.addGround("ground");
	this.graphicTile.setInteractive($bind(this,this.mouseover),$bind(this,this.mousequit));
};
entities.Tile.__super__ = GameObject;
entities.Tile.prototype = $extend(GameObject.prototype,{
	mouseover: function() {
	}
	,mousequit: function() {
	}
});
var haxe = {};
haxe.ds = {};
haxe.ds.IntMap = function() {
	this.h = { };
};
haxe.ds.IntMap.__interfaces__ = [IMap];
haxe.ds.IntMap.prototype = {
	set: function(key,value) {
		this.h[key] = value;
	}
	,get: function(key) {
		return this.h[key];
	}
};
haxe.ds.StringMap = function() {
	this.h = { };
};
haxe.ds.StringMap.__interfaces__ = [IMap];
haxe.ds.StringMap.prototype = {
	set: function(key,value) {
		this.h["$" + key] = value;
	}
	,get: function(key) {
		return this.h["$" + key];
	}
};
var init = {};
init.Assets = function() { };
init.Assets.load = function() {
	init.Assets.isoEngine = engine.isoEngine.IsoEngine.getInstance(1120,630);
	init.Assets.isoEngine.setTileSize(128);
	init.Assets.isoEngine.load(["../assets/iso.json"],init.Assets.assetLoaded);
};
init.Assets.assetLoaded = function() {
	init.Assets.isoEngine.addTexture("grass","grass");
	init.Assets.isoEngine.addTexture("water","water");
	var list = new Array();
	list.push("water");
	list.push("grass");
	init.Assets.isoEngine.createAnimation("ground",list);
	Main.ready();
};
init.Map = function() { };
init.Map.load = function() {
	var map = manager.Map.getInstance();
	map.set(10,10);
};
var manager = {};
manager.CameraManager = function() { };
manager.CameraManager.update = function() {
	var speed = 20 * Main.deltaTime;
	if(engine.input.Keyboard.key.get("right")) engine.isoEngine.Camera.move(-speed,0);
	if(engine.input.Keyboard.key.get("left")) engine.isoEngine.Camera.move(speed,0);
	if(engine.input.Keyboard.key.get("up")) engine.isoEngine.Camera.move(0,speed);
	if(engine.input.Keyboard.key.get("down")) engine.isoEngine.Camera.move(0,-speed);
};
manager.Map = function() {
	this.tiles = new Array();
	this.cols = 0;
	manager.Map.alreadySet = false;
};
manager.Map.getInstance = function() {
	if(manager.Map.instance == null) manager.Map.instance = new manager.Map();
	return manager.Map.instance;
};
manager.Map.prototype = {
	set: function(nbCols,nbRows) {
		if(this.isAlreadySet()) return;
		this.cols = nbCols;
		var _g1 = 0;
		var _g = nbCols * nbRows;
		while(_g1 < _g) {
			var i = _g1++;
			this.tiles[i] = new entities.Tile();
			var x = i % this.cols;
			var y = Math.floor(i / this.cols);
			this.tiles[i].graphicTile.setPlace(x,y,i);
		}
	}
	,fill: function(name) {
		var _g1 = 0;
		var _g = this.tiles.length;
		while(_g1 < _g) {
			var i = _g1++;
			this.tiles[i].graphicTile.addGround(name);
		}
	}
	,isAlreadySet: function() {
		if(manager.Map.alreadySet) {
			console.log("Le manager de la map à déjà été initialisé");
			return true;
		}
		manager.Map.alreadySet = true;
		return false;
	}
	,destroy: function() {
		manager.Map.instance = null;
	}
};
var utils = {};
utils.ArrayCoord = function(_x,_y,_i) {
	if(_x == null) _x = 0;
	this.x = _x;
	this.y = _y;
	this.i = _i;
};
utils.Vector2 = function(_x,_y) {
	if(_x == null) _x = 0;
	this.x = _x;
	this.y = _y;
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
Math.NaN = Number.NaN;
Math.NEGATIVE_INFINITY = Number.NEGATIVE_INFINITY;
Math.POSITIVE_INFINITY = Number.POSITIVE_INFINITY;
Math.isFinite = function(i) {
	return isFinite(i);
};
Math.isNaN = function(i1) {
	return isNaN(i1);
};
Main.nbAsynchronousCallback = 1;
Main.nbCall = 0;
engine.isoEngine.IsoUtils.size = 0;
Main.main();
})();
