package engine.popUpEngine;

import utils.Vector2;
import engine.isoEngine.components.Hud;
import pixi.primitives.Graphics;
import engine.isoEngine.IsoEngine;
import engine.popUpEngine.Bloc;
import engine.popUpEngine.PopUpEngineMain;

class PopUp
{

    public var contents:Array<Hud>;
    public var name:String;
    public var container:Graphics;

    public var pxSize:Vector2;
    public var pxPos:Vector2;

    private var isoEngine:IsoEngine;
    private var popUpEngineMain:PopUpEngineMain;

    public function new (_name:String, pos:Vector2, size:Vector2) {
        isoEngine       = IsoEngine.getInstance();
        popUpEngineMain = PopUpEngineMain.getInstance();

        name      = _name;
        container = isoEngine.displaying.createChildLayer(name, "popUp");

        pxSize = new Vector2(size.x * isoEngine.width, size.y * isoEngine.height);
        pxPos  = new Vector2(pos.x  * isoEngine.width, pos.y  * isoEngine.height);

        container.beginFill(255255255, 0.7);    // TODO remove this help display
        container.drawRect(pxPos.x, pxPos.y, pxSize.x, pxSize.y);
        container.endFill();

        hide();
    }

    public function addBloc (pos:Vector2, size:Vector2, textureName:String) {
        var bloc = new Bloc(pos, size, textureName);
        bloc.addOn(container, name);
    }

    public function addGenericBloc (blocName:String) {
        var bloc = popUpEngineMain.getBlocPattern(blocName);
        bloc.addOn(container, name);
    }

    public function addYesNo () {

    }

    public function show () {
        container.visible = true;
    }

    public function hide () {
        container.visible = false;
    }
}
