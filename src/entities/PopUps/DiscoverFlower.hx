package entities.popUps;

import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import entities.popUps.PopUpMain;
import pixi.text.Text.TextStyle;
import entities.genetic.Genome;
import engine.isoEngine.components.Hud;
import engine.isoEngine.components.Text;
import entities.Flower;

class DiscoverFlower extends PopUpMain
{

    static private var genomeCode:String = "DDD";

    static public function params (_genomeCode:String) {
        genomeCode = _genomeCode;
    }


    private var displayFlowerBlocs:Array<Hud>;
    private var text:Text;


    public function new () {
        super("discoverFlowerPopUp", new Vector2(0.5, 0.5), new Vector2(0.7, 0.45, "%", "%x"));

        displayFlowerBlocs = new Array<Hud>();
        initBasicBlocs();
        setText();
        setFlowerBlocs();

        onShow = function () {
            updateFlowerAppearance();
            tweenShow();
        }
    }


    private function updateFlowerAppearance () {
        var flowerName = Flower.getName(genomeCode);
        text.setText("Félicitation !\nVous avez découvert une : \n" + flowerName);
        displayFlowerBlocs[0].changeTexture("O" + genomeCode.charAt(1));
        displayFlowerBlocs[1].changeTexture("F" + genomeCode.charAt(0));
        displayFlowerBlocs[2].changeTexture("G" + genomeCode.charAt(2));
    }


    private function setFlowerBlocs () {
        var position:Vector2 = new Vector2(0.25, 0.45, "%", "%");
        var size:Vector2     = new Vector2(0.86, 0.5, "%y", "%");

        displayFlowerBlocs[0] = addBloc("GA", position, size);
        displayFlowerBlocs[1] = addBloc("OA", position, size);
        displayFlowerBlocs[2] = addBloc("FA", position, size);
    }


    private function initBasicBlocs () {
        applyAnchor(0.5, 0.5);

        addBloc("openFruitBackground", new Vector2(0, 0), new Vector2(1, 1));
        addButtonPattern("close").onClick(function () {
            tweenHide();
        });
    }

    private function setText () {
        var style:TextStyle = {
            fill          : "white",
            font          : "bold 25px arial",
            align         : "center",
            wordWrap      : true,
            wordWrapWidth : 450
        };
        text = addText(new Vector2(0.15, 0.25), Vector2.full, "Félicitation !\nVous avez découvert une nouvelle fleur !", style);
    }
}

