package init.popUps;

import engine.tween.Tween;
import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.Cell;
import engine.popUpEngine.Bloc;
import engine.popUpEngine.PopUp;
import engine.isoEngine.IsoEngine;
import Map;
import engine.tween.Ease;

class OpenFruitPopUp extends init.popUps.PopUpUtils
{

    public function new () {
        super();

        instance = popUpEngine.createPopUp("openFruit", new Vector2(0.5, 0.5), new Vector2(0.7, 0.45, "%", "%x"));
        instance.applyAnchor(0.5, 0.5);


        instance.addBloc("openFruitBackground", new Vector2(0, 0), new Vector2(1, 1));
        instance.addButtonPattern("close").onClick(function () {
            tweenHide();
        });


        instance.onShow = tweenShow;


        var buttonY = 0.4;

        instance.addBloc("objectBackground", new Vector2(0.17, buttonY), new Vector2(0.125, -1));
        instance.addButton(new Vector2(0.17, buttonY), new Vector2(0.125, -1), Vector2.zero, "woodKnife", function () {
            trace("use woodKnife");
        });

        instance.addBloc("objectBackground", new Vector2(0.37, buttonY), new Vector2(0.125, -1));
        instance.addButton(new Vector2(0.37, buttonY), new Vector2(0.125, -1), Vector2.zero, "metalKnife", function () {
            trace("use metalKnife");
        });

        instance.addBloc("objectBackground", new Vector2(0.57, buttonY), new Vector2(0.125, -1));
        instance.addButton(new Vector2(0.57, buttonY), new Vector2(0.125, -1), Vector2.zero, "silverKnife", function () {
            trace("use silverKnife");
        });

    }
}

