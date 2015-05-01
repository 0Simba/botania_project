package entities.popUps;

import utils.Vector2;


class WaterFlowerPopUp extends PopUpMain
{
    public function new () {
        super("waterFlower", new Vector2(0.5, 0.5), new Vector2(0.7, 0.45, "%", "%x"));

        initBasicBlocs();
        var title = addText(new Vector2(0.5, 0.25), Vector2.zero, "Arrosez la plante", PopUpMain.titleStyle);
        title.setAnchor(Vector2.mid);

        var text = addText(new Vector2(0.5, 0.5), Vector2.zero, "Cela coûte trois soleille", PopUpMain.textStyle);
        text.setAnchor(Vector2.mid);


        addButton(new Vector2(0.35, 0.7), new Vector2(0.1, 1, "%", "%x"), Vector2.mid, "shopValidateBtnOk", function () {
            trace("ok on dois faire l'action");
            tweenHide();
        });

        addButton(new Vector2(0.6, 0.7), new Vector2(0.1, 1, "%", "%x"), Vector2.mid, "ShopBtnClose", function () {
            tweenHide();
        });

    }
}

