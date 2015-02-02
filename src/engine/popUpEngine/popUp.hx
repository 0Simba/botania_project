package engine.popUpEngine;

import utils.Vector2;
import engine.isoEngine.components.Hud;

class PopUp extends GameObject
{

    public var contents:Array<Hud>;

    public function new (name:String, size:Vector2, pos:Vector2) {
        super();
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
