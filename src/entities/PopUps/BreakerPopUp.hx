package entities.popUps;

import engine.isoEngine.components.ColorMatrixFilters;
import engine.tween.Tween;
import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.Cell;
import engine.popUpEngine.Bloc;
import entities.Seed;
import engine.popUpEngine.PopUp;
import engine.isoEngine.IsoEngine;
import Map;
import engine.tween.Ease;
import entities.popUps.PopUpMain;

class BreakerPopUp extends PopUpMain
{

    private var seed1:engine.isoEngine.components.Hud;
    private var seed2:engine.isoEngine.components.Hud;

	public function new () {
        super("breakerInterface", new Vector2(0.5, 0.5), new Vector2(0.8, 0.8));
        applyAnchor(0.5, 0.5);

        popUpEngine  = PopUpEngineMain.getInstance();

        setDefaultsElements();
        // setSeedsInventory();
        createTween();
        setSeedsInventory();
	}

    private function setDefaultsElements () {
        var assets = IsoEngine.getInstance().assets;
        addBloc("fond_en", new Vector2(0, 0), new Vector2(1, 1));
        var b = addButtonPattern("close");
        b.onClick(tweenHide);
        //addBloc("concasser_en_ltl",new Vector2(0.66, 0.835), assets.getSize("concasser_en_ltl"));
        addBloc("plus_ltl", new Vector2(0.66, 0.74), assets.getSize("plus_ltl"));
        // addBloc("plus_ltl", new Vector2(0.78, 0.74), assets.getSize("plus_ltl"));

        seed1 = addBloc("fond_fleur_graine", new Vector2(0.58, 0.72), assets.getSize("fond_fleur_graine"));
        seed2 = addBloc("fond_fleur_graine", new Vector2(0.705, 0.72), assets.getSize("fond_fleur_graine"));
        seed1.setDroppable();
        seed2.setDroppable();

        addButton(new Vector2(0.66, 0.835), assets.getSize("concasser_button_en_ltl"), new Vector2(0, 0), "concasser_button_en_ltl", mergeSeeds);
        onShow = updateAndShow;
    }

    private function updateAndShow () {
        tweenShow();
        updateSeedsInventory();
    }


    private function setSeedsInventory () {
        setInventory(new Vector2(0.07, 0.15), new Vector2(0.38, 0.74),  new Vector2(0.20, 0.20), 5, -1);

        updateSeedsInventory();
    }

    private function updateSeedsInventory () {
        inventory.clear();
        for (i in 0...Seed.list.length) {
            var cell:Cell = inventory.addCell();
            var name = Seed.list[i].appearanceName;

            cell.addBloc("darkGray", new Vector2 (0.02, 0.02), new Vector2 (0.96, 0.96));
            var cont = cell.addContainer(new Vector2(1, 1));

            cont.addBloc("colo"  + name.charAt(0) + name.charAt(2), new Vector2 (0, 0, "%", "%"), new Vector2 (1, 1, "%", "%"));
            var motif = cont.addBloc("motif" + name.charAt(0) + name.charAt(1), new Vector2 (0, 0, "%", "%"), new Vector2 (1, 1, "%", "%"));
            // motif.bindEvent();

            cont.setDraggable(Seed.list[i]);
        }
    }

    private function mergeSeeds () {
        if (seed1.dropMeta != null && seed2.dropMeta != null) {
            seed1.dropMeta.merge(seed2.dropMeta);

            seed1.clearDrop();
            seed2.clearDrop();

            updateSeedsInventory();
        }
    }

}

