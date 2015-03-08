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

class OpenFruitPopUpInit
{

    static private var seed1:engine.isoEngine.components.Hud;
    static private var seed2:engine.isoEngine.components.Hud;
    static private var popUpEngine:PopUpEngineMain;
    static private var openFruitPopup;
    static private var tween:Tween;

    public static function init () {
        popUpEngine  = PopUpEngineMain.getInstance();

        openFruitPopup = popUpEngine.createPopUp("openFruit", new Vector2(0.5, 0.5), new Vector2(0.7, 0.45, "%", "%x"));
        openFruitPopup.applyAnchor(0.5, 0.5);
        openFruitPopup.addBloc("openFruitBackground", new Vector2(0, 0), new Vector2(1, 1));
        openFruitPopup.addButtonPattern("close").onClick(function () {
            openFruitPopup.hide();
        });
    }
}

