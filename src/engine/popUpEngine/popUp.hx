package engine.popUpEngine;

import utils.Vector2;
import engine.isoEngine.components.Hud;
import pixi.display.DisplayObjectContainer;
import engine.isoEngine.IsoEngine;
import engine.popUpEngine.Bloc;
import engine.popUpEngine.PopUpEngineMain;

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
    public var scrollableSize:Vector2;
    public var pxInventory:Vector2;
    public var nbElementX:Int;
    public var nbElementY:Int;

    public function new (_name:String, pos:Vector2, size:Vector2) {
        isoEngine       = IsoEngine.getInstance();
        popUpEngineMain = PopUpEngineMain.getInstance();

        name       = _name;
        container  = isoEngine.displaying.createChildLayer(name, "popUp");
        fixed      = isoEngine.displaying.createChildLayer("fixed"+name, name);
        scrollable = isoEngine.displaying.createChildLayer("scrollable"+name, name);

        container.width  = size.x * isoEngine.width;
        container.height = size.y * isoEngine.height;
        container.x      = pos.x  * isoEngine.width;
        container.y      = pos.y  * isoEngine.height;

        pxSize = new Vector2(size.x * isoEngine.width, size.y * isoEngine.height);

        hide();
    }

    public function setInventory (pos:Vector2, size:Vector2, elementSize:Vector2, _nbElementX:Int = -1, _nbElementY:Int = -1) {
        scrollable.x = pos.x * pxSize.x;
        scrollable.y = pos.y * pxSize.y;
        scrollable.width  = size.x * pxSize.x;
        scrollable.height = size.y * pxSize.y;
        scrollableSize = new Vector2(pxSize.x, pxSize.y);

        nbElementX = _nbElementX;
        nbElementY = _nbElementY;
    }


    public function addBloc (pos:Vector2, size:Vector2, textureName:String, inInventory = false) { // WARNING, don't try pass inIventory with default value and remove argument in call, this is fucked and crash code
        var bloc = new Bloc(pos, size, textureName);
        return addSomethingOn(bloc, inInventory);
    }

    public function addBlocPattern (blocName:String, inInventory = false) {
        var bloc = popUpEngineMain.getBlocPattern(blocName);
        return addSomethingOn(bloc, inInventory);
    }

    public function addButtonPattern (buttonName:String, inInventory = false):engine.isoEngine.components.Button {
        var button = popUpEngineMain.getButtonPattern(buttonName);
        return addSomethingOn(button, inInventory);
    }

    private function addSomethingOn (target:Dynamic, inInventory:Bool):Dynamic {
        var targetContainer = (inInventory) ? scrollable     : fixed;
        var targetSize      = (inInventory) ? scrollableSize : pxSize;
        if (inInventory && targetSize == null) {
            trace("Immpossible d'ajouter l'éléement d'inventaire, parametrez un inventaire avant dans cette pop up");
            return null;
        }
        return target.addOn(targetContainer, targetSize, name);
    }

    public function show () {
        container.visible = true;
    }

    public function hide () {
        container.visible = false;
    }

            /***** YOU DON'T CARE *****/
}
