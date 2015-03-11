package entities.popUps;

import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.PopUp;
import entities.popUps.PopUpMain;

class HeaderPopUp extends PopUpMain
{
    public function new () {

        super("header", new Vector2(0.15, 0), new Vector2(0.7, 0.2, "%", "%x"));

        addBloc("headerGround", new Vector2(0, 0), new Vector2(1, 1));
        addButton(new Vector2(0.74, 0.71), new Vector2(0.09, 0.85, "%", "%x"), new Vector2(0, 0), "inventoryBtn", function () {
            popUpEngine.show("inventoryInterface");
        });
        addButton(new Vector2(0.86, 0.71), new Vector2(0.09, 0.85, "%", "%x"), new Vector2(0, 0), "shopBtn", function () {
        });
        addButton(new Vector2(0.20, 0.71), new Vector2(0.065, 0.85, "%", "%x"), new Vector2(0, 0), "unmuteBtn", function () {
        });
        addButton(new Vector2(0.28, 0.71), new Vector2(0.065, 0.85, "%", "%x"), new Vector2(0, 0), "Fullscreen", function () {
        });
    }
}