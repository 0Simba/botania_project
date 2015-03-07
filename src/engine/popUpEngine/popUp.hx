package engine.popUpEngine;

import utils.Vector2;
import engine.isoEngine.components.Hud;
import pixi.display.DisplayObjectContainer;
import engine.isoEngine.IsoEngine;
import engine.popUpEngine.Bloc;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.Text;

class PopUp extends engine.popUpEngine.Container
{

    public var contents:Array<Hud>;
    public var fixed:DisplayObjectContainer;
    public var scrollable:DisplayObjectContainer;

    public function new (_name:String, pos:Vector2, size:Vector2) {
        super(_name, "popUp", size);
        fixed      = isoEngine.displaying.createChildLayer("fixed" + name, name);

        layer.width  = size.x * isoEngine.width;
        layer.height = size.y * isoEngine.height;
        layer.x      = pos.x  * isoEngine.width;
        layer.y      = pos.y  * isoEngine.height;

        hide();
    }


    override public function addSomethingOn (target:Dynamic):Dynamic {
        return target.addOn(fixed, pxSize, name);
    }

    override public function show () {
        layer.visible = true;
        onShow();
    }

    override public function hide () {
        layer.visible = false;
    }


    public dynamic function onShow () {}
}
