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
		if(name == "graphicTile") this.graphicTile = new engine.isoEngine.components.Tile(); else if(name == "hudElement") this.hudElement = new engine.isoEngine.components.Hud();
	}
};
var Main = function() {
	Main.deltaTime = 0;
	engine.isoEngine.IsoEngine.init(1120,630);
	init.Assets.load();
};
Main.ready = function() {
	Main.nbCall++;
	if(Main.nbCall == Main.nbAsynchronousCallback) {
		init.Map.load();
		manager.Hud.init();
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
engine.isoEngine.IsoEngine = function(_width,_height) {
	this.build();
	this.width = _width;
	this.height = _height;
	this.renderer = PIXI.autoDetectRenderer(_width,_height);
	window.document.body.appendChild(this.renderer.view);
};
engine.isoEngine.IsoEngine.getInstance = function() {
	return engine.isoEngine.IsoEngine.instance;
};
engine.isoEngine.IsoEngine.init = function(width,height) {
	if(height == null) height = 900;
	if(width == null) width = 1600;
	if(engine.isoEngine.IsoEngine.instance == null) engine.isoEngine.IsoEngine.instance = new engine.isoEngine.IsoEngine(width,height);
};
engine.isoEngine.IsoEngine.prototype = {
	build: function() {
		this.stage = new PIXI.Stage(13619151);
		this.map = new engine.isoEngine.managers.Maping();
		this.assets = new engine.isoEngine.managers.Assets(this);
		this.tileIndicator = new engine.isoEngine.managers.TileSelectionIndicator();
		this.displaying = new engine.isoEngine.managers.Displaying(this.stage);
		engine.isoEngine.controls.Mouse.setRef(this.stage);
		engine.isoEngine.controls.Camera.setRef(this);
	}
	,destroy: function() {
		engine.isoEngine.IsoEngine.instance = null;
	}
	,render: function() {
		this.renderer.render(this.stage);
	}
};
engine.isoEngine.IsoUtils = function() { };
engine.isoEngine.IsoUtils.coordToPx = function(x,y) {
	var px = new utils.Vector2(0,0);
	px.x = x * engine.isoEngine.components.Tile.size / 2 - y * engine.isoEngine.components.Tile.size / 2;
	px.y = x * engine.isoEngine.components.Tile.size / 4 + y * engine.isoEngine.components.Tile.size / 4;
	return px;
};
engine.isoEngine.components = {};
engine.isoEngine.components.Hud = function() {
	this.isoEngine = engine.isoEngine.IsoEngine.getInstance();
};
engine.isoEngine.components.Hud.onClick = function() {
	if(engine.isoEngine.components.Hud.currentOver != null) engine.isoEngine.components.Hud.currentOver.clickBind();
};
engine.isoEngine.components.Hud.prototype = {
	set: function(percentSize,percentPos,animationName,textureName) {
		this.movieClip = new PIXI.MovieClip(this.isoEngine.assets.animations.get(animationName));
		this.resize(percentSize);
		this.replace(percentPos);
		if(textureName != null) this.changeTexture(textureName);
		this.isoEngine.displaying.displayMcOn(this.movieClip,"hud");
		this.initInteractivity();
	}
	,bindEvents: function(_mouseover,_mouseout,_mouseclick) {
		this.overBind = _mouseover;
		this.outBind = _mouseout;
		this.clickBind = _mouseclick;
	}
	,changeTexture: function(name) {
		this.movieClip.texture = this.isoEngine.assets.textures.get(name);
	}
	,replace: function(pos) {
		this.movieClip.x = this.isoEngine.width * pos.x;
		this.movieClip.y = this.isoEngine.height * pos.y;
	}
	,resize: function(size) {
		this.movieClip.width = this.isoEngine.width * size.x;
		this.movieClip.height = this.isoEngine.height * size.y;
	}
	,initInteractivity: function() {
		this.movieClip.interactive = true;
		this.movieClip.mouseover = $bind(this,this.alwaysOver);
		this.movieClip.mouseout = $bind(this,this.alwaysOut);
	}
	,overBind: function() {
	}
	,outBind: function() {
	}
	,clickBind: function() {
		console.log("petasse");
	}
	,alwaysOver: function(mouseData) {
		engine.isoEngine.components.Hud.currentOver = this;
		this.overBind();
	}
	,alwaysOut: function(mouseData) {
		engine.isoEngine.components.Hud.currentOver = null;
		this.outBind();
	}
};
engine.isoEngine.components.Tile = function() {
	engine.isoEngine.components.Tile.isoEngine = engine.isoEngine.IsoEngine.getInstance();
	this.isInteractive = false;
};
engine.isoEngine.components.Tile.setSize = function(_size) {
	engine.isoEngine.components.Tile.size = _size;
};
engine.isoEngine.components.Tile.prototype = {
	addGround: function(name) {
		this.ground = new PIXI.MovieClip(engine.isoEngine.components.Tile.isoEngine.assets.animations.get(name));
		this.ground.width = engine.isoEngine.components.Tile.size;
		this.ground.height = engine.isoEngine.components.Tile.size / 2;
		engine.isoEngine.components.Tile.isoEngine.displaying.displayMcOn(this.ground,"tiles");
	}
	,changeGround: function(name) {
		this.ground.texture = engine.isoEngine.components.Tile.isoEngine.assets.textures.get(name);
	}
	,addBuild: function(textureName) {
		this.building = new PIXI.MovieClip(engine.isoEngine.components.Tile.isoEngine.assets.animations.get("ground"));
		this.building.texture = engine.isoEngine.components.Tile.isoEngine.assets.textures.get(textureName);
		this.building.width = engine.isoEngine.components.Tile.size;
		this.building.height = engine.isoEngine.components.Tile.size;
		this.building.x = this.ground.x;
		this.building.y = this.ground.y - engine.isoEngine.components.Tile.size / 2;
		engine.isoEngine.components.Tile.isoEngine.displaying.displayMcOn(this.building,"tiles");
	}
	,changeBuild: function(name) {
		if(name == null) this.building.visible = false; else {
			if(this.building == null) this.addBuild(name); else this.building.texture = engine.isoEngine.components.Tile.isoEngine.assets.textures.get(name);
			this.building.visible = true;
		}
	}
	,place: function(x,y) {
		var px = engine.isoEngine.IsoUtils.coordToPx(x,y);
		this.ground.x = px.x;
		this.ground.y = px.y;
	}
	,setPlace: function(_x,_y,_i) {
		this.coord = new utils.ArrayCoord(_x,_y,_i);
		this.place(_x,_y);
		if(this.coord.i >= 0) engine.isoEngine.components.Tile.isoEngine.map.addTile(this);
	}
	,setInteractive: function(_mouseEnter,_mouseExit,_mouseClick) {
		this.mouseEnter = _mouseEnter;
		this.mouseExit = _mouseExit;
		this.mouseClick = _mouseClick;
		this.isInteractive = true;
	}
	,mouseEnter: function() {
	}
	,mouseExit: function() {
	}
	,mouseClick: function() {
	}
};
engine.isoEngine.controls = {};
engine.isoEngine.controls.Camera = function() { };
engine.isoEngine.controls.Camera.setRef = function(peonWhileTrue) {
	engine.isoEngine.controls.Camera.isoEngine = peonWhileTrue;
	engine.isoEngine.controls.Camera.camera = engine.isoEngine.controls.Camera.isoEngine.displaying.getCamera();
	engine.isoEngine.controls.Camera.currentPos = new utils.Vector2(-1,-1);
	engine.isoEngine.controls.Camera.setMouse();
};
engine.isoEngine.controls.Camera.move = function(x,y) {
	if(y == null) y = 0;
	if(x == null) x = 0;
	engine.isoEngine.controls.Camera.camera.x += x;
	engine.isoEngine.controls.Camera.camera.y += y;
};
engine.isoEngine.controls.Camera.setMouse = function() {
	engine.isoEngine.controls.Camera.camera.interactive = true;
	engine.isoEngine.controls.Camera.camera.mousemove = engine.isoEngine.controls.Camera.mousemove;
};
engine.isoEngine.controls.Camera.mousemove = function(mouseData) {
	var newPos = engine.isoEngine.controls.Camera.pxToCoord(new utils.Vector2(mouseData.global.x,mouseData.global.y));
	if(engine.isoEngine.controls.Camera.tileChanged(newPos)) {
		var tile = engine.isoEngine.controls.Camera.isoEngine.map.getTile(engine.isoEngine.controls.Camera.currentPos.x,engine.isoEngine.controls.Camera.currentPos.y);
		if(tile != null) tile.mouseExit();
		tile = engine.isoEngine.controls.Camera.isoEngine.map.getTile(newPos.x,newPos.y);
		if(tile != null) {
			tile.mouseEnter();
			if(tile.isInteractive) engine.isoEngine.controls.Camera.isoEngine.tileIndicator.overOn(newPos.x,newPos.y); else engine.isoEngine.controls.Camera.isoEngine.tileIndicator.hide();
		} else engine.isoEngine.controls.Camera.isoEngine.tileIndicator.hide();
	}
	engine.isoEngine.controls.Camera.currentPos = newPos;
};
engine.isoEngine.controls.Camera.tileChanged = function(newPos) {
	return newPos.x != engine.isoEngine.controls.Camera.currentPos.x || newPos.y != engine.isoEngine.controls.Camera.currentPos.y;
};
engine.isoEngine.controls.Camera.pxToCoord = function(px) {
	px.x -= engine.isoEngine.controls.Camera.camera.x;
	px.y -= engine.isoEngine.controls.Camera.camera.y;
	var newPos = new utils.Vector2(-1,-1);
	newPos.x = Math.round((px.x - engine.isoEngine.components.Tile.size) / engine.isoEngine.components.Tile.size + px.y / (engine.isoEngine.components.Tile.size / 2));
	newPos.y = Math.round(px.y / (engine.isoEngine.components.Tile.size / 2) - px.x / engine.isoEngine.components.Tile.size);
	return newPos;
};
engine.isoEngine.controls.Camera.onClick = function() {
	var tile = engine.isoEngine.controls.Camera.isoEngine.map.getTile(engine.isoEngine.controls.Camera.currentPos.x,engine.isoEngine.controls.Camera.currentPos.y);
	if(tile != null) tile.mouseClick();
};
engine.isoEngine.controls.Mouse = function() { };
engine.isoEngine.controls.Mouse.onClick = function() {
	engine.isoEngine.controls.Camera.onClick();
	engine.isoEngine.components.Hud.onClick();
};
engine.isoEngine.controls.Mouse.setRef = function(stage) {
	engine.isoEngine.controls.Mouse.stageRef = stage;
	stage.mousemove = engine.isoEngine.controls.Mouse.mouseMove;
	stage.mousedown = engine.isoEngine.controls.Mouse.mousedown;
	stage.mouseup = engine.isoEngine.controls.Mouse.mouseup;
};
engine.isoEngine.controls.Mouse.mousedown = function(mouseData) {
	engine.isoEngine.controls.Mouse.status = "down";
};
engine.isoEngine.controls.Mouse.mouseup = function(mouseData) {
	engine.isoEngine.controls.Mouse.status = "up";
	engine.isoEngine.controls.Mouse.onClick();
};
engine.isoEngine.controls.Mouse.mouseMove = function(mouseData) {
};
engine.isoEngine.managers = {};
engine.isoEngine.managers.Assets = function(_sup) {
	this.sup = _sup;
	this.textures = new haxe.ds.StringMap();
	this.animations = new haxe.ds.StringMap();
};
engine.isoEngine.managers.Assets.prototype = {
	addTexture: function(name,from) {
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
		assets.push("../assets/selection.json");
		var loader = new PIXI.AssetLoader(assets);
		loader.onComplete = function() {
			callback();
		};
		loader.load();
	}
};
engine.isoEngine.managers.Displaying = function(_stage) {
	this.layers = new haxe.ds.StringMap();
	this.stage = _stage;
	this.createMainLayer("camera");
	this.createMainLayer("hud");
	this.createChildLayer("tiles","camera");
	this.createChildLayer("overTiles","camera");
};
engine.isoEngine.managers.Displaying.prototype = {
	displayMcOn: function(mc,layer) {
		this.layers.get(layer).addChild(mc);
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
engine.isoEngine.managers.Maping = function() {
	this.tiles = new Array();
};
engine.isoEngine.managers.Maping.prototype = {
	getTile: function(x,y) {
		if(this.tiles[x] != null) return this.tiles[x][y];
		return null;
	}
	,addTile: function(tile) {
		if(this.tiles[tile.coord.x] == null) this.tiles[tile.coord.x] = new Array();
		this.tiles[tile.coord.x][tile.coord.y] = tile;
	}
};
engine.isoEngine.managers.TileSelectionIndicator = function() {
};
engine.isoEngine.managers.TileSelectionIndicator.prototype = {
	overOn: function(x,y) {
		return;
		var px = engine.isoEngine.IsoUtils.coordToPx(x,y);
		this.movieClip.x = px.x;
		this.movieClip.y = px.y;
		this.movieClip.visible = true;
	}
	,hide: function() {
	}
	,assetLoaded: function() {
		this.isoEngine = engine.isoEngine.IsoEngine.getInstance();
		this.createAnimation(this.isoEngine);
		this.movieClip = new PIXI.MovieClip(this.isoEngine.assets.animations.get("tileIndicator"));
		this.movieClip.width = engine.isoEngine.components.Tile.size;
		this.movieClip.height = engine.isoEngine.components.Tile.size / 2;
		this.isoEngine.displaying.displayMcOn(this.movieClip,"overTiles");
	}
	,createAnimation: function(isoEngine) {
		isoEngine.assets.addTexture("over","over");
		var list = new Array();
		list.push("over");
		isoEngine.assets.createAnimation("tileIndicator",list);
	}
};
var entities = {};
entities.Tile = function() {
	this.currentBuild = null;
	this.currentAsset = "grass";
	GameObject.call(this);
	this.addComponent("graphicTile");
	this.graphicTile.addGround("ground");
	this.graphicTile.setInteractive($bind(this,this.mouseover),$bind(this,this.mousequit),$bind(this,this.mouseClick));
};
entities.Tile.__super__ = GameObject;
entities.Tile.prototype = $extend(GameObject.prototype,{
	mouseover: function() {
		if(manager.Selection.contain == null) return;
		if(manager.Selection.actionType == "ground") this.graphicTile.changeGround(manager.Selection.contain); else if(manager.Selection.actionType == "build") this.graphicTile.changeBuild(manager.Selection.contain);
	}
	,mousequit: function() {
		if(manager.Selection.actionType == "ground") this.graphicTile.changeGround(this.currentAsset); else if(manager.Selection.actionType == "build") this.graphicTile.changeBuild(this.currentBuild);
	}
	,mouseClick: function() {
		if(manager.Selection.contain == null) return;
		if(manager.Selection.actionType == "ground") {
			this.currentAsset = manager.Selection.contain;
			this.graphicTile.changeGround(this.currentAsset);
		} else if(manager.Selection.actionType == "build") {
			this.currentBuild = manager.Selection.contain;
			this.graphicTile.changeBuild(this.currentBuild);
		}
	}
});
entities.biomeHud = {};
entities.biomeHud.Grass = function() {
	GameObject.call(this);
	this.addComponent("hudElement");
	this.hudElement.set(new utils.Vector2(0.1,0.1),new utils.Vector2(0.9,0.15),"ground","grass");
	this.hudElement.bindEvents($bind(this,this.mouseover),$bind(this,this.mousequit),$bind(this,this.mouseClick));
};
entities.biomeHud.Grass.__super__ = GameObject;
entities.biomeHud.Grass.prototype = $extend(GameObject.prototype,{
	mouseover: function() {
		this.hudElement.replace(new utils.Vector2(0.88,0.15));
	}
	,mousequit: function() {
		this.hudElement.replace(new utils.Vector2(0.9,0.15));
	}
	,mouseClick: function() {
		manager.Selection.actionType = "ground";
		manager.Selection.contain = "grass";
	}
});
entities.biomeHud.Water = function() {
	GameObject.call(this);
	this.addComponent("hudElement");
	this.hudElement.set(new utils.Vector2(0.1,0.1),new utils.Vector2(0.9,0.05),"ground","automn");
	this.hudElement.bindEvents($bind(this,this.mouseover),$bind(this,this.mousequit),$bind(this,this.mouseClick));
};
entities.biomeHud.Water.__super__ = GameObject;
entities.biomeHud.Water.prototype = $extend(GameObject.prototype,{
	mouseover: function() {
		this.hudElement.replace(new utils.Vector2(0.88,0.05));
	}
	,mousequit: function() {
		this.hudElement.replace(new utils.Vector2(0.9,0.05));
	}
	,mouseClick: function() {
		manager.Selection.actionType = "ground";
		manager.Selection.contain = "automn";
	}
});
entities.flowerHud = {};
entities.flowerHud.BrownFlower = function() {
	GameObject.call(this);
	this.addComponent("hudElement");
	this.hudElement.set(new utils.Vector2(0.1,0.1),new utils.Vector2(0.9,0.25),"ground","breaker");
	this.hudElement.bindEvents($bind(this,this.mouseover),$bind(this,this.mousequit),$bind(this,this.mouseClick));
};
entities.flowerHud.BrownFlower.__super__ = GameObject;
entities.flowerHud.BrownFlower.prototype = $extend(GameObject.prototype,{
	mouseover: function() {
		this.hudElement.replace(new utils.Vector2(0.88,0.25));
	}
	,mousequit: function() {
		this.hudElement.replace(new utils.Vector2(0.9,0.25));
	}
	,mouseClick: function() {
		manager.Selection.actionType = "build";
		manager.Selection.contain = "breaker";
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
	engine.isoEngine.components.Tile.setSize(128);
	init.Assets.isoEngine = engine.isoEngine.IsoEngine.getInstance();
	init.Assets.isoEngine.assets.load(["../assets/biomesAndBuilding.json"],init.Assets.assetLoaded);
};
init.Assets.assetLoaded = function() {
	init.Assets.isoEngine.assets.addTexture("grass","grass");
	init.Assets.isoEngine.assets.addTexture("automn","automn");
	init.Assets.isoEngine.assets.addTexture("swamp","swamp");
	init.Assets.isoEngine.assets.addTexture("savana","savana");
	init.Assets.isoEngine.assets.addTexture("breaker","breaker");
	var list = new Array();
	list.push("grass");
	list.push("automn");
	list.push("swamp");
	list.push("automn");
	list.push("breaker");
	init.Assets.isoEngine.assets.createAnimation("ground",list);
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
	if(engine.input.Keyboard.key.get("right")) engine.isoEngine.controls.Camera.move(-speed,0);
	if(engine.input.Keyboard.key.get("left")) engine.isoEngine.controls.Camera.move(speed,0);
	if(engine.input.Keyboard.key.get("up")) engine.isoEngine.controls.Camera.move(0,speed);
	if(engine.input.Keyboard.key.get("down")) engine.isoEngine.controls.Camera.move(0,-speed);
};
manager.Hud = function() { };
manager.Hud.init = function() {
	new entities.biomeHud.Water();
	new entities.biomeHud.Grass();
	new entities.flowerHud.BrownFlower();
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
manager.Selection = function() { };
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
engine.isoEngine.components.Tile.size = 64;
engine.isoEngine.controls.Mouse.status = "up";
manager.Selection.actionType = "ground";
manager.Selection.contain = "grass";
Main.main();
})();
