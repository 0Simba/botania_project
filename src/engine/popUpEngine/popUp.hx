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
static private var popUpMain:PopUpEngineMain;

    public var contents:Array<Hud>;
    public var fixed:DisplayObjectContainer;
    public var scrollable:DisplayObjectContainer;

    private var popUpEnigneMain:PopUpEngineMain;
    private var popUpName:String;

    public function new (_name:String, pos:Vector2, size:Vector2) {
        popUpName = _name;
        super(_name, "popUp", size);
        fixed      = isoEngine.displaying.createChildLayer("fixed" + name, name);

        layer.width  = size.x * isoEngine.width;
        layer.height = size.y * isoEngine.height;
        layer.x      = pos.x  * isoEngine.width;
        layer.y      = pos.y  * isoEngine.height;

        hide();
        popUpEngineMain = PopUpEngineMain.getInstance();
        popUpEngineMain.addPopUp(_name, this);
    }


    override public function addSomethingOn (target:Dynamic):Dynamic {
        return target.addOn(fixed, pxSize, name);
    }

    override public function show () {
        layer.visible = true;
        onShow();
    }

    override public function hide () {
        trace('on ferme');
        trace(popUpName);
        layer.visible = false;
        popUpEngineMain.emit('close', popUpName);
        onHide();
    }

    public function emit (name:String, data:Dynamic) {
        popUpEngineMain.emit(name, data);
    } 



    public dynamic function onShow () {}
    public dynamic function onHide () {}
}
