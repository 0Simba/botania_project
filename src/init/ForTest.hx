package init;

import engine.isoEngine.components.Button;
import utils.Vector2;
import lib.FB;

class ForTest
{

    static private var size = new Vector2(75, 75);
    static private var pos  = new Vector2(20, 20);

    static public function load () {
        var button = new Button();
        button.set(size, pos, "white", "hud");
        button.onClick(cast function () {
            trace("ok viens de click");
            #if js
            FB.ui({method : "share", href : "http://samples.ogp.me/1432574127054546"}, function (response) {
                trace("normalement c'est bon");
                trace(response);
            });
            #end
        });
    }
}

    // FB.api(
    //     'me/botania:get',
    //     'post',
    //     {
    //         flower: "http://samples.ogp.me/1432574127054546"
    //     },
    //     function(response) {
    //         trace(response);
    //         // handle the response
    //     }
    // );
// );

