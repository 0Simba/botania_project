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

        var buttonY = 0.4;

        openFruitPopup.addBloc("objectBackground", new Vector2(0.17, buttonY), new Vector2(0.125, -1));
        openFruitPopup.addButton(new Vector2(0.17, buttonY), new Vector2(0.125, -1), Vector2.zero, "woodKnife", function () {
            trace("use woodKnife");
        });

        openFruitPopup.addBloc("objectBackground", new Vector2(0.37, buttonY), new Vector2(0.125, -1));
        openFruitPopup.addButton(new Vector2(0.37, buttonY), new Vector2(0.125, -1), Vector2.zero, "metalKnife", function () {
            trace("use metalKnife");
        });

        openFruitPopup.addBloc("objectBackground", new Vector2(0.57, buttonY), new Vector2(0.125, -1));
        openFruitPopup.addButton(new Vector2(0.57, buttonY), new Vector2(0.125, -1), Vector2.zero, "silverKnife", function () {
            trace("use silverKnife");
        });

    }
}

