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
        var options:Dynamic = {
            urls     : ['./sounds/buttonClick.wav'],
            autoplay : false,
            loop     : false,
            volume   : 1
        };

        var buttonClick = new Howl(options);
        sounds.set("buttonClick", buttonClick);

        isoEngine.events.on("buttonClicked", function () {
            Sounds.play("buttonClick");
        });
    }
}
