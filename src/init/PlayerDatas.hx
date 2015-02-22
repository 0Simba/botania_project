package init;

import engine.circleHud.CirclesHudEngine;
import utils.Vector2;

class PlayerDatas
{
    static public function load () {
        utils.AjaxRequest.exec("allDatas", null, callback);
    }

    static private function callback (response:Dynamic) {
        var map = manager.Map.getInstance();

        if (response.accepted) {
            for (i in 0...response.buildings.length) {
                var building = response.buildings[i];
                var tile     = map.get(Std.parseInt(building.X), Std.parseInt(building.Y));
                tile.create(building.Type);
            }
        }
        else {
            js.Browser.window.alert("Erreur l'ors du chargement de vos données");
        }
    }
}
