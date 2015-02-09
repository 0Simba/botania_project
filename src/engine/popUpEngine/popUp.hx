package engine.popUpEngine;

import utils.Vector2;
import engine.isoEngine.components.Hud;
import pixi.display.DisplayObjectContainer;
import engine.isoEngine.IsoEngine;
import engine.popUpEngine.Bloc;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.Inventory;
import engine.popUpEngine.Text;

class PopUp
{

    public var contents:Array<Hud>;
    public var name:String;
    public var container:DisplayObjectContainer;
    public var fixed:DisplayObjectContainer;
    public var scrollable:DisplayObjectContainer;

    private var isoEngine:IsoEngine;
    private var popUpEngineMain:PopUpEngineMain;

    public var pxSize:Vector2;
    public var inventory:Inventory;

    public function new (_name:String, pos:Vector2, size:Vector2) {
        isoEngine       = IsoEngine.getInstance();
        popUpEngineMain = PopUpEngineMain.getInstance();

        name       = _name;
        container  = isoEngine.displaying.createChildLayer(name, "popUp");
        fixed      = isoEngine.displaying.createChildLayer("fixed"+name, name);

        container.width  = size.x * isoEngine.width;
        container.height = size.y * isoEngine.height;
        container.x      = pos.x  * isoEngine.width;
        container.y      = pos.y  * isoEngine.height;

        pxSize = new Vector2(size.x * isoEngine.width, size.y * isoEngine.height);

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
    }


    public function addBloc (pos:Vector2, size:Vector2, textureName:String) {
        var bloc = new Bloc(pos, size, textureName);
        return addSomethingOn(bloc);
    }

    public function addBlocPattern (blocName:String) {
        var bloc = popUpEngineMain.getBlocPattern(blocName);
        return addSomethingOn(bloc);
    }

    public function addButton (pos:Vector2, size:Vector2, basicTexture:String, overTexture:String, clickTexture:String, callback) {
        var button = new Button(size, pos, basicTexture, overTexture, clickTexture, callback);
        return addSomethingOn(button);
    }

    public function addButtonPattern (buttonName:String):engine.isoEngine.components.Button {
        var button = popUpEngineMain.getButtonPattern(buttonName);
        return addSomethingOn(button);
    }

    public function addText (pos:Vector2, size:Vector2, text:String, style:pixi.text.Text.TextStyle = null, alpha:Float = null) {
        var text = new Text (pos , size , text, style, alpha);
        return addSomethingOn(text);
    }

    private function addSomethingOn (target:Dynamic):Dynamic {
        return target.addOn(fixed, pxSize, name);
    }

    public function show () {
        container.visible = true;
    }

    public function hide () {
        container.visible = false;
    }

            /***** YOU DON'T CARE *****/



}
