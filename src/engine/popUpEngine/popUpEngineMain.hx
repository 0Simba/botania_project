package engine.popUpEngine;

import engine.isoEngine.IsoEngine;

class PopUpEngineMain
{
    private static var instance:PopUpEngineMain;
    private var isoEngine:IsoEngine;
    private var popUps:Map<String, PopUp>;



    public function create (name, size, pos) {
        var popUp = new PopUp(name, size, pos);
        popUps.set(name, popUp);
        return popUp;
    }

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
