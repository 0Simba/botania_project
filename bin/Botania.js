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
		if(name == "graphicTile") this.graphicTile = new engine.isoEngine.Tile();
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
		Main.lastTS = new Date().getTime();
		window.requestAnimationFrame(Main.gameLoop);
	}
};
Main.gameLoop = function() {
	window.requestAnimationFrame(Main.gameLoop);
	Main.deltaTime = (new Date().getTime() - Main.lastTS) / 100;
	Main.lastTS = new Date().getTime();
	console.log(Main.deltaTime);
	Main.isoEngine.render();
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
engine.isoEngine = {};
engine.isoEngine.Camera = function() { };
engine.isoEngine.Camera.setRef = function(cameraRef) {
	engine.isoEngine.Camera.camera = cameraRef;
};
engine.isoEngine.Camera.move = function(x,y) {
	if(y == null) y = 0;
	if(x == null) x = 0;
	engine.isoEngine.Camera.camera.x += x;
	engine.isoEngine.Camera.camera.y += y;
};
engine.isoEngine.IsoEngine = function(width,height) {
	this.stage = new PIXI.Stage(13619151);
	this.textures = new haxe.ds.StringMap();
	this.animations = new haxe.ds.StringMap();
	this.size = 0;
	this.renderer = PIXI.autoDetectRenderer(width,height);
	window.document.body.appendChild(this.renderer.view);
	this.camera = new PIXI.Graphics();
	engine.isoEngine.Camera.setRef(this.camera);
	this.stage.addChild(this.camera);
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
		var loader = new PIXI.AssetLoader(assets);
		loader.onComplete = function() {
			callback();
		};
		loader.load();
	}
	,destroy: function() {
		engine.isoEngine.IsoEngine.instance = null;
	}
	,render: function() {
		this.renderer.render(this.stage);
	}
};
engine.isoEngine.Tile = function() {
	engine.isoEngine.Tile.referent = engine.isoEngine.IsoEngine.getInstance();
};
engine.isoEngine.Tile.prototype = {
	addGround: function(name) {
		this.ground = new PIXI.MovieClip(engine.isoEngine.Tile.referent.animations.get(name));
		this.ground.width = engine.isoEngine.Tile.referent.size;
		this.ground.height = engine.isoEngine.Tile.referent.size / 2;
		engine.isoEngine.Tile.referent.camera.addChild(this.ground);
	}
	,place: function(x,y) {
		var pxX = x * engine.isoEngine.Tile.referent.size / 2 - y * engine.isoEngine.Tile.referent.size / 2;
		var pxY = x * engine.isoEngine.Tile.referent.size / 4 + y * engine.isoEngine.Tile.referent.size / 4;
		this.ground.x = pxX;
		this.ground.y = pxY;
	}
};
var entities = {};
entities.Tile = function() {
	GameObject.call(this);
	this.addComponent("graphicTile");
};
entities.Tile.__super__ = GameObject;
entities.Tile.prototype = $extend(GameObject.prototype,{
});
var haxe = {};
haxe.ds = {};
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
	init.Assets.isoEngine.load(["../assets/isoTiles.json"],init.Assets.assetLoaded);
};
init.Assets.assetLoaded = function() {
	init.Assets.isoEngine.addTexture("ground","isometricPattern.jpg");
	var list = new Array();
	list.push("ground");
	init.Assets.isoEngine.createAnimation("ground",list);
	Main.ready();
};
init.Map = function() { };
init.Map.load = function() {
	var map = manager.Map.getInstance();
	map.set(10,10);
	map.fill("ground");
};
var manager = {};
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
		var _g1 = 0;
		var _g = nbCols * nbRows;
		while(_g1 < _g) {
			var i = _g1++;
			this.tiles[i] = new entities.Tile();
		}
		this.cols = nbCols;
	}
	,fill: function(name) {
		var _g1 = 0;
		var _g = this.tiles.length;
		while(_g1 < _g) {
			var i = _g1++;
			var x = i % this.cols;
			var y = Math.floor(i / this.cols);
			this.tiles[i].graphicTile.addGround(name);
			this.tiles[i].graphicTile.place(x,y);
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
Main.main();
})();
