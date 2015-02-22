package init.popUps;

import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.Cell;
import engine.popUpEngine.Bloc;
import entities.Seed;
import engine.popUpEngine.PopUp;

class BreakerPopUpInit
{

    static private var seed1:engine.isoEngine.components.Hud;
    static private var seed2:engine.isoEngine.components.Hud;
    static private var popUpEngine:PopUpEngineMain;
    static private var breakerPopUp;

	public static function init () {
        popUpEngine  = PopUpEngineMain.getInstance();
        breakerPopUp = popUpEngine.createPopUp("breakerInterface", new Vector2(0.1, 0.1), new Vector2(0.8, 0.8));

        setDefaultsElements();
        setSeedsInventory();
        setSeedsMergingElements();
	}

    static private function setDefaultsElements () {
        breakerPopUp.addBlocPattern("background");
        breakerPopUp.addBlocPattern("border");
        breakerPopUp.addBlocPattern("florist");
        breakerPopUp.addButtonPattern("close").onClick(function () {
            breakerPopUp.hide();
        });

        breakerPopUp.addText(new Vector2(0.25, 0.02), new Vector2(0.5, 0.5), "Concasseur", {"font" : "bold 20px verdana", "fill" : "white", "align" : "center"});
    }


    static private function setSeedsInventory () {
        breakerPopUp.setInventory(new Vector2(0.07, 0.085), new Vector2(0.6, 0.6),  new Vector2(0.33, 0.33), 3, -1);

        for (i in 0...Seed.list.length) {
            var cell:Cell = breakerPopUp.inventory.addCell();

            cell.addBloc("darkGray", new Vector2 (0.02, 0.02), new Vector2 (0.96, 0.96));
            cell.addBloc(Seed.list[i].appearanceName, new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8)).setDraggable(Seed.list[i]);
        }
    }

    static private function setSeedsMergingElements () {
        seed1 = cast breakerPopUp.addBloc("dark", new Vector2(0.2, 0.7), new Vector2(-1, 0.18)); // cast to rectify haxe comilation fail
        seed2 = cast breakerPopUp.addBloc("dark", new Vector2(0.5, 0.7), new Vector2(-1, 0.18));
        seed1.setDroppable();
        seed2.setDroppable();

        var but = breakerPopUp.addButton(new Vector2(0.37, 0.75), new Vector2(-1, 0.1), "lightGray", "gray", "darkGray", mergeSeeds);
    }

    static private function mergeSeeds () {
        
    }
}

