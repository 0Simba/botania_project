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
import init.Config;
import engine.popUpEngine.Inventory;

class DisplayProducts extends PopUpMain
{

    private var config:Dynamic;
    private var callbackOnClose:Dynamic;
    private var productsInventory:Inventory;
    static private var instance:DisplayProducts;

    public function new () {
        super("displayProducts", new Vector2(0.5, 0.5), new Vector2(0.7, 0.45, "%", "%x"));

        applyAnchor(0.5, 0.5);


        addBloc("openFruitBackground", new Vector2(0, 0), new Vector2(1, 1));
        addButtonPattern("close").onClick(function () {
            tweenHide();
            if (callbackOnClose != null) {
                callbackOnClose();
            }
        });

        onShow = tweenShow;
        addText(new Vector2(0.5, 0.2), new Vector2(1, 0.2), "Produits", PopUpMain.titleStyle).text.anchor.set(0.5, 0.5);


        config = Config.products;
        setProductsInventory();

        instance = this;
    }


    static public function setAndShow (_callbackOnClose:Dynamic) {
        instance.callbackOnClose = _callbackOnClose;
        instance.popUpEngine.show("displayProducts");
    }



    private function setProductsInventory () {
        productsInventory = setInventory(new Vector2(0.1, 0.1), new Vector2(0.6, 0.8), new Vector2(0.33, 0.33), 3, -1);

        for (i in 0...config.list.length) {
            var name = config.list[i];
            var cell = inventory.addCell();

            cell.addButton(Vector2.zero, new Vector2(1, 1, "%", "%x"), Vector2.zero, name, tweenHide);
        }

    }
}

