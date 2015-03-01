package engine.popUpEngine;

import utils.Vector2;
import engine.isoEngine.components.Hud;
import pixi.display.DisplayObjectContainer;
import engine.isoEngine.IsoEngine;
import engine.popUpEngine.Bloc;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.Inventory;
import engine.popUpEngine.Text;

class PopUp extends engine.popUpEngine.Container
{

    public var contents:Array<Hud>;
    public var fixed:DisplayObjectContainer;
    public var scrollable:DisplayObjectContainer;

    public var inventory:Inventory;

    public function new (_name:String, pos:Vector2, size:Vector2) {
        super(_name, "popUp", size);
        fixed      = isoEngine.displaying.createChildLayer("fixed" + name, name);

        layer.width  = size.x * isoEngine.width;
        layer.height = size.y * isoEngine.height;
        layer.x      = pos.x  * isoEngine.width;
        layer.y      = pos.y  * isoEngine.height;

        hide();
    }

    public function setInventory (pos:Vector2, size:Vector2, _elementsSize:Vector2, _nbElementX:Int = -1, _nbElementY:Int = -1) {
        pos.x *= pxSize.x;
        pos.y *= pxSize.y;

        size.x *= pxSize.x;
        size.y *= pxSize.y;

        _elementsSize.x *= size.x;
        _elementsSize.y *= size.y;

        inventory = new Inventory(this, pos, size, _elementsSize, _nbElementX, _nbElementY);
        return inventory;
    }


    override public function addSomethingOn (target:Dynamic):Dynamic {
        return target.addOn(fixed, pxSize, name);
    }

    public function show () {
        layer.visible = true;
        onShow();
    }

    public function hide () {
        layer.visible = false;
    }


    public dynamic function onShow () {}
}
