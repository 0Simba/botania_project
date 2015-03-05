package init;

import engine.circleHud.CirclesHudEngine;
import utils.Vector2;
import manager.Map;
import entities.genetic.Genome;

class PlayerDatas
{
    static private var map:Map;

    static public function load () {
        utils.AjaxRequest.exec("allDatas", null, callback);
    }

    static private function callback (response:Dynamic) {
        map = manager.Map.getInstance();

        if (response.accepted) {
            loadBuildings(response.buildings);
            loadFlowers(response.flowers);
        }
        else {
            js.Browser.window.alert("Erreur l'ors du chargement de vos données");
        }
    }

    static private function loadBuildings (buildings:Dynamic) {
        for (i in 0...buildings.length) {
            var building = buildings[i];
            var tile     = map.get(Std.parseInt(building.X), Std.parseInt(building.Y));
            tile.create(building.Type);
        }
    }

    static private function loadFlowers (flowers:Dynamic) {
        for (i in 0...flowers.length) {
            var flower = flowers[i];
            var tile   = map.get(Std.parseInt(flower.X), Std.parseInt(flower.Y));

            tile.flowerLoaded(flower.LastTimeStamp, Genome.newFromCode(flower.Genome), flower.StateIndex);
        }
    }
}
