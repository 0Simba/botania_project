package engine.circleHud;

import engine.circleHud.CircleElement;
import engine.isoEngine.IsoEngine;
import utils.MapManipulate;
import utils.Vector2;
import engine.circleHud.CirclesHudEngine;

import pixi.primitives.Graphics;

class CircleBlock
{

    public  var layerName:String;
    public  var layer:Graphics;
    public  var elementsRadius:Int;
    private var centerRadius:Int;
    private var elements:Map<String, CircleElement>;
    private var parent:CirclesHudEngine;

    public function new (_centerRadius:Int, _elementsRadius:Int, _layerName:String) {
        centerRadius   = _centerRadius;
        elementsRadius = _elementsRadius;
        layerName      = _layerName;

        layer    = IsoEngine.getInstance().displaying.createChildLayer(layerName, "circleHud");
        elements = new Map<String, CircleElement>();

        parent = CirclesHudEngine.getInstance();

        layer.beginFill(202020, 0.3);
        layer.drawCircle(parent.offsetX, parent.offsetY, centerRadius);
        layer.endFill();

        layer.visible = false;
    }

    public function addOnce (name:String, basicTexture:String, hoverTexture:String, clickTexture:String) {
        elements.set(name, new CircleElement(this, name, basicTexture, hoverTexture, clickTexture));
        replaceElements ();
        return elements.get(name);
    }

    public function replaceElements () {
        var list = MapManipulate.toArray(elements);

        var angle:Float = Math.PI * 2 / list.length;

        for (i in 0...list.length) {
            var x = Math.cos(angle * i) * (centerRadius);
            var y = Math.sin(angle * i) * (centerRadius);

            list[i].replace(new Vector2 (x + parent.offsetX - elementsRadius / 2, y + parent.offsetY - elementsRadius / 2));
        }
    }

    public function show (pos:Vector2) {
        layer.x = pos.x;
        layer.y = pos.y;
        layer.visible = true;
    }

    public function hide () {
        layer.visible = false;
    }

}
