package manager;

import engine.isoEngine.components.Button;
import utils.Vector2;
import lib.FB;
import lib.Howler;
import lib.Howl;
import engine.popUpEngine.PopUpEngineMain;
import Map;
import engine.isoEngine.IsoEngine;

class Sounds
{

    static private var isMute:Bool = false;
    static private var sounds:Map<String, Howl>;
    static private var isoEngine:IsoEngine;



    static public function init () {
        isoEngine = IsoEngine.getInstance();
        sounds    = new Map<String, Howl>();
        setMusic();
        setButtonClick();
        setOpen();
        setHide();
        setPlant();
    }


    static public function toggleMute () {
        if (!isMute) {
            sounds.get("music").stop();
        }
        else {
            sounds.get("music").play();
        }
        isMute = !isMute;
    }


    static public function isItMute () {
        return isMute;
    }


    static public function play (name:String) {
        if (isMute) return;
        if (!sounds.exists(name)) {
            trace("Pas de son enregistré sous " + name);
            return;
        }
        sounds.get(name).play();
    }




    /*=========================================
    =            Private/init part            =
    =========================================*/


    static private function setMusic () {
        var options:Dynamic = {
            urls     : ['./sounds/music.wav'],
            autoplay : true,
            loop     : true,
            volume   : 1
        };

        sounds.set("music", new Howl(options));
    }


    static private function setButtonClick () {
        var options = getClassicOptions("./sounds/buttonClick.wav");

        var buttonClick = new Howl(options);
        sounds.set("buttonClick", buttonClick);

        isoEngine.events.on("buttonOver", function () {
            Sounds.play("buttonClick");
        });
    }


    static private function setOpen () {
        var options = getClassicOptions("./sounds/open.wav");
        sounds.set("open", new Howl(options));
    }


    static private function setHide () {
        var options = getClassicOptions("./sounds/hide.wav");
        sounds.set("hide", new Howl(options));
    }


    static private function setPlant () {
        var options = getClassicOptions("./sounds/plant.wav");
        sounds.set("plant", new Howl(options));
    }


    static private function getClassicOptions (url:String) {
        var options:Dynamic = {
            urls     : [url],
            autoplay : false,
            loop     : false,
            volume   : 1
        };

        return options;
    }
}
