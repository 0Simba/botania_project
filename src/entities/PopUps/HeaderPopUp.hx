package entities.popUps;

import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.PopUp;
import entities.popUps.PopUpMain;

class HeaderPopUp extends PopUpMain
{
    public function new () {

        super("header", new Vector2(0.5, 0.03), new Vector2(600, 123, "px", "px"));
        applyAnchor(0.5, 0);
        addBloc("headerGround", new Vector2(0, 0), new Vector2(1, 1)).displayObject.interactive = false;
        addButton(new Vector2(0.74, 0.90), new Vector2(0.09, 0.85, "%", "%x"), new Vector2(0, 0), "inventoryBtn", function () {
            popUpEngine.show("inventoryInterface");
        });
        addButton(new Vector2(0.86, 0.90), new Vector2(0.09, 0.85, "%", "%x"), new Vector2(0, 0), "shopBtn", function () {
        });
        addButton(new Vector2(0.20, 0.90), new Vector2(0.065, 0.85, "%", "%x"), new Vector2(0, 0), "unmuteBtn", function () {
        });
        addButton(new Vector2(0.28, 0.90), new Vector2(0.065, 0.85, "%", "%x"), new Vector2(0, 0), "Fullscreen", function () {
        });
    }
}