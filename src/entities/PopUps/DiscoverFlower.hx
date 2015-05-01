package entities.popUps;

import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import entities.popUps.PopUpMain;
import pixi.text.Text.TextStyle;
import entities.genetic.Genome;
import engine.isoEngine.components.Hud;
import engine.isoEngine.components.Text;
import entities.Flower;
import manager.FacebookActions;
import entities.popUps.blocs.DisplayFlowerBlocs;

class DiscoverFlower extends PopUpMain
{

    static private var genomeCode:String = "DDD";
    static private var flower:Flower;

    static public function params (_flower:Flower) {
        flower = _flower;
        genomeCode = flower.genome.getAppearanceName();
    }


    private var text:Text;
    private var flowerBlocs:DisplayFlowerBlocs;


    public function new () {
        super("discoverFlowerPopUp", new Vector2(0.5, 0.5), new Vector2(0.7, 0.45, "%", "%x"));

        initBasicBlocs();
        setText();
        flowerBlocs = new DisplayFlowerBlocs(this, new Vector2(0.25, 0.45, "%", "%"), new Vector2(0.86, 0.5, "%y", "%"));
        addShareButton();

        onShow = function () {
            updateFlowerAppearance();
            tweenShow();
        }
    }


    private function updateFlowerAppearance () {
        var flowerName = Flower.getName(genomeCode);
        text.setText("Félicitation !\nVous avez découvert la\n" + flowerName);
        flowerBlocs.update(genomeCode);
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


    private function addShareButton () {
        addButton(new Vector2 (0.6, 0.45), new Vector2 (1, 0.3, "%y", "%"), new Vector2(0.5, 0.5), "facebookShare", function () {
            FacebookActions.shareNewFlower(flower);
            tweenHide();
        });
    }
}

