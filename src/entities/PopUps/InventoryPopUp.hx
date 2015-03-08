package entities.popUps;

import utils.Vector2;
import engine.popUpEngine.PopUpEngineMain;
import engine.popUpEngine.Cell;
import entities.Seed;
import engine.isoEngine.components.Button;
import engine.popUpEngine.PopUp;
import engine.popUpEngine.Inventory;
import engine.isoEngine.IsoEngine;
import manager.Selection;
import engine.popUpEngine.Bloc;
import engine.isoEngine.components.Hud;
import engine.popUpEngine.Container;
import entities.popUps.PopUpMain;

class InventoryPopUp extends PopUpMain
{

    private var seedsTab:Container;
    private var trashButton:Button;
    private var selectedSeed:Seed;
    private var buildingInventory:Inventory;
    private var background:Hud;
    private var tabs:Array<String>;


	public function new () {
        super("inventoryInterface", new Vector2(0.5, 0.5), new Vector2(0.8, 0.8));
        applyAnchor(0.5, 0.5);

        var assets = IsoEngine.getInstance().assets;
        var popUpEngine = PopUpEngineMain.getInstance();

        background = addBloc("mainFR", new Vector2(0.2, 0.1), new Vector2(1.14, 1, "%y", "%"));

        var buildingContainer = addContainer(new Vector2(1, 1));
        buildingInventory = buildingContainer.setInventory(new Vector2(0.23, 0.2), new Vector2(0.55, 0.63), new Vector2(0.25, 0.35, "%", "%x"), 4, -1);

        tabInit();

        /* MAIN CLOSE BUTTON */
        addButton(new Vector2(0.8, 0.1), new Vector2(0.05, 1, "%", "%x"), Vector2.zero, "close", tweenHide);

        onShow = setInventorysThenTween;
    }

    private function tabInit(){
        tabs = ["seeds", "fruits", "product", "building"];
        for(i in 0...tabs.length){
            var y:Float = 0.25 + i / 7;
            seedsTab = addContainer(new Vector2(1, 1));
            var imageSize = IsoEngine.getInstance().assets.getSize(tabs[i] + "Dark");
            var ratio:Float = imageSize.x / imageSize.y;
            var seedsTabBg = seedsTab.addButton(new Vector2(0.2, y), new Vector2(0.1, .7, "%", "%x"), Vector2.zero, "tabDark", function(){});
            seedsTabBg.setAnchor(1, 0.5);
            var seedsTabIcon = seedsTab.addBloc(tabs[i] + "Dark", new Vector2(0.16, y), new Vector2(ratio, 0.07, "%y", "%"));
            seedsTabIcon.displayObject.interactive = false;
            seedsTabIcon.setAnchor(0.5, 0.5);
        }
    }
    private function clickTab(){

    }

    private function pick () {
        Selection.setNew("plant", "seed", selectedSeed);
        tweenHide();
    }

    private function displaySeeds () {
        buildingInventory.clear();
        trace(Seed.list.length);
        for (i in 0...Seed.list.length) {
            var cell:Cell = buildingInventory.addCell();
            var bloc = cell.addBloc("objectBackground", new Vector2 (0.1, 0.1), new Vector2 (0.8, .8));
            var name = Seed.list[i].appearanceName;
            var cont = cell.addContainer(new Vector2(1, 1));
            cell.addButton(new Vector2(0.8, 0), new Vector2(0.2, 1, "%", "%x"), Vector2.zero, "miniClose", tweenHide);
            cont.addButton(new Vector2 (0.1, 0.1), new Vector2 (0.8, .8), Vector2.zero, "objectBackground", function () {
                pick();
            });

            cont.addBloc("G" + name.charAt(2), new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8)).displayObject.interactive = false;
            cont.addBloc("F" + name.charAt(0), new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8)).displayObject.interactive = false;
            cont.addBloc("O" + name.charAt(1), new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8)).displayObject.interactive = false;
        }
    }

    public function setInventorysThenTween () {
        Selection.setNull();
        displaySeeds();
        tweenShow();
    }
}

