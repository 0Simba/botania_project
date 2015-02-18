package init.popUps;

import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.PopUp;

class HeaderPopUpInit
{
    public static function init () {
        var popUpEngine = PopUpEngineMain.getInstance();

        var headerPopUp:PopUp = popUpEngine.createPopUp("header", new Vector2(0.15, 0), new Vector2(0.7, 0.25, "%", "%x"));
        headerPopUp.addBloc("headerGround", new Vector2(0, 0), new Vector2(1, 0.83));
        headerPopUp.addButton(new Vector2(0.74, 0.71), new Vector2(0.09, 0.85, "%", "%x"), "chest", "chest", "chest", function () {
            popUpEngine.show("inventoryInterface");
        });
        headerPopUp.addButton(new Vector2(0.86, 0.71), new Vector2(0.09, 0.85, "%", "%x"), "caddy", "caddy", "caddy", function () {
        });
        var t = headerPopUp.addText(new Vector2(0.02, 0.3), new Vector2(0.6, 0.5), "Botania", {"font" : "80px verdana", "fill" : "orange", "dropShadow" : true, "dropShadowColor" : "white", "stroke" : "green", "strokeThickness" : 4});
        trace(t);
    }
}