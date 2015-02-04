package init;

import engine.popUpEngine.PopUpEngineMain;
import utils.Vector2;

class PopUp
{

    static public function load () {
        var popUpEngine = PopUpEngineMain.getInstance();

            /***** Create Pattern *****/
        popUpEngine.createBlocPattern("background", Vector2.full, Vector2.zero, "offWhite", 0.5);
        popUpEngine.createButtonPattern("close", new Vector2(0.08, 0.08), new Vector2(0.92, 0), "digBasic", "digHover", "digClick", function(){});

            /***** Create PopUp *****/
        init.popUps.BreakerPopUpInit.init(popUpEngine);
        init.popUps.FlowerPopUpInit.init(popUpEngine);
    }


}