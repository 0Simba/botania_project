package entities.popUps;

import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.PopUp;
import entities.popUps.PopUpMain;
import pixi.text.Text.TextStyle;
import init.PlayerDatas;
import manager.Sounds;
import engine.isoEngine.components.Text;
import engine.isoEngine.components.Hud;
import js.html.Storage;


class HeaderPopUp extends PopUpMain
{

    private var gold:Text;
    private var suns:Text;
    private var muteButton:Dynamic;
    private var localStorage:Storage;

    public static var instance:entities.popUps.HeaderPopUp;



    public function new () {
        localStorage = js.Browser.getLocalStorage();

        super("header", new Vector2(0.5, 0.03), new Vector2(600, 123, "px", "px"));
        applyAnchor(0.5, 0);
        addBloc("headerGround", new Vector2(0, 0), new Vector2(1, 1)).displayObject.interactive = false;


        addButton(new Vector2(0.74, 0.90), new Vector2(0.09, 0.85, "%", "%x"), new Vector2(0, 0), "inventoryBtn", function () {
            popUpEngine.show("inventoryInterface");
        });

        addButton(new Vector2(0.86, 0.90), new Vector2(0.09, 0.85, "%", "%x"), new Vector2(0, 0), "shopBtn", function () {
            popUpEngine.show("shopInterface");
        });

        muteButton = addButton(new Vector2(0.20, 0.90), new Vector2(0.065, 0.85, "%", "%x"), new Vector2(0, 0), "unmuteBtn", doSoundToggle);

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





    /*===================================
    =            Static part            =
    ===================================*/

    static public function getInstance():entities.popUps.HeaderPopUp{
        if(instance == null){
            return null;
        }
        return instance;

    }


    static public function updateSuns (value:Int) {
        instance.suns.setText("" + value);
    }


    static public function onComponentsLoaded () {
        instance.checkLocalStorage();
    }





    /*=====================================
    =            Instance part            =
    =====================================*/

    public function setCurrencies(c:Dynamic){
        gold.setText(cast c.gold);
        suns.setText(cast c.suns);
    }



    private function doSoundToggle () {
        Sounds.toggleMute();
        var textureName = (Sounds.isItMute()) ? "muteBtn" : "unmuteBtn";
        muteButton.changeTexture(textureName);

        localStorage.setItem("isMute", haxe.Json.stringify(Sounds.isItMute()));
    }


    private function checkLocalStorage () {
        var lastMuteState = localStorage.getItem("isMute");

        if (lastMuteState == null) {
            localStorage.setItem("isMute", haxe.Json.stringify(false));
        }
        else if (lastMuteState == haxe.Json.stringify(true)) {
            doSoundToggle();
        }
    }
}
