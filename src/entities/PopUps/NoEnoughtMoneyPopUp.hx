package entities.popUps;

import engine.popUpEngine.PopUpEngineMain;
import engine.isoEngine.components.Text;
import utils.Vector2;

class NoEnoughtMoneyPopUp extends PopUpMain
{


    /*===================================
    =            Static part            =
    ===================================*/

    static private var instance:NoEnoughtMoneyPopUp;
    static private var popUpMain:PopUpEngineMain;


    static public function setTitleAndShow (_title:String) {
        popUpMain = PopUpEngineMain.getInstance();

        instance.title.setText(_title);
        popUpMain.show("noEnoughtMoney");
    }




    /*=====================================
    =            Instance Part            =
    =====================================*/

    var title:Text;


    public function new () {
        if (instance != null) return;

        super("noEnoughtMoney", new Vector2(0.5, 0.5), new Vector2(0.7, 0.45, "%", "%x"));

        initBasicBlocs();
        onShow = tweenShow;
        title = addText(new Vector2(0.5, 0.25), Vector2.zero, "Arrosez la plante", PopUpMain.titleStyle);
        title.setAnchor(Vector2.mid);

        var text = addText(new Vector2(0.5, 0.5), Vector2.zero, "Vous ne posséder pas assez d'argent", PopUpMain.textStyle);
        text.setAnchor(Vector2.mid);


        addButton(new Vector2(0.5, 0.7), new Vector2(0.1, 1, "%", "%x"), Vector2.mid, "shopValidateBtnOk", function () {
            tweenHide();
        });

        instance = this;
    }

}

