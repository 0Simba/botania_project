package init;

import engine.circleHud.CirclesHudEngine;
import utils.Vector2;
import manager.Map;
import entities.genetic.Genome;
import entities.popUps.HeaderPopUp;
import entities.Seed;
import entities.Fruit;


class PlayerDatas
{
    static private var map:Map;
    static public  var suns:Int;
    static public  var gold:Int;


    static public function load () {
        utils.AjaxRequest.exec("allDatas", null, callback);
    }


    static private function callback (response:Dynamic) {
        map = manager.Map.getInstance();
        if (response.accepted) {
            loadPlayerDatas(response.datas);
            loadBuildings(response.buildings);
            loadSeeds(response.seeds);
            loadFlowers(response.flowers, response.serverTimeStamp);
            loadFruits(response.fruits);
        }
        else {
            js.Browser.window.alert("Erreur lors du chargement de vos données");
        }
    }


    static private function loadBuildings (buildings:Dynamic) {
        for (i in 0...buildings.length) {
            var building = buildings[i];
            var tile     = map.get(Std.parseInt(building.X), Std.parseInt(building.Y));
            tile.create(building.Type);
        }
    }


    static private function loadFlowers (flowers:Dynamic, serverTimeStamp:Int) {
        for (i in 0...flowers.length) {
            var flower = flowers[i];
            var tile   = map.get(Std.parseInt(flower.X), Std.parseInt(flower.Y));

            tile.flowerLoaded(flower.LastTimeStamp, serverTimeStamp, Genome.newFromCode(flower.Genome), flower.StateIndex, flower.ID);
        }
    }


    static private function loadSeeds (seeds:Dynamic) {
        for (i in 0...seeds.length) {
            var seed = seeds[i];
            new Seed(Genome.newFromCode(seed.Genome), Std.int(seed.Level), false, seed.ID);
        }
    }

    static private function loadFruits (fruits:Dynamic) {
        if (fruits == null) return;

        for (i in 0...fruits.length) {
            var fruit = fruits[i];
            new Fruit(Genome.newFromCode(fruit.Genome), Std.int(fruit.Quality), false, fruit.ID);
        }
    }

    static private function loadPlayerDatas (datas:Dynamic) {
        suns = cast datas[0].Sun;
        gold = cast datas[0].Gold;
        HeaderPopUp.getInstance().setCurrencies(getInstance());
    }


    static public function getInstance():Dynamic{
        return {suns: suns, gold: gold};
    }
}
