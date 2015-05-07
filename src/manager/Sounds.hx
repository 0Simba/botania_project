package manager;

import engine.isoEngine.components.Button;
import utils.Vector2;
import lib.FB;
import lib.Howler;
import lib.Howl;
import engine.popUpEngine.PopUpEngineMain;
import Map;

class Sounds
{

    static private var isMute:Bool = false;
    static private var sounds:Map<String, Howl>;

    static public function init () {
        sounds = new Map<String, Howl>();
        setMusic();
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


    static private function setMusic () {
        var options:Dynamic = {
            urls     : ['./sounds/music.wav'],
            autoplay : true,
            loop     : true,
            volume   : 1
        };

        sounds.set("music", new Howl(options));
    }

}
