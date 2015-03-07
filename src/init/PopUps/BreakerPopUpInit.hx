package init.popUps;

import engine.tween.Tween;
import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.Cell;
import engine.popUpEngine.Bloc;
import entities.Seed;
import engine.popUpEngine.PopUp;
import Map;

class BreakerPopUpInit
{

    static private var seed1:engine.isoEngine.components.Hud;
    static private var seed2:engine.isoEngine.components.Hud;
    static private var popUpEngine:PopUpEngineMain;
    static private var breakerPopUp;
    static private var tween:Tween;

	public static function init () {
        popUpEngine  = PopUpEngineMain.getInstance();
        breakerPopUp = popUpEngine.createPopUp("breakerInterface", new Vector2(0.1, 0.1), new Vector2(0.8, 0.8));

        setDefaultsElements();
        setSeedsInventory();
        setSeedsMergingElements();
        createTween();
	}

    static private function setDefaultsElements () {
        breakerPopUp.addBlocPattern("background");
        breakerPopUp.addBlocPattern("border");
        breakerPopUp.addBlocPattern("florist");
        breakerPopUp.addButtonPattern("close").onClick(function () {
            breakerPopUp.hide();
        });

        breakerPopUp.addText(new Vector2(0.25, 0.02), new Vector2(0.5, 0.5), "Concasseur", {"font" : "bold 20px verdana", "fill" : "white", "align" : "center"});
        breakerPopUp.onShow = onShow;
    }


    static private function setSeedsInventory () {
        breakerPopUp.setInventory(new Vector2(0.07, 0.085), new Vector2(0.6, 0.6),  new Vector2(0.33, 0.33), 3, -1);

        updateSeedsInventory();
    }

    static private function updateSeedsInventory () {
        breakerPopUp.inventory.clear();

        for (i in 0...Seed.list.length) {
            var cell:Cell = breakerPopUp.inventory.addCell();
            var name = Seed.list[i].appearanceName;

            cell.addBloc("darkGray", new Vector2 (0.02, 0.02), new Vector2 (0.96, 0.96));
            var cont = cell.addContainer(new Vector2(1, 1));
            cont.addBloc("F" + name.charAt(0), new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8));
            cont.addBloc("O" + name.charAt(1), new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8));
            cont.addBloc("G" + name.charAt(2), new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8));
            cont.setDraggable(Seed.list[i]);
        }
    }

    static private function setSeedsMergingElements () {
        seed1 = cast breakerPopUp.addBloc("dark", new Vector2(0.2, 0.7), new Vector2(-1, 0.18));
        seed2 = cast breakerPopUp.addBloc("dark", new Vector2(0.5, 0.7), new Vector2(-1, 0.18));
        seed1.setDroppable();
        seed2.setDroppable();

        var but = breakerPopUp.addButton(new Vector2(0.37, 0.75), new Vector2(-1, 0.1), "lightGray", mergeSeeds);
    }

    static private function mergeSeeds () {
        if (seed1.dropMeta != null && seed2.dropMeta != null) {
            seed1.dropMeta.merge(seed2.dropMeta);

            seed1.clearDrop();
            seed2.clearDrop();

            updateSeedsInventory();
        }
    }

    static private function onShow () {
        updateSeedsInventory();
        tween.start();
    }

    static private function createTween () {
        var from = new Map<String, Float>();
        from.set("y", -100);

        var to = new Map<String, Float>();
        to.set("y", 100);

        tween = new Tween (from, to, 1000);
        tween.onUpdate(function (currentDatas) {
            breakerPopUp.replace(new Vector2(currentDatas.get("y"), currentDatas.get("y")));
        });
        // tween.on
    }
}

