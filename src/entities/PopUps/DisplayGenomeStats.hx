package entities.popUps;

import entities.genetic.Genome;
import engine.isoEngine.components.Text;
import utils.Vector2;
import entities.Flower;
import engine.isoEngine.components.Hud;

import entities.popUps.blocs.DisplayFlowerBlocs;
import pixi.text.Text.TextStyle;

class DisplayGenomeStats extends PopUpMain
{

        /*==============================
        =            Static            =
        ==============================*/

    static private var flower:Flower;

    static public function setParams (_flower:Flower) {
        flower     = _flower;
    }


    static private var flowersSize:Vector2 = new Vector2(0.86, 0.6, "%y", "%");
    static private var namesSize  :Vector2 = new Vector2(0.25, 0.1, "%",  "%");
    static private var flowersY   :Float   = 0.3;
    static private var namesY     :Float   = 0.2;
    static private var namesStyle :TextStyle;




        /*================================
        =            Instance            =
        ================================*/

    private var flowerName  :Text;
    private var flowersBlocs:Array<DisplayFlowerBlocs>;
    private var flowersNames:Array<Text>;

    public function new () {
        super("displayGenomeStats", new Vector2(0.5, 0.5), new Vector2(0.7, 0.45, "%", "%x"));

        initBasicBlocs();
        setNamesStyle();
        setFlowersBlocs();
        setFlowersNames();

        onShow = function () {
            updateFlowers();
            tweenShow();
        }
    }


    private function updateFlowers () {
        displayFlowerIndex(0);

        if (flower.genome.secondary != null) displayFlowerIndex(1);
        else hideFlowerIndex(1);

        if (flower.genome.tertiaire != null) displayFlowerIndex(2);
        else hideFlowerIndex(2);
    }

    private function displayFlowerIndex (i:Int) {
        var genomeCode:String = (i == 0) ? flower.genome.principal.getAsName() :
                                (i == 1) ? flower.genome.secondary.getAsName() :
                                           flower.genome.tertiaire.getAsName() ;

        flowersBlocs[i].show();
        flowersBlocs[i].update(genomeCode);
        flowersNames[i].setText(Flower.getName(genomeCode));
    }


    private function hideFlowerIndex (i:Int) {
        flowersBlocs[i].hide();
        flowersNames[i].setText("");
    }


    private function setFlowersBlocs () {
        flowersBlocs    = new Array<DisplayFlowerBlocs>();
        flowersBlocs[0] = new DisplayFlowerBlocs(this, new Vector2(0.05, flowersY), flowersSize);
        flowersBlocs[1] = new DisplayFlowerBlocs(this, new Vector2(0.30, flowersY), flowersSize);
        flowersBlocs[2] = new DisplayFlowerBlocs(this, new Vector2(0.55, flowersY), flowersSize);
    }


    private function setFlowersNames () {
        flowersNames    = new Array<Text>();
        flowersNames[0] = addText(new Vector2(0.05, namesY), flowersSize, "test", namesStyle);
        flowersNames[1] = addText(new Vector2(0.30, namesY), flowersSize, "test", namesStyle);
        flowersNames[2] = addText(new Vector2(0.55, namesY), flowersSize, "test", namesStyle);
    }


    private function setNamesStyle () {
        namesStyle = {
            fill          : "white",
            font          : "bold 25px arial",
            align         : "center",
            wordWrap      : true,
            wordWrapWidth : 220
        };
    }

}

