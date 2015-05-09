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

    /*==============================
    =            Config            =
    ==============================*/

    static private var woodPos   = new Vector2(0.25, 0.6);
    static private var metalPos  = new Vector2(0.45, 0.6);
    static private var silverPos = new Vector2(0.65, 0.6);
    static private var knifeSize = new Vector2(0.125, -1);
    static private var priceSize = new Vector2(0.125, -0.2);
    static private var style:TextStyle = {
        fill : "white",
        font : "bold 25px arial",
        align : "center",
        wordWrap : true
    };



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

        // addBloc("backgroundDark", woodPos, priceSize).sprite.anchor.set(0.5, 1.1);

        createSection(woodPos,   "Bois",   "woodKnife",   1);
        createSection(metalPos,  "Metal",  "metalKnife",  2);
        createSection(silverPos, "Argent", "silverKnife", 3);
    }


    static public function setFruitRef (fruitRef:Fruit) {
        currentFruitRef = fruitRef;
    }


    private function open (level) {
        if (currentFruitRef != null) currentFruitRef.open(level);
        currentFruitRef = null;
        tweenHide();
        popUpEngineMain.show("inventoryInterface");
    }


    private function createSection (position:Vector2, text:String, textureName:String, nbSeed:Int) {
        addBloc("objectBackground", position, knifeSize).sprite.anchor.set(0.5, 0.5);
        addText(position, knifeSize, text, style).text.anchor.set(0.5, 3);
        addButton(position, knifeSize, Vector2.mid, textureName, function () {
            open(nbSeed);
        });
    }

}

