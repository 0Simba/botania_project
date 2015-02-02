package init;

import engine.popUpEngine.PopUpEngineMain;
import utils.Vector2;

class PopUp
{

    static public function load () {
        var popUpEngine = PopUpEngineMain.getInstance();
        var welcome     = popUpEngine.create("welcome" , new Vector2(0.8, 0.8) , new Vector2(0.1, 0.1));

        // welcome.addBloc();
    }

}