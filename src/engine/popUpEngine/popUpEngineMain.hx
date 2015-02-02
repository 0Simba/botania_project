package engine.popUpEngine;

import engine.isoEngine.IsoEngine;
import engine.isoEngine.components.Hud;

class PopUpEngineMain
{
    private static var instance:PopUpEngineMain;
    private var isoEngine:IsoEngine;
    private var popUps:Map<String, PopUp>;
    // private var blocs:Map<String, Hud>;


    public function create (name, size, pos) {
        var popUp = new PopUp(name, size, pos);
        popUps.set(name, popUp);
        return popUp;
    }

    // public function genericBloc (name, size, pos) {
    //     var bloc
    // }

    public function show (name):PopUp {
        if (popUps.exists(name)) {
            var popUp = popUps.get(name);
            popUp.show();
            return popUp;
        }
        else {
            trace("PopUpEngineMain.show -> Il n'existe pas de pop up au nom de " + name);
            return null;
        }
    }



        /***** YOU DON'T CARE *****/

    public static function getInstance (): PopUpEngineMain {
        if (instance == null) {
            instance = new PopUpEngineMain();
        }
        return instance;
    }

    private function new () {
        popUps = new Map<String, PopUp>();
        isoEngine = IsoEngine.getInstance();
        isoEngine.displaying.createChildLayer("popUp", "foreground");
    }

}
