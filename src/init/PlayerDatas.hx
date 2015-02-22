package init;

import engine.circleHud.CirclesHudEngine;
import utils.Vector2;

class PlayerDatas
{
    static public function load () {
        utils.AjaxRequest.exec("allDatas", null, callback);
    }

    static private function callback (response) {
        if (response.accepted) {
        }
        else {
            js.Browser.window.alert("Erreur l'ors du chargement de vos données");
        }
    }
}
