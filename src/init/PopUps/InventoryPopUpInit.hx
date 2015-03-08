package init.popUps;

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

class InventoryPopUpInit
{

    private static var seedsTab:Container;
    private static var trashButton:Button;
    private static var selectedSeed:Seed;
    private static var inventoryPopUp:PopUp;
    private static var buildingInventory:Inventory;
    private static var background:Hud;
    private static var tabs:Array<String>;


	public static function init () {
        tabs = ["seeds", "fruits", "product", "building"];
        var assets = IsoEngine.getInstance().assets;
        var popUpEngine = PopUpEngineMain.getInstance();

        inventoryPopUp = popUpEngine.createPopUp("inventoryInterface", new Vector2(0.5, 0.5), new Vector2(0.8, 0.8));
        inventoryPopUp.applyAnchor(0.5, 0.5);
        background = inventoryPopUp.addBloc("mainFR", new Vector2(0.2, 0.1), new Vector2(1.14, 1, "%y", "%"));
        var buildingContainer = inventoryPopUp.addContainer(new Vector2(1, 1));
        buildingInventory = buildingContainer.setInventory(new Vector2(0.23, 0.2), new Vector2(0.55, 0.63), new Vector2(0.25, 0.35, "%", "%x"), 4, -1);
        tabInit();
        /* TABS */

        inventoryPopUp.addButton(new Vector2(0.8, 0.1), new Vector2(0.05, 1, "%", "%x"), "close", closePopUp);
        /*inventory = inventoryPopUp.setInventory(new Vector2(0.1, 0.08), new Vector2(0.8, 0.6), new Vector2(0.25, 0.5, "%", "%x"), 4, -1);

        pickButton.hide();
        trashButton = inventoryPopUp.addButton(new Vector2(0.8, 0.8), new Vector2(0.1, 0.1), "inventoryBtn", function(){});
        trashButton.hide();


        inventoryPopUp.addText(new Vector2(0.5, 0.02), new Vector2(0.5, 0.5), "Inventaire", {font : "bold 20px verdana", fill : "white", align : "center"});*/
        //inventoryPopUp.addButtonPattern("close").onClick(closePopUp);
        inventoryPopUp.onShow = onShow;
    }

    private static function tabInit(){
        for(i in 0...tabs.length){
            var y:Float = 0.25 + i / 7;
            seedsTab = inventoryPopUp.addContainer(new Vector2(1, 1));
            var imageSize = IsoEngine.getInstance().assets.getSize(tabs[i] + "Dark");
            var ratio:Float = imageSize.y / imageSize.x;
            var seedsTabBg = seedsTab.addButton(new Vector2(0.2, y), new Vector2(0.1, .7, "%", "%x"), "tabDark", function(){});
            seedsTabBg.setAnchor(1, 0.5);
            var seedsTabIcon = seedsTab.addBloc(tabs[i] + "Dark", new Vector2(0.16, y), new Vector2(0.06, ratio, "%", "%x"));
            seedsTabIcon.displayObject.interactive = false;
            seedsTabIcon.setAnchor(0.5, 0.5);
        }
    }
    private static function clickTab(){

    }

    private static function pick () {
        Selection.setNew("plant", "seed", selectedSeed);
        closePopUp();
    }

    private static function displaySeeds () {
        buildingInventory.clear();
        trace(Seed.list.length);
        for (i in 0...Seed.list.length) {
            var cell:Cell = buildingInventory.addCell();
            var bloc = cell.addBloc("objectBackground", new Vector2 (0.1, 0.1), new Vector2 (0.8, .8));
            var name = Seed.list[i].appearanceName;
            var cont = cell.addContainer(new Vector2(1, 1));
            cell.addButton(new Vector2(0.8, 0), new Vector2(0.2, 1, "%", "%x"), "miniClose", closePopUp);
            cont.addButton(new Vector2 (0.1, 0.1), new Vector2 (0.8, .8), "objectBackground", function () {
                pick();
            });

            cont.addBloc("G" + name.charAt(2), new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8)).displayObject.interactive = false;
            cont.addBloc("F" + name.charAt(0), new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8)).displayObject.interactive = false;
            cont.addBloc("O" + name.charAt(1), new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8)).displayObject.interactive = false;
        }
    }

    public static function onShow () {
        Selection.setNull();
        displaySeeds();
    }

    private static function closePopUp () {
        inventoryPopUp.hide();
    }
}

