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

    private var productsList:Map<String, Price>;
    private var callbackOnClose:Dynamic;
    private var productsInventory:Inventory;
    private var lastClickName:String;

    static private var instance:DisplayProducts;


    public function new () {
        super("displayProducts", new Vector2(0.5, 0.5), new Vector2(0.7, 0.45, "%", "%x"));

        applyAnchor(0.5, 0.5);


        addBloc("openFruitBackground", new Vector2(0, 0), new Vector2(1, 1));
        addButtonPattern("close").onClick(function () {
            lastClickName = null;
            tweenHide();
            if (callbackOnClose != null) {
                callbackOnClose();
            }
        });

        onShow = tweenShow;
        addText(new Vector2(0.5, 0.2), new Vector2(1, 0.2), "Produits", PopUpMain.titleStyle).text.anchor.set(0.5, 0.5);

        parseConfig();
        setProductsInventory();

        instance = this;
    }


    static public function setAndShow (_callbackOnClose:Dynamic) {
        instance.callbackOnClose = _callbackOnClose;
        instance.popUpEngine.show("displayProducts");
    }


    private function setProductsInventory () {
        productsInventory = setInventory(new Vector2(0.1, 0.26), new Vector2(0.6, 0.6), new Vector2(0.2, 0.5), 5, -1);

        var keys = productsList.keys();
        for (name in keys) {
            var price = productsList.get(name);
            var cell  = inventory.addCell();
            var cont  = cell.addContainer(new Vector2(1, 1));

            cont.addButton(new Vector2 (0.02, 0.02), new Vector2 (0.96, 0.96), Vector2.zero, "objectBackground", function () {
                lastClickName = name;
                checkCallbackAndClose();
            });

            cont.addBloc(name, new Vector2(0.04, 0.04), new Vector2(1, 0.7)).displayObject.interactive = false;
            var text = ((price.sun > 0) ? price.sun : price.coin) + "";
            var img  = (price.sun > 0)  ? "sun"     : "coin";

            cont.addBloc(img, new Vector2(0.58, 0.7), new Vector2(0.25, 0.25)).displayObject.interactive = false;
            cont.addText(new Vector2(0.3, 0.7), Vector2.zero, text, PopUpMain.titleStyle);
        }
    }


    private function checkCallbackAndClose () {
        if (callbackOnClose != null) callbackOnClose(lastClickName);
        callbackOnClose = null;
        tweenHide();
    }


    private function parseConfig () {
        productsList = new Map<String, Price>();

        var list = Config.products;
        for (name in Reflect.fields(list)) {
            var obj  = Reflect.field(list, name);
            var sun  = obj.sun;
            var coin = obj.coin;

            productsList.set(name, new Price(sun, coin));
        }
    }
}


class Price {
    public var sun:Int;
    public var coin:Int;


    public function new (_gold, _coin) {
        sun = _gold;
        coin = _coin;
    }
}
