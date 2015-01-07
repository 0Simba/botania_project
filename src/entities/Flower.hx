package entities;

import entities.Tile;

class Flower extends GameObject
{
    private var referent:Tile;

    private var state:String;

    public function new (_referent, _state = "baby") {
        super();

        referent = _referent;
        state    = _state;

        haxe.Timer.delay(endDelay, 2000);
    }


    public function endDelay () {
        
    }


    /***** CONFIG *****/

    private var timeToBeAdult = 5;

}
