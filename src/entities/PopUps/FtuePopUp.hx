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
        content = addText(new Vector2(0.25, 0.25), Vector2.zero, "Bienvenu dans le monde de Botania. ici vous pourrez faire votre jardin de reve.
Commençons tout de suite.", PopUpMain.textStyle);
        // content.setAnchor(Vector2.mid);

        // var text = addText(new Vector2(0.5, 0.5), Vector2.zero, "Vous ne posséder pas assez d'argent", PopUpMain.textStyle);
        // text.setAnchor(Vector2.mid);

        //var a = 
        //popUpEvents = PopUpEngineMain.getInstance().events;
        addButton(new Vector2(0.5, 0.7), new Vector2(0.1, 1, "%", "%x"), Vector2.mid, "shopValidateBtnOk", function () {
            tweenHide();
        });

        instance = this;
    }

}