(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var GameObject = function() {
};
GameObject.__name__ = ["GameObject"];
GameObject.prototype = {
	addComponent: function(name) {
		if(name == "graphicTile") this.graphicTile = new engine.isoEngine.components.Tile(); else if(name == "hudElement") this.hudElement = new engine.isoEngine.components.Hud();
	}
	,__class__: GameObject
};
var HxOverrides = function() { };
HxOverrides.__name__ = ["HxOverrides"];
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var Main = function() {
	Main.deltaTime = 0;
	engine.isoEngine.IsoEngine.init(1120,630);
	init.Assets.load();
	init.Config.load();
	console.log(init.Config.player);
};
Main.__name__ = ["Main"];
Main.ready = function() {
	Main.nbCall++;
	if(Main.nbCall == Main.nbAsynchronousCallback) {
		init.Map.load();
		init.PopUp.load();
		init.CircleHud.load();
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
	,__class__: Main
};
var IMap = function() { };
IMap.__name__ = ["IMap"];
Math.__name__ = ["Math"];
var Reflect = function() { };
Reflect.__name__ = ["Reflect"];
Reflect.field = function(o,field) {
	try {
		return o[field];
	} catch( e ) {
		return null;
	}
};
Reflect.fields = function(o) {
	var a = [];
	if(o != null) {
		var hasOwnProperty = Object.prototype.hasOwnProperty;
		for( var f in o ) {
		if(f != "__id__" && f != "hx__closures__" && hasOwnProperty.call(o,f)) a.push(f);
		}
	}
	return a;
};
var Std = function() { };
Std.__name__ = ["Std"];
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
};
var Type = function() { };
Type.__name__ = ["Type"];
Type.getClass = function(o) {
	if(o == null) return null;
	if((o instanceof Array) && o.__enum__ == null) return Array; else return o.__class__;
};
Type.getClassName = function(c) {
	var a = c.__name__;
	return a.join(".");
};
var engine = {};
engine.circleHud = {};
engine.circleHud.CircleBlock = function(_centerRadius,_elementsRadius,_layerName) {
	this.centerRadius = _centerRadius;
	this.elementsRadius = _elementsRadius;
	this.layerName = _layerName;
	this.layer = engine.isoEngine.IsoEngine.getInstance().displaying.createChildLayer(this.layerName,"circleHud");
	this.elements = new haxe.ds.StringMap();
	this.layer.visible = false;
};
engine.circleHud.CircleBlock.__name__ = ["engine","circleHud","CircleBlock"];
engine.circleHud.CircleBlock.prototype = {
	addOnce: function(name,basicTexture,hoverTexture,clickTexture) {
		var value = new engine.circleHud.CircleElement(this,name,basicTexture,hoverTexture,clickTexture);
		this.elements.set(name,value);
		this.replaceElements();
		return this.elements.get(name);
	}
	,replaceElements: function() {
		var list = utils.MapManipulate.toArray(this.elements);
		var angle = Math.PI * 2 / list.length;
		var _g1 = 0;
		var _g = list.length;
		while(_g1 < _g) {
			var i = _g1++;
			var x = Math.cos(angle * i) * this.centerRadius;
			var y = Math.sin(angle * i) * this.centerRadius;
			list[i].replace(new utils.Vector2(x,y));
		}
	}
	,show: function(pos) {
		this.layer.x = pos.x;
		this.layer.y = pos.y;
		this.layer.visible = true;
	}
	,hide: function() {
		this.layer.visible = false;
	}
	,__class__: engine.circleHud.CircleBlock
};
engine.circleHud.CircleElement = function(_parent,_name,_basicTexture,_hoverTexture,_clickTexture) {
	GameObject.call(this);
	this.parent = _parent;
	this.name = _name;
	this.basicTexture = _basicTexture;
	this.hoverTexture = _hoverTexture;
	this.clickTexture = _clickTexture;
	this.addComponent("hudElement");
	this.hudElement.set(new utils.Vector2(100,100),new utils.Vector2(0,0),"circleNavigation",this.basicTexture,this.parent.layerName);
	this.hudElement.resize(new utils.Vector2(this.parent.elementsRadius,this.parent.elementsRadius));
	this.hudElement.bindEvents($bind(this,this.over),$bind(this,this.out),$bind(this,this.click));
};
engine.circleHud.CircleElement.__name__ = ["engine","circleHud","CircleElement"];
engine.circleHud.CircleElement.__super__ = GameObject;
engine.circleHud.CircleElement.prototype = $extend(GameObject.prototype,{
	replace: function(pos) {
		this.hudElement.replace(pos,true);
	}
	,over: function() {
		this.hudElement.changeTexture(this.hoverTexture);
	}
	,out: function() {
		this.hudElement.changeTexture(this.basicTexture);
	}
	,click: function() {
		this.hudElement.changeTexture(this.clickTexture);
	}
	,__class__: engine.circleHud.CircleElement
});
engine.circleHud.CirclesHudEngine = function() {
	engine.circleHud.CirclesHudEngine.model = new haxe.ds.StringMap();
	engine.isoEngine.IsoEngine.getInstance().displaying.createChildLayer("circleHud","fx");
};
engine.circleHud.CirclesHudEngine.__name__ = ["engine","circleHud","CirclesHudEngine"];
engine.circleHud.CirclesHudEngine.getInstance = function() {
	if(engine.circleHud.CirclesHudEngine.instance == null) engine.circleHud.CirclesHudEngine.instance = new engine.circleHud.CirclesHudEngine();
	return engine.circleHud.CirclesHudEngine.instance;
};
engine.circleHud.CirclesHudEngine.prototype = {
	createModel: function(name,centerRadius,elementsRadius) {
		var value = new engine.circleHud.CircleBlock(centerRadius,elementsRadius,name);
		engine.circleHud.CirclesHudEngine.model.set(name,value);
		return engine.circleHud.CirclesHudEngine.model.get(name);
	}
	,__class__: engine.circleHud.CirclesHudEngine
};
engine.events = {};
engine.events.Events = function() {
	this.listeners = new haxe.ds.StringMap();
};
engine.events.Events.__name__ = ["engine","events","Events"];
engine.events.Events.prototype = {
	emit: function(name,data) {
		if(this.listeners.exists(name)) {
			var _g1 = 0;
			var _g = this.listeners.get(name).length;
			while(_g1 < _g) {
				var i = _g1++;
				this.listeners.get(name)[i](data);
			}
		}
	}
	,on: function(name,func) {
		if(!this.listeners.exists(name)) {
			var value = new Array();
			this.listeners.set(name,value);
		}
		this.listeners.get(name).push(func);
	}
	,__class__: engine.events.Events
};
engine.eventsDispatcher = {};
engine.eventsDispatcher.Event = function(pType) {
	this.type = pType;
};
engine.eventsDispatcher.Event.__name__ = ["engine","eventsDispatcher","Event"];
engine.eventsDispatcher.Event.prototype = {
	formatToString: function(pArgs) {
		var lTxt = "[" + Type.getClassName(Type.getClass(this));
		var _g1 = 0;
		var _g = pArgs.length;
		while(_g1 < _g) {
			var i = _g1++;
			lTxt += " " + pArgs[i] + "=" + Std.string(Reflect.field(this,pArgs[i]));
		}
		return lTxt + "]";
	}
	,toString: function() {
		return this.formatToString(["type"]);
	}
	,__class__: engine.eventsDispatcher.Event
};
engine.eventsDispatcher.EventDispatcher = function() {
	this.listeners = [];
};
engine.eventsDispatcher.EventDispatcher.__name__ = ["engine","eventsDispatcher","EventDispatcher"];
engine.eventsDispatcher.EventDispatcher.prototype = {
	get: function(pType,pListener) {
		var _g1 = 0;
		var _g = this.listeners.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(this.listeners[i].type == pType && this.listeners[i].listener == pListener) return i;
		}
		return -1;
	}
	,on: function(pType,pListener) {
		if(this._disposed) return;
		var lId = this.get(pType,pListener);
		if(lId == -1) this.listeners.push({ type : pType, listener : pListener, target : this, currentTarget : this});
	}
	,remove: function(pType,pListener) {
		if(this._disposed) return;
		var lId = this.get(pType,pListener);
		if(lId != -1) this.listeners.splice(lId,1);
	}
	,emit: function(pEvt) {
		var lDispatch = [];
		var _g1 = 0;
		var _g = this.listeners.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(this.listeners[i].type == pEvt.type) lDispatch.push(this.listeners[i]);
		}
		pEvt.currentTarget = this;
		pEvt.target = this;
		var _g11 = 0;
		var _g2 = lDispatch.length;
		while(_g11 < _g2) {
			var i1 = _g11++;
			lDispatch[i1].listener.apply(this,[pEvt]);
		}
	}
	,destroy: function(pEvent) {
		this.listeners = null;
		this._disposed = true;
	}
	,get_disposed: function() {
		return this._disposed;
	}
	,__class__: engine.eventsDispatcher.EventDispatcher
};
engine.input = {};
engine.input.KeyName = function() { };
engine.input.KeyName.__name__ = ["engine","input","KeyName"];
engine.input.KeyName.set = function() {
	engine.input.KeyName.list = new haxe.ds.IntMap();
	engine.input.KeyName.list.set(37,"left");
	engine.input.KeyName.list.set(38,"up");
	engine.input.KeyName.list.set(39,"right");
	engine.input.KeyName.list.set(40,"down");
};
engine.input.Keyboard = function() { };
engine.input.Keyboard.__name__ = ["engine","input","Keyboard"];
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
engine.isoEngine.IsoEngine.__name__ = ["engine","isoEngine","IsoEngine"];
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
		this.assets = new engine.isoEngine.managers.Assets();
		this.tileIndicator = new engine.isoEngine.managers.TileSelectionIndicator();
		this.displaying = new engine.isoEngine.managers.Displaying(this.stage);
		this.events = new engine.eventsDispatcher.EventDispatcher();
		engine.isoEngine.controls.Mouse.setRef(this.stage);
		engine.isoEngine.controls.Camera.setRef(this);
	}
	,destroy: function() {
		engine.isoEngine.IsoEngine.instance = null;
	}
	,render: function() {
		this.renderer.render(this.stage);
	}
	,__class__: engine.isoEngine.IsoEngine
};
engine.isoEngine.IsoUtils = function() { };
engine.isoEngine.IsoUtils.__name__ = ["engine","isoEngine","IsoUtils"];
engine.isoEngine.IsoUtils.coordToPx = function(x,y) {
	var px = new utils.Vector2(0,0);
	px.x = x * engine.isoEngine.components.Tile.size / 2 - y * engine.isoEngine.components.Tile.size / 2;
	px.y = x * engine.isoEngine.components.Tile.size / 4 + y * engine.isoEngine.components.Tile.size / 4;
	return px;
};
engine.isoEngine.components = {};
engine.isoEngine.components.Hud = function() {
	this.isoEngine = engine.isoEngine.IsoEngine.getInstance();
	if(!engine.isoEngine.components.Hud.isBinded) engine.isoEngine.components.Hud.bindToCamera();
};
engine.isoEngine.components.Hud.__name__ = ["engine","isoEngine","components","Hud"];
engine.isoEngine.components.Hud.bindToCamera = function() {
	engine.isoEngine.controls.Mouse.addOnClickEvent(engine.isoEngine.components.Hud.onClick);
};
engine.isoEngine.components.Hud.onClick = function() {
	if(engine.isoEngine.components.Hud.currentOver != null) engine.isoEngine.components.Hud.currentOver.clickBind();
};
engine.isoEngine.components.Hud.prototype = {
	set: function(percentSize,percentPos,animationName,textureName,parentLayer) {
		if(parentLayer == null) parentLayer = "hud";
		this.movieClip = new PIXI.MovieClip(this.isoEngine.assets.animations.get(animationName));
		this.resize(percentSize);
		this.replace(percentPos);
		if(textureName != null) this.changeTexture(textureName);
		this.isoEngine.displaying.displayMcOn(this.movieClip,parentLayer);
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
	,replace: function(pos,forcePixel) {
		if(forcePixel == null) forcePixel = false;
		if(pos.x > 1 || pos.y > 1 || forcePixel) {
			this.movieClip.x = pos.x;
			this.movieClip.y = pos.y;
		} else {
			this.movieClip.x = this.isoEngine.width * pos.x;
			this.movieClip.y = this.isoEngine.height * pos.y;
		}
	}
	,resize: function(size,forcePixel) {
		if(forcePixel == null) forcePixel = false;
		if(size.x > 1 || size.y > 1 || forcePixel) {
			this.movieClip.width = size.x;
			this.movieClip.height = size.y;
		} else {
			this.movieClip.width = this.isoEngine.width * size.x;
			this.movieClip.height = this.isoEngine.height * size.y;
		}
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
	}
	,alwaysOver: function(mouseData) {
		engine.isoEngine.components.Hud.currentOver = this;
		this.overBind();
	}
	,alwaysOut: function(mouseData) {
		engine.isoEngine.components.Hud.currentOver = null;
		this.outBind();
	}
	,__class__: engine.isoEngine.components.Hud
};
engine.isoEngine.components.Tile = function() {
	engine.isoEngine.components.Tile.isoEngine = engine.isoEngine.IsoEngine.getInstance();
	this.isInteractive = false;
};
engine.isoEngine.components.Tile.__name__ = ["engine","isoEngine","components","Tile"];
engine.isoEngine.components.Tile.setSize = function(_size) {
	engine.isoEngine.components.Tile.size = _size;
};
engine.isoEngine.components.Tile.prototype = {
	addGround: function(name) {
		this.ground = new PIXI.MovieClip(engine.isoEngine.components.Tile.isoEngine.assets.animations.get(name));
		this.ground.width = engine.isoEngine.components.Tile.size;
		this.ground.height = engine.isoEngine.components.Tile.size / 2;
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
		var layerNumber = this.coord.x + this.coord.y;
		var layerName = "buildingHeight" + layerNumber;
		engine.isoEngine.components.Tile.isoEngine.displaying.displayMcOn(this.building,layerName);
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
		engine.isoEngine.components.Tile.isoEngine.displaying.displayMcOn(this.ground,"tiles");
	}
	,setPlace: function(_x,_y,_i) {
		this.coord = new utils.ArrayCoord(_x,_y,_i);
		this.place(_x,_y);
		if(this.coord.i >= 0) engine.isoEngine.components.Tile.isoEngine.map.addTile(this);
	}
	,setInteractive: function(_mouseEnter,_mouseExit,_mouseClick) {
		this.personalMouseEnter = _mouseEnter;
		this.personalMouseExit = _mouseExit;
		this.personalMouseClick = _mouseClick;
		this.isInteractive = true;
	}
	,mouseEnter: function() {
		this.personalMouseEnter();
	}
	,mouseExit: function() {
		this.personalMouseExit();
	}
	,mouseClick: function() {
		this.personalMouseClick();
	}
	,personalMouseEnter: function() {
	}
	,personalMouseExit: function() {
	}
	,personalMouseClick: function() {
	}
	,__class__: engine.isoEngine.components.Tile
};
engine.isoEngine.controls = {};
engine.isoEngine.controls.Camera = function() { };
engine.isoEngine.controls.Camera.__name__ = ["engine","isoEngine","controls","Camera"];
engine.isoEngine.controls.Camera.move = function(x,y) {
	if(y == null) y = 0;
	if(x == null) x = 0;
	engine.isoEngine.controls.Camera.camera.x += x;
	engine.isoEngine.controls.Camera.camera.y += y;
};
engine.isoEngine.controls.Camera.onClick = function() {
	var tile = engine.isoEngine.controls.Camera.isoEngine.map.getTile(engine.isoEngine.controls.Camera.currentPos.x,engine.isoEngine.controls.Camera.currentPos.y);
	if(tile != null) tile.mouseClick();
};
engine.isoEngine.controls.Camera.setRef = function(peonWhileTrue) {
	engine.isoEngine.controls.Camera.isoEngine = peonWhileTrue;
	engine.isoEngine.controls.Camera.camera = engine.isoEngine.controls.Camera.isoEngine.displaying.getCamera();
	engine.isoEngine.controls.Camera.currentPos = new utils.Vector2(-1,-1);
	engine.isoEngine.controls.Camera.setMouse();
};
engine.isoEngine.controls.Camera.setMouse = function() {
	engine.isoEngine.controls.Camera.camera.interactive = true;
	engine.isoEngine.controls.Camera.camera.mousemove = engine.isoEngine.controls.Camera.mousemove;
	engine.isoEngine.controls.Mouse.addOnClickEvent(engine.isoEngine.controls.Camera.onClick);
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
engine.isoEngine.controls.Mouse = function() { };
engine.isoEngine.controls.Mouse.__name__ = ["engine","isoEngine","controls","Mouse"];
engine.isoEngine.controls.Mouse.onClick = function() {
	var _g1 = 0;
	var _g = engine.isoEngine.controls.Mouse.onClickCallback.length;
	while(_g1 < _g) {
		var i = _g1++;
		engine.isoEngine.controls.Mouse.onClickCallback[i]();
	}
};
engine.isoEngine.controls.Mouse.addOnClickEvent = function(callback) {
	engine.isoEngine.controls.Mouse.onClickCallback.push(callback);
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
engine.isoEngine.managers.Assets = function() {
	this.textures = new haxe.ds.StringMap();
	this.animations = new haxe.ds.StringMap();
};
engine.isoEngine.managers.Assets.__name__ = ["engine","isoEngine","managers","Assets"];
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
	,__class__: engine.isoEngine.managers.Assets
};
engine.isoEngine.managers.Displaying = function(_stage) {
	this.layers = new haxe.ds.StringMap();
	this.stage = _stage;
	this.createMainLayer("background");
	this.createMainLayer("camera");
	this.createMainLayer("fx");
	this.createMainLayer("foreground");
	this.createMainLayer("hud");
	this.createMainLayer("overlay");
	this.createChildLayer("tiles","camera");
	this.createChildLayer("overTiles","camera");
};
engine.isoEngine.managers.Displaying.__name__ = ["engine","isoEngine","managers","Displaying"];
engine.isoEngine.managers.Displaying.prototype = {
	displayMcOn: function(mc,layer) {
		if(this.layers.exists(layer)) this.layers.get(layer).addChild(mc); else console.log("Le layer " + layer + " n'existe pas");
	}
	,createChildLayer: function(name,parent) {
		if(this.layers.get(name) == null) {
			var layer = new PIXI.Graphics();
			this.layers.get(parent).addChild(layer);
			this.layers.set(name,layer);
			return layer;
		}
		return null;
	}
	,getCamera: function() {
		return this.layers.get("camera");
	}
	,createMainLayer: function(name) {
		var layer = new PIXI.Graphics();
		this.stage.addChild(layer);
		this.layers.set(name,layer);
	}
	,__class__: engine.isoEngine.managers.Displaying
};
engine.isoEngine.managers.Maping = function() {
	this.tiles = new Array();
};
engine.isoEngine.managers.Maping.__name__ = ["engine","isoEngine","managers","Maping"];
engine.isoEngine.managers.Maping.prototype = {
	getTile: function(x,y) {
		if(this.tiles[x] != null) return this.tiles[x][y];
		return null;
	}
	,addTile: function(tile) {
		if(this.tiles[tile.coord.x] == null) this.tiles[tile.coord.x] = new Array();
		this.tiles[tile.coord.x][tile.coord.y] = tile;
	}
	,__class__: engine.isoEngine.managers.Maping
};
engine.isoEngine.managers.TileSelectionIndicator = function() {
};
engine.isoEngine.managers.TileSelectionIndicator.__name__ = ["engine","isoEngine","managers","TileSelectionIndicator"];
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
	,__class__: engine.isoEngine.managers.TileSelectionIndicator
};
engine.popUpEngine = {};
engine.popUpEngine.PopUp = function(size,pos,animation,texture) {
	GameObject.call(this);
	this.addComponent("hudElement");
	this.hudElement.set(size,pos,animation,texture);
};
engine.popUpEngine.PopUp.__name__ = ["engine","popUpEngine","PopUp"];
engine.popUpEngine.PopUp.__super__ = GameObject;
engine.popUpEngine.PopUp.prototype = $extend(GameObject.prototype,{
	addYesNo: function() {
	}
	,hide: function() {
	}
	,show: function() {
	}
	,__class__: engine.popUpEngine.PopUp
});
engine.popUpEngine.PopUpEngineMain = function() {
	this.popUps = new haxe.ds.StringMap();
};
engine.popUpEngine.PopUpEngineMain.__name__ = ["engine","popUpEngine","PopUpEngineMain"];
engine.popUpEngine.PopUpEngineMain.getInstance = function() {
	if(engine.popUpEngine.PopUpEngineMain.instance == null) engine.popUpEngine.PopUpEngineMain.instance = new engine.popUpEngine.PopUpEngineMain();
	return engine.popUpEngine.PopUpEngineMain.instance;
};
engine.popUpEngine.PopUpEngineMain.prototype = {
	create: function(name,size,pos,animation,texture) {
		var popUp = new engine.popUpEngine.PopUp(size,pos,animation,texture);
		this.popUps.set(name,popUp);
		return popUp;
	}
	,__class__: engine.popUpEngine.PopUpEngineMain
};
var entities = {};
entities.Flower = function(_referent,_state) {
	if(_state == null) _state = 0;
	this.timeToBeAdult = 5;
	this.referent = _referent;
	this.stateIndex = _state;
	this.referent.emit("state changed",entities.Flower.stateList[this.stateIndex]);
	haxe.Timer.delay($bind(this,this.endDelay),2000);
};
entities.Flower.__name__ = ["entities","Flower"];
entities.Flower.prototype = {
	endDelay: function() {
		this.stateIndex++;
		this.referent.emit("state changed",entities.Flower.stateList[this.stateIndex]);
		if(entities.Flower.stateList.length - 1 > this.stateIndex) haxe.Timer.delay($bind(this,this.endDelay),2000);
	}
	,__class__: entities.Flower
};
entities.Tile = function() {
	this.currentBuild = null;
	this.currentGround = "grass";
	var _g = this;
	GameObject.call(this);
	this.addComponent("graphicTile");
	this.graphicTile.addGround("ground");
	this.graphicTile.setInteractive($bind(this,this.mouseover),$bind(this,this.mousequit),$bind(this,this.mouseClick));
	this.buildingEvents = new engine.events.Events();
	this.buildingEvents.on("state changed",function(state) {
		_g.graphicTile.changeBuild(state + "Flower");
	});
};
entities.Tile.__name__ = ["entities","Tile"];
entities.Tile.__super__ = GameObject;
entities.Tile.prototype = $extend(GameObject.prototype,{
	createFlower: function() {
		this.currentBuild = "flower";
		this.flowerRef = new entities.Flower(this.buildingEvents);
	}
	,mouseover: function() {
		if(manager.Selection.contain == null) return;
		if(manager.Selection.actionType == "ground") this.graphicTile.changeGround(manager.Selection.contain); else if(manager.Selection.actionType == "build" && this.currentBuild == null) this.graphicTile.changeBuild(manager.Selection.contain);
	}
	,mousequit: function() {
		if(manager.Selection.actionType == "ground") this.graphicTile.changeGround(this.currentGround); else if(manager.Selection.actionType == "build" && this.currentBuild == null) this.graphicTile.changeBuild(this.currentBuild);
	}
	,mouseClick: function() {
		if(manager.Selection.contain == null) return;
		if(manager.Selection.actionType == "ground") {
			this.currentGround = manager.Selection.contain;
			this.graphicTile.changeGround(this.currentGround);
		} else if(manager.Selection.actionType == "build" && this.currentBuild == null) this.createFlower();
	}
	,__class__: entities.Tile
});
entities.biomeHud = {};
entities.biomeHud.Grass = function() {
	GameObject.call(this);
	this.addComponent("hudElement");
	this.hudElement.set(new utils.Vector2(0.1,0.1),new utils.Vector2(0.9,0.15),"ground","grass");
	this.hudElement.bindEvents($bind(this,this.mouseover),$bind(this,this.mousequit),$bind(this,this.mouseClick));
};
entities.biomeHud.Grass.__name__ = ["entities","biomeHud","Grass"];
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
	,__class__: entities.biomeHud.Grass
});
entities.biomeHud.Water = function() {
	GameObject.call(this);
	this.addComponent("hudElement");
	this.hudElement.set(new utils.Vector2(0.1,0.1),new utils.Vector2(0.9,0.05),"ground","automn");
	this.hudElement.bindEvents($bind(this,this.mouseover),$bind(this,this.mousequit),$bind(this,this.mouseClick));
};
entities.biomeHud.Water.__name__ = ["entities","biomeHud","Water"];
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
	,__class__: entities.biomeHud.Water
});
entities.flowerHud = {};
entities.flowerHud.BrownFlower = function() {
	GameObject.call(this);
	this.addComponent("hudElement");
	this.hudElement.set(new utils.Vector2(0.1,0.1),new utils.Vector2(0.9,0.25),"ground","breaker");
	this.hudElement.bindEvents($bind(this,this.mouseover),$bind(this,this.mousequit),$bind(this,this.mouseClick));
};
entities.flowerHud.BrownFlower.__name__ = ["entities","flowerHud","BrownFlower"];
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
	,__class__: entities.flowerHud.BrownFlower
});
entities.flowerHud.TestFlower = function() {
	GameObject.call(this);
	this.addComponent("hudElement");
	this.hudElement.set(new utils.Vector2(0.1,0.1),new utils.Vector2(0.9,0.35),"ground","adultFlower");
	this.hudElement.bindEvents($bind(this,this.mouseover),$bind(this,this.mousequit),$bind(this,this.mouseClick));
};
entities.flowerHud.TestFlower.__name__ = ["entities","flowerHud","TestFlower"];
entities.flowerHud.TestFlower.__super__ = GameObject;
entities.flowerHud.TestFlower.prototype = $extend(GameObject.prototype,{
	mouseover: function() {
		this.hudElement.replace(new utils.Vector2(0.88,0.35));
	}
	,mousequit: function() {
		this.hudElement.replace(new utils.Vector2(0.9,0.35));
	}
	,mouseClick: function() {
		manager.Selection.actionType = "build";
		manager.Selection.contain = "adultFlower";
	}
	,__class__: entities.flowerHud.TestFlower
});
var haxe = {};
haxe.Timer = function(time_ms) {
	var me = this;
	this.id = setInterval(function() {
		me.run();
	},time_ms);
};
haxe.Timer.__name__ = ["haxe","Timer"];
haxe.Timer.delay = function(f,time_ms) {
	var t = new haxe.Timer(time_ms);
	t.run = function() {
		t.stop();
		f();
	};
	return t;
};
haxe.Timer.prototype = {
	stop: function() {
		if(this.id == null) return;
		clearInterval(this.id);
		this.id = null;
	}
	,run: function() {
	}
	,__class__: haxe.Timer
};
haxe.ds = {};
haxe.ds.IntMap = function() {
	this.h = { };
};
haxe.ds.IntMap.__name__ = ["haxe","ds","IntMap"];
haxe.ds.IntMap.__interfaces__ = [IMap];
haxe.ds.IntMap.prototype = {
	set: function(key,value) {
		this.h[key] = value;
	}
	,get: function(key) {
		return this.h[key];
	}
	,__class__: haxe.ds.IntMap
};
haxe.ds.StringMap = function() {
	this.h = { };
};
haxe.ds.StringMap.__name__ = ["haxe","ds","StringMap"];
haxe.ds.StringMap.__interfaces__ = [IMap];
haxe.ds.StringMap.prototype = {
	set: function(key,value) {
		this.h["$" + key] = value;
	}
	,get: function(key) {
		return this.h["$" + key];
	}
	,exists: function(key) {
		return this.h.hasOwnProperty("$" + key);
	}
	,keys: function() {
		var a = [];
		for( var key in this.h ) {
		if(this.h.hasOwnProperty(key)) a.push(key.substr(1));
		}
		return HxOverrides.iter(a);
	}
	,iterator: function() {
		return { ref : this.h, it : this.keys(), hasNext : function() {
			return this.it.hasNext();
		}, next : function() {
			var i = this.it.next();
			return this.ref["$" + i];
		}};
	}
	,__class__: haxe.ds.StringMap
};
var init = {};
init.Assets = function() { };
init.Assets.__name__ = ["init","Assets"];
init.Assets.load = function() {
	engine.isoEngine.components.Tile.setSize(128);
	init.Assets.isoEngine = engine.isoEngine.IsoEngine.getInstance();
	init.Assets.isoEngine.assets.load(["../assets/biomesAndBuilding.json","../assets/circleNavigation.json"],init.Assets.assetLoaded);
	init.Assets.biomesAndBuildingData = new PIXI.JsonLoader("../assets/biomesAndBuilding.json");
	init.Assets.biomesAndBuildingData.addEventListener("loaded",function(pEvent) {
		init.Assets.preloadAssets(pEvent,init.Assets.biomesAndBuildingData,"ground");
	});
	init.Assets.biomesAndBuildingData.load();
	init.Assets.circleNavigation = new PIXI.JsonLoader("../assets/circleNavigation.json");
	init.Assets.circleNavigation.addEventListener("loaded",function(pEvent1) {
		init.Assets.preloadAssets(pEvent1,init.Assets.circleNavigation,"circleNavigation");
	});
	init.Assets.circleNavigation.load();
};
init.Assets.preloadAssets = function(pEvent,target,animationName) {
	target.removeEventListener("loaded",init.Assets.preloadAssets);
	var myData = (js.Boot.__cast(pEvent.target , PIXI.JsonLoader)).json.frames;
	var list = new Array();
	var _g = 0;
	var _g1 = Reflect.fields(myData);
	while(_g < _g1.length) {
		var n = _g1[_g];
		++_g;
		list.push(n);
		init.Assets.isoEngine.assets.addTexture(n,n);
	}
	init.Assets.isoEngine.assets.createAnimation(animationName,list);
	init.Assets.assetLoaded();
};
init.Assets.assetLoaded = function() {
	init.Assets.nbLoaded++;
	if(init.Assets.nbLoaded >= init.Assets.nbToLoad) Main.ready();
};
init.CircleHud = function() { };
init.CircleHud.__name__ = ["init","CircleHud"];
init.CircleHud.load = function() {
	var circleHudEngine = engine.circleHud.CirclesHudEngine.getInstance();
	var flowerHud = circleHudEngine.createModel("flower",128,128);
	flowerHud.addOnce("pick","pickBasic","pickHover","pickClick");
	flowerHud.addOnce("dig","digBasic","digHover","digClick");
	flowerHud.addOnce("water","waterBasic","waterHover","waterClick");
	flowerHud.addOnce("fertilizer","fertilizerBasic","fertilizerHover","fertilizerClick");
	flowerHud.show(new utils.Vector2(150,200));
};
init.Config = function() { };
init.Config.__name__ = ["init","Config"];
init.Config.load = function() {
	var _g = 0;
	var _g1 = Reflect.fields(init.Config);
	while(_g < _g1.length) {
		var key = [_g1[_g]];
		++_g;
		var path = Reflect.field(init.Config,key[0]);
		if(path == "toLoad") {
			console.log(key[0]);
			var tempSourceFiles = new PIXI.JsonLoader(init.Config.sourceFilesPath + key[0] + ".json");
			tempSourceFiles.addEventListener("loaded",(function(key) {
				return function(pEvent) {
					init.Config.onLoadComplete(pEvent,key[0]);
				};
			})(key));
			tempSourceFiles.load();
		}
	}
};
init.Config.onLoadComplete = function(pEvent,targetKey) {
	var tempDatas = (js.Boot.__cast(pEvent.target , PIXI.JsonLoader)).json;
	var file = (js.Boot.__cast(pEvent.target , PIXI.JsonLoader)).json;
	init.Config[targetKey] = tempDatas;
};
init.Map = function() { };
init.Map.__name__ = ["init","Map"];
init.Map.load = function() {
	var map = manager.Map.getInstance();
	map.set(10,10);
};
init.PopUp = function() { };
init.PopUp.__name__ = ["init","PopUp"];
init.PopUp.load = function() {
	var popUp = engine.popUpEngine.PopUpEngineMain.getInstance();
};
var js = {};
js.Boot = function() { };
js.Boot.__name__ = ["js","Boot"];
js.Boot.getClass = function(o) {
	if((o instanceof Array) && o.__enum__ == null) return Array; else return o.__class__;
};
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) str += "," + js.Boot.__string_rec(o[i],s); else str += js.Boot.__string_rec(o[i],s);
				}
				return str + ")";
			}
			var l = o.length;
			var i1;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js.Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str2 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str2.length != 2) str2 += ", \n";
		str2 += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str2 += "\n" + s + "}";
		return str2;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
