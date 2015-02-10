package engine.popUpEngine;

import engine.isoEngine.IsoEngine;
import engine.isoEngine.components.Hud;
import utils.Vector2;
import utils.MapManipulate;
import pixi.display.DisplayObjectContainer;

class PopUpEngineMain
{
    private static var instance:PopUpEngineMain;
    private var isoEngine:IsoEngine;
    private var popUps :Map<String, PopUp>;
    private var blocs  :Map<String, Bloc>;
    private var buttons:Map<String, Button>;
    private var layer:DisplayObjectContainer;


    public function createPopUp (name, pos, size) {
        var popUp = new PopUp(name, pos, size);
        popUps.set(name, popUp);
        return popUp;
    }

    public function createBlocPattern (name:String, pos:Vector2, size:Vector2, textureName:String, alpha:Float = 1) {
        MapManipulate.ifIsFree(blocs, name, function () {
            var bloc = new Bloc(pos, size, textureName, alpha);
            blocs.set(name, bloc);
        });
    }

    public function createButtonPattern (name:String, pos:Vector2, size:Vector2, basicTexture:String, overTexture:String, clickTexture:String, callback) {
        var button:Button;

        MapManipulate.ifIsFree(buttons, name, function () {
            button = new Button(size, pos, basicTexture, overTexture, clickTexture, callback);
            buttons.set(name, button);
        }, "buttons");

        return button;
    }

    public function show (name):PopUp {
        MapManipulate.ifExists(popUps, name, function () {
            var popUp = popUps.get(name);
            layer.setChildIndex(popUp.layer, layer.children.length - 1);
            popUp.show();
            return popUp;
        }, "popUps");
        return null;
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
        layer     = isoEngine.displaying.createChildLayer("popUp", "foreground");
    }

}
