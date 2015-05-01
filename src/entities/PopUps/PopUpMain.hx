package entities.popUps;

import engine.tween.Tween;
import engine.tween.Ease;
import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.PopUp;
import engine.isoEngine.IsoEngine;
import engine.isoEngine.managers.Assets;
import engine.isoEngine.components.Hud;
import Map;

class PopUpMain extends PopUp
{

    public var popUpEngine:PopUpEngineMain;
    public var assets:Assets;

    private var poping = false;
    private var tween:Tween;


    public function new (name:String, pos:Vector2, size:Vector2) {
        super(name, pos, size);

        popUpEngine = PopUpEngineMain.getInstance();
        assets      = IsoEngine.getInstance().assets;
        createTween();
    }

    private function tweenShow () {
        poping = true;
        tween.ease(Ease.backOut);
        tween.start();
    }

    private function tweenHide () {
        poping = false;
        tween.ease(Ease.backOutInvert);
        tween.start();
    }

    private function createTween () {
        var from = new Map<String, Float>();
        from.set("scale", 0);

        var to = new Map<String, Float>();
        to.set("scale", 1);

        tween = new Tween (from, to, 500);
        tween.onUpdate(function (currentDatas) {
            scale(currentDatas.get("scale"));
            applyAnchor(0.5, 0.5);
        });
        tween.onComplete(function () {
            if (!poping) hide();
        });
    }


    /*==========================================
    =            Default Appareance            =
    ==========================================*/

    private function initBasicBlocs () {
        applyAnchor(0.5, 0.5);

        addBloc("openFruitBackground", new Vector2(0, 0), new Vector2(1, 1));
        addButtonPattern("close").onClick(function () {
            tweenHide();
        });
    }



    /*======================================
    =            Display Flower            =
    ======================================*/

    private var displayFlowerBlocs:Array<Hud>;


    private function setFlowerBlocs (position:Vector2, size:Vector2) {
        displayFlowerBlocs    = new Array<Hud>();
        displayFlowerBlocs[0] = addBloc("GA", position, size);
        displayFlowerBlocs[1] = addBloc("OA", position, size);
        displayFlowerBlocs[2] = addBloc("FA", position, size);
    }


    private function updateFlowerBlocs (genomeCode:String) {
        displayFlowerBlocs[0].changeTexture("O" + genomeCode.charAt(1));
        displayFlowerBlocs[1].changeTexture("F" + genomeCode.charAt(0));
        displayFlowerBlocs[2].changeTexture("G" + genomeCode.charAt(2));
    }
}



