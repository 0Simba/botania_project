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
        popUpEngine.createButtonPattern("close", new Vector2(0.90, 0), new Vector2(0.08, -1),  "crossBasic", "crossHover", "crossClick", function(){});

            /***** Create PopUp *****/
        init.popUps.BreakerPopUpInit.init();
        init.popUps.FlowerPopUpInit.init();
    }
}