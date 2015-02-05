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

    public var pxSize:Vector2;
    public var pxPos:Vector2;

    private var isoEngine:IsoEngine;
    private var popUpEngineMain:PopUpEngineMain;

    public function new (_name:String, pos:Vector2, size:Vector2) {
        isoEngine       = IsoEngine.getInstance();
        popUpEngineMain = PopUpEngineMain.getInstance();

        name       = _name;
        container  = isoEngine.displaying.createChildLayer(name, "popUp");
        fixed      = isoEngine.displaying.createChildLayer("fixed"+name, name);
        scrollable = isoEngine.displaying.createChildLayer("scrollable"+name, name);

        pxSize = new Vector2(size.x * isoEngine.width, size.y * isoEngine.height);
        pxPos  = new Vector2(pos.x  * isoEngine.width, pos.y  * isoEngine.height);

        // container.beginFill(0, 0);    // TODO FOUND WHY THIS IS NEEDED TO DISPLAY CHILDS
        // container.drawRect(pxPos.x, pxPos.y, pxSize.x, pxSize.y);
        // container.endFill();

        hide();
    }

    public function setInventory (pos:Vector2, size:Vector2, elementSize:Vector2) {

    }


    public function addBloc (pos:Vector2, size:Vector2, textureName:String) {
        var bloc = new Bloc(pos, size, textureName);
        bloc.addOn(/*scrollable*/container, name);
    }

    public function addBlocPattern (blocName:String) {
        var bloc = popUpEngineMain.getBlocPattern(blocName);
        bloc.addOn(/*scrollable*/container, name);
        return bloc;
    }

    public function addButtonPattern (buttonName:String):engine.isoEngine.components.Button {
        var button = popUpEngineMain.getButtonPattern(buttonName);
        return button.addOn(/*scrollable*/container, name);
    }

    public function show () {
        container.visible = true;
    }

    public function hide () {
        container.visible = false;
    }

            /***** YOU DON'T CARE *****/
}
