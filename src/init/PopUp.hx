package init;

import engine.popUpEngine.PopUpEngineMain;
import utils.Vector2;

class PopUp
{

    static public function load () {
        var popUpEngine = PopUpEngineMain.getInstance();

            /***** Create Pattern *****/
        popUpEngine.createBlocPattern("background", new Vector2(0.02, 0.02), new Vector2(0.96, 0.96), "offWhite", 0.7);
        popUpEngine.createBlocPattern("border", Vector2.zero, Vector2.full, "border", 1);
        popUpEngine.createBlocPattern("florist", new Vector2(0.7, 0.1), new Vector2(0.473, 0.9, "%y"), "florist", 1);
        popUpEngine.createButtonPattern("close", new Vector2(0.96, -0.04, "%", "%x"), new Vector2(0.08, -1),  "crossBasic", "crossHover", "crossClick", function(){});

            /***** Create PopUp *****/
        init.popUps.BreakerPopUpInit.init();
        init.popUps.FlowerPopUpInit.init();
        init.popUps.HeaderPopUpInit.init();

        popUpEngine.show("header");
    }
}