package init;

import engine.isoEngine.components.Button;
import utils.Vector2;
import lib.FB;
import lib.Howler;
import lib.Howl;
import engine.popUpEngine.PopUpEngineMain;

class ForTest
{
    static private var popUpEngine:PopUpEngineMain;
    static private var size = new Vector2(75, 75);
    static private var pos  = new Vector2(20, 20);

    static private var snd:Howl;

    static public function loadLast () {
    }

    static public function load () {
        popUpEngine = PopUpEngineMain.getInstance();

        var button = new Button();
        button.set(size, pos, "white", "hud");
        button.onClick(cast function () {
            popUpEngine.show("openFruit");
        });
    }
}
