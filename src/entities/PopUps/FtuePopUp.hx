package entities.popUps;

import engine.events.Events; 
import engine.popUpEngine.PopUpEngineMain;
import engine.isoEngine.components.Text;
import utils.Vector2;
import pixi.text.Text.TextStyle;

class FtuePopUp extends PopUpMain
{


    /*===================================
    =            Static part            =
    ===================================*/

    static private var instance:FtuePopUp;
    static private var popUpMain:PopUpEngineMain;
    private var ftueStyle :TextStyle = PopUpMain.textStyle;
    private var popUpEvents:Events;


    static public function setTitleAndShow (_content:String) {
        popUpMain = PopUpEngineMain.getInstance(); 
        instance.content.setText(_content);
        popUpMain.show("ftuePopUp");
    }



    /*=====================================
    =            Instance Part            =
    =====================================*/

    var content:Text;


    public function new () {
        if (instance != null) return;

        super("ftuePopUp", new Vector2(0.5, 0.5), new Vector2(0.7, 0.45, "%", "%x"));

        initBasicBlocs();
        onShow = tweenShow;
            content = addText(new Vector2(0.1, 0.23), new Vector2(0.7, 0.9), "Bienvenue dans le monde de Botania. Ici vous pourrez faire votre jardin de rêve.
Commençons tout de suite.", {
            fill          : "white",
            font          : "bold 25px arial",
            align         : "left",
            wordWrap      : true,
            wordWrapWidth : 550
        });

        addButton(new Vector2(0.72, 0.82), new Vector2(0.1, 1, "%", "%x"), Vector2.mid, "shopValidateBtnOk", function () {
            tweenHide();
        });

        instance = this;
    }

}