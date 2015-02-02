package init;

import engine.popUpEngine.PopUpEngineMain;
import utils.Vector2;

class PopUp
{

    static public function load () {
        var popUpEngine = PopUpEngineMain.getInstance();

        // popUpEngine.createBlocPattern("background",  Vector2.zero, Vector2.full, "pickBasic");
        popUpEngine.createBlocPattern("background", Vector2.full, Vector2.zero, "pickBasic");


        var breakerPopUp = popUpEngine.createPopUp("breakerPopUp", new Vector2(0.1, 0.1), new Vector2(0.8, 0.8));
        breakerPopUp.addGenericBloc("background");
        breakerPopUp.addBloc(new Vector2(0.7, 0.7), new Vector2(0.2, 0.2), "automn");


        var flowerPopUp = popUpEngine.createPopUp("flowerPopUp", new Vector2(0.1, 0.1), new Vector2(0.8, 0.8));
        flowerPopUp.addGenericBloc("background");
        flowerPopUp.addBloc(new Vector2(0.7, 0.7), new Vector2(0.4, 0.2), "savana");

        // breakerPopUp.show();
        // flowerPopUp.show();
    }

}