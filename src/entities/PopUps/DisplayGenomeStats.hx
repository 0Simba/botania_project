package entities.popUps;

import entities.genetic.Genome;
import engine.isoEngine.components.Text;
import utils.Vector2;
import entities.Flower;

class DisplayGenomeStats extends PopUpMain
{

    static private var genomeCode:String;
    static private var flower:Flower;

    static public function setParams (_flower:Flower) {
        flower     = _flower;
        genomeCode = flower.genome.getAppearanceName();
    }


    public var flowerName:Text;


    public function new () {
        super("displayGenomeStats", new Vector2(0.5, 0.5), new Vector2(0.7, 0.45, "%", "%x"));

        initBasicBlocs();
        setFlowerBlocs(new Vector2(0.05, 0.25, "%", "%"), new Vector2(0.86, 0.7, "%y", "%"));

        onShow = function () {
            updateFlowerBlocs(genomeCode);
            tweenShow();
        }
    }

}

