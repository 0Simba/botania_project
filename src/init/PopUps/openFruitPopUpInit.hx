package init.popUps;

import engine.tween.Tween;
import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.Cell;
import engine.popUpEngine.Bloc;
import entities.Seed;
import engine.popUpEngine.PopUp;
import engine.isoEngine.IsoEngine;
import Map;
import engine.tween.Ease;

class BreakerPopUpInit
{

    static private var seed1:engine.isoEngine.components.Hud;
    static private var seed2:engine.isoEngine.components.Hud;
    static private var popUpEngine:PopUpEngineMain;
    static private var breakerPopUp;
    static private var tween:Tween;

    public static function init () {
        popUpEngine  = PopUpEngineMain.getInstance();
        breakerPopUp = popUpEngine.createPopUp("openFruit", new Vector2(0.5, 0.5), new Vector2(0.8, 0.8));
        breakerPopUp.applyAnchor(0.5, 0.5);
    }
}

