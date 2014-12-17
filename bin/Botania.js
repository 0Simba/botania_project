(function () { "use strict";
var Main = function() {
	Main.isoEngine = new engine.isoEngine.IsoEngine(1120,630);
	Main.isoEngine.load(["./assets/isoTiles.json"],$bind(this,this.assetLoaded));
};
Main.main = function() {
	Main.getInstance();
};
Main.getInstance = function() {
	if(Main.instance == null) Main.instance = new Main();
	return Main.instance;
};
Main.prototype = {
	assetLoaded: function() {
		Main.isoEngine.addTexture("ground","isometricPattern.jpg");
		var list = new Array();
		list.push("ground");
		Main.isoEngine.createAnimation("defaultGround",list);
		Main.isoEngine.setMap(128,5,5,"defaultGround");
		window.requestAnimationFrame($bind(this,this.gameLoop));
	}
	,gameLoop: function() {
		window.requestAnimationFrame($bind(this,this.gameLoop));
		Main.isoEngine.render();
	}
	,destroy: function() {
		Main.instance = null;
	}
};
var IMap = function() { };
var engine = {};
engine.isoEngine = {};
engine.isoEngine.IsoEngine = function(_width,_height) {
	this.stage = new PIXI.Stage(13619151);
	this.map = new Array();
	this.textures = new haxe.ds.StringMap();
	this.animations = new haxe.ds.StringMap();
	this.size = 0;
	this.width = _width;
	this.renderer = PIXI.autoDetectRenderer(this.width,_height);
	window.document.body.appendChild(this.renderer.view);
	this.camera = new PIXI.Graphics();
	this.stage.addChild(this.camera);
	engine.isoEngine.Tile.setReferent(this);
};
engine.isoEngine.IsoEngine.prototype = {
	render: function() {
		this.renderer.render(this.stage);
	}
	,load: function(assets,callback) {
		var loader = new PIXI.AssetLoader(assets);
		loader.onComplete = function() {
			callback();
		};
		loader.load();
	}
	,addTexture: function(name,from) {
		var value = PIXI.Texture.fromFrame(from);
		this.textures.set(name,value);
	}
	,createAnimation: function(name,listTexture) {
		var value = new Array();
		this.animations.set("defaultGround",value);
		var _g1 = 0;
		var _g = listTexture.length;
		while(_g1 < _g) {
			var i = _g1++;
			this.animations.get(name).push(this.textures.get(listTexture[i]));
		}
	}
	,setMap: function(_size,_width,height,defaultTexture) {
		this.width = _width;
		this.size = _size;
		engine.isoEngine.Tile.setSize(_size);
		var demiSize = this.size / 2;
		var quartSize = demiSize / 2;
		var _g1 = 0;
		var _g = this.width * height;
		while(_g1 < _g) {
			var i = _g1++;
			var line = Math.floor(i / this.width);
			this.map[i] = new engine.isoEngine.Tile(defaultTexture);
			var x = i % this.width;
			var y = Math.floor(i / this.width);
			var pxX = x * demiSize - y * demiSize;
			var pxY = x * quartSize + y * quartSize;
			this.map[i].place(pxX,pxY);
		}
	}
};
engine.isoEngine.Tile = function(groundTexture) {
	this.ground = new PIXI.MovieClip(engine.isoEngine.Tile.referent.animations.get(groundTexture));
	this.ground.width = engine.isoEngine.Tile.zize;
	this.ground.height = engine.isoEngine.Tile.semiSize;
	engine.isoEngine.Tile.referent.camera.addChild(this.ground);
};
engine.isoEngine.Tile.setReferent = function(isoEngine) {
	engine.isoEngine.Tile.referent = isoEngine;
};
engine.isoEngine.Tile.setSize = function(_size) {
	engine.isoEngine.Tile.zize = _size;
	engine.isoEngine.Tile.semiSize = Math.floor(_size / 2);
};
engine.isoEngine.Tile.prototype = {
	place: function(x,y) {
		this.ground.x = x;
		this.ground.y = y;
	}
};
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
engine.isoEngine.Tile.zize = 0;
engine.isoEngine.Tile.semiSize = 0;
Main.main();
})();
