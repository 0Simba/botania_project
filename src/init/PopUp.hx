package init;

import engine.popUpEngine.PopUpEngineMain;
import utils.Vector2;

class PopUp
{

    static public function load () {
        var popUpEngine = PopUpEngineMain.getInstance();
        var welcome     = popUpEngine.create("welcome", new Vector2(0.1, 0.1), new Vector2(0.8, 0.8));

        welcome.addBloc(new Vector2(0.1, 0.1), new Vector2(0.8, 0.8), "savana");
        welcome.addBloc(new Vector2(0.7, 0.7), new Vector2(0.2, 0.2), "automn");
    }

}