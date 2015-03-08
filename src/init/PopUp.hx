package init;

import engine.popUpEngine.PopUpEngineMain;
import utils.Vector2;
import engine.isoEngine.IsoEngine;

class PopUp
{

    static public function load () {
        var popUpEngine = PopUpEngineMain.getInstance();
        var assets      = IsoEngine.getInstance().assets;

            /***** Create Pattern *****/
        popUpEngine.createBlocPattern("background", new Vector2(0.02, 0.02), new Vector2(0.96, 0.96), "offWhite", 0.7);
        popUpEngine.createBlocPattern("border", Vector2.zero, Vector2.full, "border", 1);
        popUpEngine.createBlocPattern("florist", new Vector2(0.7, 0.1), new Vector2(0.473, 0.9, "%y"), "florist", 1);
        popUpEngine.createButtonPattern("close", new Vector2(1, 0), assets.getSize("breaker_close_btn"), new Vector2(1, 0), "breaker_close_btn", function(){});

            /***** Create PopUp *****/
        init.popUps.FlowerPopUpInit.init();
        new init.popUps.InventoryPopUp();
        init.popUps.BreakerPopUpInit.init();
        new init.popUps.HeaderPopUp();
        new init.popUps.OpenFruitPopUp();

        popUpEngine.show("header");
    }
}