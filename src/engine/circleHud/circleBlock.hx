package engine.circleHud;

import engine.circleHud.CircleElement;
import engine.isoEngine.IsoEngine;
import utils.MapManipulate;
import utils.Vector2;
import engine.circleHud.CirclesHudEngine;

import pixi.display.DisplayObjectContainer;

import engine.events.Events;

class CircleBlock
{
    public function addOnce (name:String, basicTexture:String, callback:Dynamic) {
        elements.set(name, new CircleElement(this, basicTexture, callback));
        replaceElements();
        return elements.get(name);
    }

    public function show (pos:Vector2, _targetShowed:Dynamic) {
        layer.x = pos.x;// + elementsRadius / 2;
        layer.y = pos.y;// - elementsRadius / 2;
        layer.visible = true;

        targetShowed = _targetShowed;
        onShow();
    }

    public function hide () {
        layer.visible = false;
    }

    dynamic public function onShow () {}


            /***** YOU DON'T CARE   *****/

    public  var layerName:String;
    public  var layer:DisplayObjectContainer;

    public var referent:Events;
    public var targetShowed:Dynamic;

    public var elementsRadius:Int;
    public var centerRadius:Int;

    public var elements:Map<String, CircleElement>;
    private var parent:CirclesHudEngine;



    public function replaceElements () {
        var list = MapManipulate.toArray(elements);

        var angle:Float = Math.PI * 2 / list.length;

        for (i in 0...list.length) {
            var x = Math.cos(angle * i) * (centerRadius);
            var y = Math.sin(angle * i) * (centerRadius);

            list[i].replace(new Vector2 (x, y));
            list[i].angle = angle * i;
        }
    }

    public function forEachElement (callback) {
        var list = MapManipulate.toArray(elements);

        for (i in 0...list.length) {
            callback(list[i]);
        }
    }


    public function new (_referent:Events, _centerRadius:Int, _elementsRadius:Int, _layerName:String) {
        referent       = _referent;
        centerRadius   = _centerRadius;
        elementsRadius = _elementsRadius;
        layerName      = _layerName;

        layer    = IsoEngine.getInstance().displaying.createChildLayer(layerName, "circleHud");
        elements = new Map<String, CircleElement>();

        parent = CirclesHudEngine.getInstance();

        // layer.beginFill(202020, 0.3);
        // layer.drawCircle(parent.offsetX, parent.offsetY, centerRadius);
        // layer.endFill();

        layer.visible = false;
    }
}
