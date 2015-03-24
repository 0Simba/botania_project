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

class OpenFruitPopUp extends PopUpMain
{

    static public var currentFruitRef:Fruit;

    public function new () {
        super("openFruit", new Vector2(0.5, 0.5), new Vector2(0.7, 0.45, "%", "%x"));

        applyAnchor(0.5, 0.5);


        addBloc("openFruitBackground", new Vector2(0, 0), new Vector2(1, 1));
        addButtonPattern("close").onClick(function () {
            tweenHide();
        });

        onShow = tweenShow;


        var woodPos   = new Vector2(0.25, 0.6);
        var metalPos  = new Vector2(0.45, 0.6);
        var silverPos = new Vector2(0.65, 0.6);
        var knifeSize = new Vector2(0.125, -1);
        var style:TextStyle = {
            fill : "white",
            font : "bold 25px arial",
            align : "center",
            wordWrap : true
        };
        // var textSize  = new Vector2(0.125)

        addText(new Vector2(0.5, 0.2), new Vector2(1, 0.2), "Choisissez votre couteau", style).text.anchor.set(0.5, 0.5);

        addBloc("objectBackground", woodPos, knifeSize).sprite.anchor.set(0.5, 0.5);
        addText(woodPos, knifeSize, "Bois", style).text.anchor.set(0.5, 3);
        addButton(woodPos, knifeSize, Vector2.mid, "woodKnife", function () {
            open(1);
        });

        addBloc("objectBackground", metalPos, knifeSize).sprite.anchor.set(0.5, 0.5);
        addText(metalPos, knifeSize, "Metal", style).text.anchor.set(0.5, 3);
        addButton(metalPos, knifeSize, Vector2.mid, "metalKnife", function () {
            open(2);
        });

        addBloc("objectBackground", silverPos, knifeSize).sprite.anchor.set(0.5, 0.5);
        addText(silverPos, knifeSize, "Argent", style).text.anchor.set(0.5, 3);
        addButton(silverPos, knifeSize, Vector2.mid, "silverKnife", function () {
            open(3);
        });

    }

    static public function setFruitRef (fruitRef:Fruit) {
        currentFruitRef = fruitRef;
    }

    private function open (level) {
        if (currentFruitRef != null) currentFruitRef.open(level);
        currentFruitRef = null;
        tweenHide();
    }
}

