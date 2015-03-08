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
        headerPopUp.addButton(new Vector2(0.74, 0.71), new Vector2(0.09, 0.85, "%", "%x"), new Vector2(0, 0), "inventoryBtn", function () {
            popUpEngine.show("inventoryInterface");
        });
        headerPopUp.addButton(new Vector2(0.86, 0.71), new Vector2(0.09, 0.85, "%", "%x"), new Vector2(0, 0), "shopBtn", function () {
        });
        headerPopUp.addButton(new Vector2(0.20, 0.71), new Vector2(0.065, 0.85, "%", "%x"), new Vector2(0, 0), "unmuteBtn", function () {
        });
        headerPopUp.addButton(new Vector2(0.28, 0.71), new Vector2(0.065, 0.85, "%", "%x"), new Vector2(0, 0), "Fullscreen", function () {
        });
    }
}