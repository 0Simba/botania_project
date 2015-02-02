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

    private var isoEngine:IsoEngine;

    public function new (_name:String, size:Vector2, pos:Vector2) {
        isoEngine = IsoEngine.getInstance();
        name      = _name;
        container = isoEngine.displaying.createChildLayer(name, "popUp");
    }

    public function addBloc (size:Vector2, pos:Vector2, textureName:String) {
        var newBloc = new Hud();
        // newBloc.set( percentSize : utils.Vector2 , percentPos : utils.Vector2 , animationName : String , ?textureName : String , ?parentLayer : String )
        // newBloc.set(size, pos, )
    }

    public function addYesNo () {

    }

    public function hide () {

    }

    public function show () {

    }
}
