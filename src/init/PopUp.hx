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
        // popUpEngine.createButtonPattern("close", new Vector2(0.96, -0.04, "%", "%x"), new Vector2(0.08, -1),  "crossBasic", "crossHover", "crossClick", function(){});
        popUpEngine.createButtonPattern("close", new Vector2(0.94, 0.01), assets.getSize("breaker_close_btn") , "breaker_close_btn", function(){});

            /***** Create PopUp *****/
        init.popUps.FlowerPopUpInit.init();
        init.popUps.InventoryPopUpInit.init();
        init.popUps.BreakerPopUpInit.init();
        init.popUps.HeaderPopUpInit.init();
        init.popUps.OpenFruitPopUpInit.init();

        popUpEngine.show("header");
        popUpEngine.show("openFruit");
    }
}