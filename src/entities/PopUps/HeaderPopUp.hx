package entities.popUps;

import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.PopUp;
import entities.popUps.PopUpMain;
import pixi.text.Text.TextStyle;
import init.PlayerDatas;
import manager.Sounds;

class HeaderPopUp extends PopUpMain
{
    private var gold:engine.isoEngine.components.Text;
    private var suns:engine.isoEngine.components.Text;
    public static var instance:entities.popUps.HeaderPopUp;
    public function new () {

        super("header", new Vector2(0.5, 0.03), new Vector2(600, 123, "px", "px"));
        applyAnchor(0.5, 0);
        addBloc("headerGround", new Vector2(0, 0), new Vector2(1, 1)).displayObject.interactive = false;
        addButton(new Vector2(0.74, 0.90), new Vector2(0.09, 0.85, "%", "%x"), new Vector2(0, 0), "inventoryBtn", function () {
            popUpEngine.show("inventoryInterface");
        });
        addButton(new Vector2(0.86, 0.90), new Vector2(0.09, 0.85, "%", "%x"), new Vector2(0, 0), "shopBtn", function () {
            popUpEngine.show("shopInterface");
        });
        addButton(new Vector2(0.20, 0.90), new Vector2(0.065, 0.85, "%", "%x"), new Vector2(0, 0), "unmuteBtn", function () {
            Sounds.toggleMute();
        });
        addButton(new Vector2(0.28, 0.90), new Vector2(0.065, 0.85, "%", "%x"), new Vector2(0, 0), "Fullscreen", function () {
        });

        var style:TextStyle = {
            fill : "white",
            font : "bold 18px arial",
            wordWrap : true
        };
        suns = addText(new Vector2(0.8, 0.4), new Vector2(1, 1), "0", style);
        gold = addText(new Vector2(0.8, 0.64), new Vector2(1, 1), "20000", style);
        instance = this;
    }
    static public function getInstance():entities.popUps.HeaderPopUp{
        if(instance == null){
            return null;
        }
        return instance;

    }
    public function setCurrencies(c:Dynamic){
        gold.setText(cast c.gold);
        suns.setText(cast c.suns);
    }
}