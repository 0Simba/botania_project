package engine.popUpEngine;

import utils.Vector2;
import engine.isoEngine.components.Hud;
import pixi.primitives.Graphics;
import engine.isoEngine.IsoEngine;

class PopUp
{

    public var contents:Array<Hud>;
    public var name:String;
    public var container:Graphics;

    public var pxSize:Vector2;
    public var pxPos:Vector2;

    private var isoEngine:IsoEngine;

    public function new (_name:String, pos:Vector2, size:Vector2) {
        isoEngine = IsoEngine.getInstance();
        name      = _name;
        container = isoEngine.displaying.createChildLayer(name, "popUp");

        pxSize = new Vector2(size.x * isoEngine.width, size.y * isoEngine.height);
        pxPos  = new Vector2(pos.x  * isoEngine.width, pos.y  * isoEngine.height);

        container.beginFill(255255255, 0.7);
        container.drawRect(pxPos.x, pxPos.y, pxSize.x, pxSize.y);
        container.endFill();
    }

    public function addBloc (pos:Vector2, size:Vector2, textureName:String) {
        var newBloc = new Hud();
        // newBloc.set( percentSize : utils.Vector2 , percentPos : utils.Vector2 , animationName : String , ?textureName : String , ?parentLayer : String )

        if (size.x <= 1 && size.y <= 1 && pos.x <= 1 && pos.y <= 1) {
            size.x *= pxSize.x;
            size.y *= pxSize.y;
            pos.x  = (pos.x * pxSize.x) + pxPos.x;
            pos.y  = (pos.y * pxSize.y) + pxPos.y;
        }

        newBloc.set(size, pos, textureName, name);
    }

    public function addYesNo () {

    }

    public function hide () {

    }

    public function show () {

    }
}
