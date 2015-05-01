package entities.popUps;

import utils.Vector2;
import entities.Flower;
import engine.popUpEngine.PopUpEngineMain;

class WaterFlowerPopUp extends PopUpMain
{

    static private var instance;
    static private var popUpMain:PopUpEngineMain;

    static public function setAndShow (_flower:Flower) {
        popUpMain = PopUpEngineMain.getInstance();

        popUpMain.show("waterFlower");
        instance.flower = _flower;
    }




    private var flower:Flower;

    public function new () {
        if (instance != null) return;

        super("waterFlower", new Vector2(0.5, 0.5), new Vector2(0.7, 0.45, "%", "%x"));

        initBasicBlocs();
        onShow = tweenShow;
        var title = addText(new Vector2(0.5, 0.25), Vector2.zero, "Arrosez la plante", PopUpMain.titleStyle);
        title.setAnchor(Vector2.mid);

        var text = addText(new Vector2(0.5, 0.5), Vector2.zero, "Cela coûte trois soleille", PopUpMain.textStyle);
        text.setAnchor(Vector2.mid);


        addButton(new Vector2(0.35, 0.7), new Vector2(0.1, 1, "%", "%x"), Vector2.mid, "shopValidateBtnOk", function () {
            tweenHide();
            flower.water();
        });

        addButton(new Vector2(0.6, 0.7), new Vector2(0.1, 1, "%", "%x"), Vector2.mid, "ShopBtnClose", function () {
            tweenHide();
        });

        instance = this;
    }
}

