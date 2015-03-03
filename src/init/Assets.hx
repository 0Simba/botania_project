package init;

import init.Config;
import engine.isoEngine.IsoEngine;
import engine.isoEngine.components.Tile;
import js.html.Event;
import pixi.loaders.JsonLoader;
import utils.Vector2;
import engine.isoEngine.managers.AnimParams;

class Assets
{

    static private var isoEngine:IsoEngine;
    static private var biomesAndBuildingData:JsonLoader;
    static private var nbLoaded = 0;


    static public function load () {
        Tile.setSize(new Vector2(Config.display.tile.xSize, Config.display.tile.ySize));
        isoEngine = IsoEngine.getInstance();

        for (i in 0...Config.assets.jsonList.length) {
            var element = new JsonLoader("./assets/" + Config.assets.jsonList[i] + ".json");
            element.addEventListener("loaded", function (pEvent:Event) {
                preloadAssets(pEvent, element, Config.assets.jsonList[i]);
            });
            element.load();
        }
    }

    static private function preloadAssets (pEvent:Event, target:JsonLoader, animationName) {
        target.removeEventListener("loaded", preloadAssets);
        var myDatas    = cast(pEvent.target, JsonLoader).json;
        var frames     = myDatas.frames;
        extractAnimParams(animationName, myDatas.animParams);
        var anchor;
        var size;
        var cObj;

        var list:Array<String> = new Array<String>();
        for (name in Reflect.fields(frames)) {
            cObj = frames[cast name];
            list.push(name);

            size = (cObj.size != null) ? new Vector2(cObj.size.w, cObj.size.h) : new Vector2(cObj.frame.w, cObj.frame.h);
            isoEngine.assets.addTexture(name, name, size);

            if ((anchor = cObj.anchor) != null) {
                isoEngine.assets.addAnchor(name, anchor);
            }
        }
        isoEngine.assets.createAnimation(animationName, list);
        assetLoaded();
    }

    static private function extractAnimParams (name:String, params:Dynamic) {
        if (params != null) {
            new AnimParams(name, params.speed, cast params.anchor, cast params.size);
        }
    }

    static private function assetLoaded () {
        nbLoaded++;
        if (nbLoaded >= Config.assets.jsonList.length) {
            Main.ready();
        }
    }
}
