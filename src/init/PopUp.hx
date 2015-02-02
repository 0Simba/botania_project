package init;

import engine.popUpEngine.PopUpEngineMain;
import utils.Vector2;

class PopUp
{

    static public function load () {
        var popUpEngine = PopUpEngineMain.getInstance();

        var breakerPopUp = popUpEngine.create("breakerPopUp", new Vector2(0.1, 0.1), new Vector2(0.8, 0.8));
        breakerPopUp.addBloc(new Vector2(0.1, 0.1), new Vector2(0.8, 0.8), "savana");
        breakerPopUp.addBloc(new Vector2(0.7, 0.7), new Vector2(0.2, 0.2), "automn");


        var flowerPopUp = popUpEngine.create("flowerPopUp", new Vector2(0.1, 0.1), new Vector2(0.8, 0.8));
        flowerPopUp.addBloc(new Vector2(0.1, 0.1), new Vector2(0.8, 0.8), "automn");
        flowerPopUp.addBloc(new Vector2(0.7, 0.7), new Vector2(0.4, 0.2), "savana");

        // breakerPopUp.show();
        // flowerPopUp.show();
    }

}