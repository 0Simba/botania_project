package init.popUps;

import engine.tween.Tween;
import engine.tween.Ease;
import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.PopUp;
import engine.isoEngine.IsoEngine;
import Map;

class PopUpUtils
{

    public  var popUpEngine:PopUpEngineMain;
    private var instance:PopUp;
    private var poping = false;
    private var tween:Tween;


    public function new () {
        popUpEngine = PopUpEngineMain.getInstance();
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
            instance.scale(currentDatas.get("scale"));
            instance.applyAnchor(0.5, 0.5);
        });
        tween.onComplete(function () {
            if (!poping) instance.hide();
        });
    }
}

