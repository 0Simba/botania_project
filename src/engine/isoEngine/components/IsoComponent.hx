package engine.isoEngine.components;

import utils.Vector2;
import engine.isoEngine.IsoEngine;
import pixi.display.DisplayObject;

class IsoComponent extends DragNDrop
{
    public var isoEngine:IsoEngine;

    public function new () {
        super();
        isoEngine = IsoEngine.getInstance();

    }

    public function replace (pos:Vector2, sizeOf:Vector2 = null) {
        var target = (sizeOf != null) ? sizeOf : new Vector2(isoEngine.width, isoEngine.height);

        displayObject.x = getRealPositionningValue(pos.x, pos.metaX, target.x);
        displayObject.y = getRealPositionningValue(pos.y, pos.metaY, target.y);
        displayObject.x = checkPositionningOfHimself(displayObject.x, pos.x, pos.metaX, displayObject.y);
        displayObject.y = checkPositionningOfHimself(displayObject.y, pos.y, pos.metaY, displayObject.x);
    }


    public function resize (size:Vector2, sizeOf:Vector2 = null) {
        var target = (sizeOf != null) ? sizeOf : new Vector2(isoEngine.width, isoEngine.height);

        displayObject.width  = getRealPositionningValue(size.x, size.metaX, target.x);
        displayObject.height = getRealPositionningValue(size.y, size.metaY, target.y);
        displayObject.width  = checkPositionningOfHimself(displayObject.width , size.x, size.metaX, displayObject.height);
        displayObject.height = checkPositionningOfHimself(displayObject.height, size.y, size.metaY, displayObject.width);
    }

    public function scale (value:Float, valueY:Float = null) {
        if (valueY == null) valueY = value;
        displayObject.scale.set(value, valueY);
    }

    private function getRealPositionningValue (value:Float, posType:String, referentValue:Float):Float {
        var finalValue:Float = 0;

        finalValue = value;
        if (posType == null) {
            if (value <= 1) finalValue *= referentValue;
        }
        else if (posType == "%")  finalValue = referentValue * value;
        else if (posType == "px") finalValue = value;

        return finalValue;
    }

    private function checkPositionningOfHimself (currentValue:Float, value:Float, posType:String, referentValue:Float):Float {
        if      (posType == null && value < 0 && value >= -1) return referentValue * value * -1;
        else if (posType == "%x" || posType == "%y")          return referentValue * value;
        else                                                  return currentValue;
    }

    public function show(){
        displayObject.visible = true;
    }
    public function hide(){
        displayObject.visible = false;
    }
}
