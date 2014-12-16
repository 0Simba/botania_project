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
		Main.isoEngine.setMap(128,5,5,"isometricPattern.jpg");
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
var engine = {};
engine.isoEngine = {};
engine.isoEngine.IsoEngine = function(_width,_height) {
	this.stage = new PIXI.Stage(13619151);
	this.map = new Array();
	this.size = 0;
	this.width = _width;
	this.renderer = PIXI.autoDetectRenderer(this.width,_height);
	window.document.body.appendChild(this.renderer.view);
	this.camera = new PIXI.Graphics();
	console.log(this.width);
	this.camera.x += this.width / 2;
	this.camera.y += _height / 2;
	this.stage.addChild(this.camera);
};
engine.isoEngine.IsoEngine.prototype = {
	render: function() {
		this.renderer.render(this.stage);
	}
	,load: function(assets,callback) {
		var loader = new PIXI.AssetLoader(assets);
		loader.onComplete = callback;
		loader.load();
	}
	,setMap: function(_size,_width,height,defaultTexture) {
		var texture = new Array();
		texture.push(PIXI.Texture.fromFrame(defaultTexture));
		this.width = _width;
		this.size = _size;
		var demiSize = this.size / 2;
		var quartSize = demiSize / 2;
		var _g1 = 0;
		var _g = this.width * height;
		while(_g1 < _g) {
			var i = _g1++;
			var line = Math.floor(i / this.width);
			this.map[i] = new PIXI.MovieClip(texture);
			this.map[i].width = this.size;
			this.map[i].height = demiSize;
			var x = i % this.width;
			var y = Math.floor(i / this.width);
			this.map[i].x = x * demiSize - y * demiSize;
			this.map[i].y = x * quartSize + y * quartSize;
			this.camera.addChild(this.map[i]);
		}
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
Main.main();
})();
