package init;

import engine.isoEngine.IsoEngine;

/**
 * ...
 * @author jaf
 */
class Assets
{

    static private var isoEngine:IsoEngine;

    static public function load () {
        isoEngine = IsoEngine.getInstance(1120, 630);
        isoEngine.setTileSize(128);

        isoEngine.load(["../assets/isoTiles.json"], assetLoaded);
    }

    static private function assetLoaded () {
        isoEngine.addTexture("ground", "isometricPattern.jpg");
        var list:Array<String> = new Array<String>();
        list.push("ground");
        isoEngine.createAnimation("ground", list);

        Main.ready();
    }
}