js.Boot.__interfLoop = function(cc,cl) {
	if(cc == null) return false;
	if(cc == cl) return true;
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0;
		var _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js.Boot.__interfLoop(i1,cl)) return true;
		}
	}
	return js.Boot.__interfLoop(cc.__super__,cl);
};
js.Boot.__instanceof = function(o,cl) {
	if(cl == null) return false;
	switch(cl) {
	case Int:
		return (o|0) === o;
	case Float:
		return typeof(o) == "number";
	case Bool:
		return typeof(o) == "boolean";
	case String:
		return typeof(o) == "string";
	case Array:
		return (o instanceof Array) && o.__enum__ == null;
	case Dynamic:
		return true;
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(o instanceof cl) return true;
				if(js.Boot.__interfLoop(js.Boot.getClass(o),cl)) return true;
			}
		} else return false;
		if(cl == Class && o.__name__ != null) return true;
		if(cl == Enum && o.__ename__ != null) return true;
		return o.__enum__ == cl;
	}
};
js.Boot.__cast = function(o,t) {
	if(js.Boot.__instanceof(o,t)) return o; else throw "Cannot cast " + Std.string(o) + " to " + Std.string(t);
};
var manager = {};
manager.CameraManager = function() { };
manager.CameraManager.__name__ = ["manager","CameraManager"];
manager.CameraManager.update = function() {
	var speed = 20 * Main.deltaTime;
	if(engine.input.Keyboard.key.get("right")) engine.isoEngine.controls.Camera.move(-speed,0);
	if(engine.input.Keyboard.key.get("left")) engine.isoEngine.controls.Camera.move(speed,0);
	if(engine.input.Keyboard.key.get("up")) engine.isoEngine.controls.Camera.move(0,speed);
	if(engine.input.Keyboard.key.get("down")) engine.isoEngine.controls.Camera.move(0,-speed);
};
manager.Hud = function() { };
manager.Hud.__name__ = ["manager","Hud"];
manager.Hud.init = function() {
	new entities.biomeHud.Water();
	new entities.biomeHud.Grass();
	new entities.flowerHud.BrownFlower();
	new entities.flowerHud.TestFlower();
};
manager.Map = function() {
	this.tiles = new Array();
	manager.Map.alreadySet = false;
	this.isoEngine = engine.isoEngine.IsoEngine.getInstance();
	this.bindEvents();
};
manager.Map.__name__ = ["manager","Map"];
manager.Map.getInstance = function() {
	if(manager.Map.instance == null) manager.Map.instance = new manager.Map();
	return manager.Map.instance;
};
manager.Map.prototype = {
	set: function(nbCols,nbRows) {
		if(this.isAlreadySet()) return;
		this.addLayer(nbRows + nbCols);
		var _g1 = 0;
		var _g = nbCols * nbRows;
		while(_g1 < _g) {
			var i = _g1++;
			this.tiles[i] = new entities.Tile();
			var x = i % nbCols;
			var y = Math.floor(i / nbCols);
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
	,tileOn: function() {
	}
	,tileOut: function() {
	}
	,tileClick: function() {
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
	,addLayer: function(nb) {
		var _g = 0;
		while(_g < nb) {
			var i = _g++;
			this.isoEngine.displaying.createChildLayer("buildingHeight" + i,"overTiles");
		}
	}
	,bindEvents: function() {
	}
	,__class__: manager.Map
};
manager.Selection = function() { };
manager.Selection.__name__ = ["manager","Selection"];
var utils = {};
utils.ArrayCoord = function(_x,_y,_i) {
	if(_x == null) _x = 0;
	this.x = _x;
	this.y = _y;
	this.i = _i;
};
utils.ArrayCoord.__name__ = ["utils","ArrayCoord"];
utils.ArrayCoord.prototype = {
	__class__: utils.ArrayCoord
};
utils.MapManipulate = function() { };
utils.MapManipulate.__name__ = ["utils","MapManipulate"];
utils.MapManipulate.toArray = function(map) {
	var keyArr = new Array();
	var $it0 = map.iterator();
	while( $it0.hasNext() ) {
		var key = $it0.next();
		keyArr.push(key);
	}
	return keyArr;
};
utils.Vector2 = function(_x,_y) {
	if(_x == null) _x = 0;
	this.x = _x;
	this.y = _y;
};
utils.Vector2.__name__ = ["utils","Vector2"];
utils.Vector2.prototype = {
	__class__: utils.Vector2
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
String.prototype.__class__ = String;
String.__name__ = ["String"];
Array.__name__ = ["Array"];
Date.prototype.__class__ = Date;
Date.__name__ = ["Date"];
var Int = { __name__ : ["Int"]};
var Dynamic = { __name__ : ["Dynamic"]};
var Float = Number;
Float.__name__ = ["Float"];
var Bool = Boolean;
Bool.__ename__ = ["Bool"];
var Class = { __name__ : ["Class"]};
var Enum = { };
Main.nbAsynchronousCallback = 1;
Main.nbCall = 0;
engine.isoEngine.components.Hud.isBinded = false;
engine.isoEngine.components.Tile.size = 64;
engine.isoEngine.controls.Mouse.onClickCallback = new Array();
engine.isoEngine.controls.Mouse.status = "up";
entities.Flower.stateList = ["baby","child","teenage","adult"];
init.Assets.nbToLoad = 3;
init.Assets.nbLoaded = 0;
init.Config.sourceFilesPath = "../assets/json/config/";
init.Config.player = "toLoad";
init.Config.currencies = "toLoad";
init.Config.translate = "toLoad";
manager.Selection.actionType = "ground";
manager.Selection.contain = "grass";
Main.main();
})();
