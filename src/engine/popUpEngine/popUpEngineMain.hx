package engine.popUpEngine;

import engine.isoEngine.IsoEngine;
import engine.isoEngine.components.Hud;
import utils.Vector2;

class PopUpEngineMain
{
    private static var instance:PopUpEngineMain;
    private var isoEngine:IsoEngine;
    private var popUps:Map<String, PopUp>;
    private var blocs:Map<String, Bloc>;
    private var buttons:Map<String, Button>;


    public function createPopUp (name, size, pos) {
        var popUp = new PopUp(name, size, pos);
        popUps.set(name, popUp);
        return popUp;
    }

    public function createBlocPattern (name:String, size:Vector2, pos:Vector2, textureName:String) {
        if (!blocs.exists(name)) {
            var bloc = new Bloc(size, pos, textureName);
            blocs.set(name, bloc);
        }
        else trace("PopUpEngineMain.addBlocPattern -> un bloc sous le nom de " + name + " existe déjà.");
    }

    public function createButtonPattern (name:String, size:Vector2, pos:Vector2, basicTexture:String, overTexture:String, clickTexture:String, callback) {
        if (!buttons.exists(name)) {
            var button = new Button(size, pos, basicTexture, overTexture, clickTexture, callback);
            buttons.set(name, button);
        }
        else trace("PopUpEngineMain.addButtonPattern -> un bloc sous le nom de " + name + " existe déjà.");
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

        /***** SURELY NOT INTEREST YOU *****/

    public function getBlocPattern (name:String):Bloc {
        if (blocs.exists(name)) {
            return blocs.get(name);
        }
        else {
            trace("PopUpEngineMain.getBlocPattern -> Il n'existe pas de bloc sous le nom de " + name);
            return null;
        }
    }

    public function getButtonPattern (name:String):Button {
        if (buttons.exists(name)) {
            return buttons.get(name);
        }
        else {
            trace("PopUpEngineMain.getBlocPattern -> Il n'existe pas de bloc sous le nom de " + name);
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
        popUps  = new Map<String, PopUp>();
        blocs   = new Map<String, Bloc>();
        buttons = new Map<String, Button>();

        isoEngine = IsoEngine.getInstance();
        isoEngine.displaying.createChildLayer("popUp", "foreground");
    }

}
