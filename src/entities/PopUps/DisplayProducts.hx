package entities.popUps;

import engine.tween.Tween;
import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.Cell;
import engine.popUpEngine.Bloc;
import engine.popUpEngine.PopUp;
import engine.isoEngine.IsoEngine;
import Map;
import engine.tween.Ease;
import entities.popUps.PopUpMain;
import pixi.text.Text.TextStyle;
import entities.Fruit;
import utils.AjaxRequest;
import entities.popUps.NoEnoughtMoneyPopUp;


class DisplayProducts extends PopUpMain
{

    static public var currentFruitRef:Fruit;

    /*==============================
    =            Config            =
    ==============================*/

    public function new () {
        super("openFruit", new Vector2(0.5, 0.5), new Vector2(0.7, 0.45, "%", "%x"));

        applyAnchor(0.5, 0.5);


        addBloc("openFruitBackground", new Vector2(0, 0), new Vector2(1, 1));
        addButtonPattern("close").onClick(function () {
            tweenHide();
        });

        onShow = tweenShow;


        // var textSize  = new Vector2(0.125)

        addText(new Vector2(0.5, 0.2), new Vector2(1, 0.2), "Choisissez votre couteau", style).text.anchor.set(0.5, 0.5);

        createSection(woodPos,   "Bois",   "woodKnife",   1);
        createSection(metalPos,  "Metal",  "metalKnife",  2, 10);
        createSection(silverPos, "Argent", "silverKnife", 3, 0, 2);
    }


}

