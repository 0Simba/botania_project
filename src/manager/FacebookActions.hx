package manager;

import lib.FB;
import entities.Flower;

class FacebookActions  {
    static public function shareNewFlower (flower:Flower) {
        var name = flower.genome.getAppearanceName();

        trace(name);
        #if js
        FB.ui({
            method           : "share_open_graph",
            action_type      : "botania:get",
            action_properties: haxe.Json.stringify({
                flower:"https://fbgame.isartdigital.com/isartdigital/botaniaproject/bin/index.php?displayFlower=" + name.toLowerCase()
            })
        }, function(response){});
        #end
    }
}
