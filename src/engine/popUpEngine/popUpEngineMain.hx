package engine.popUpEngine;

import engine.isoEngine.IsoEngine;

class PopUpEngineMain
{
    private static var instance:PopUpEngineMain;
    private var popUps:Map<String, PopUp>;


    private function new () {
        popUps = new Map<String, PopUp>();
    }

    public function create (name, size, pos, animation, texture) {
        var popUp = new PopUp(size, pos, animation, texture);
        popUps.set(name, popUp);

        return popUp;
    }


    public static function getInstance (): PopUpEngineMain {
        if (instance == null) {
            instance = new PopUpEngineMain();
        }
        return instance;
    }
}
