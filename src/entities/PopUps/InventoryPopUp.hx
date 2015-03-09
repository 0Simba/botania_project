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
    private var activeInventory:Inventory;
    private var background:Hud;
    private var tabsNames:Array<String>;
    private var tabs:Array<Container>;
    private var activeTabIndex:Int;
    private var tabIcons:Array<Dynamic>      = [];
    private var tabButtons:Array<Dynamic>    = [];
    private var inventories:Array<Inventory> = [];


	public function new () {
        super("inventoryInterface", new Vector2(0.5, 0.5), new Vector2(0.8, 0.8));
        applyAnchor(0.5, 0.5);

        var assets = IsoEngine.getInstance().assets;
        var popUpEngine = PopUpEngineMain.getInstance();

        background = addBloc("mainFR", new Vector2(0.2, 0.1), new Vector2(1.14, 1, "%y", "%"));

        tabInit();

        /* MAIN CLOSE BUTTON */
        addButton(new Vector2(0.8, 0.1), new Vector2(0.05, 1, "%", "%x"), Vector2.zero, "close", tweenHide);

        onShow = setInventorysThenTween;
    }

    private function tabInit(){
        tabsNames = ["seeds", "fruits", "product", "building"];
        activeTabIndex = 0;
        tabs = [];
        for(i in 0...tabsNames.length){
            drawTab(i);
            createTabInterface(i);
        }
        selectTab(activeTabIndex);
    }

    private function drawTab(i:Int){
        var activeTabName = tabsNames[activeTabIndex];
        var y:Float = 0.25 + i / 7;
        var tab = addContainer(new Vector2(1, 1));
        var extendName = (tabsNames[i] == activeTabName) ? "Light" : "Dark";
        var imageSize = IsoEngine.getInstance().assets.getSize(tabsNames[i] + extendName);
        var ratio:Float = imageSize.x / imageSize.y;
        var seedsTabBg = tab.addButton(new Vector2(0.2, y), new Vector2(0.1, .7, "%", "%x"), Vector2.zero, "tab" + extendName, function(){
            unselectActiveTab();
            selectTab(i);
        });
        var seedsTabIcon = tab.addBloc(tabsNames[i] + extendName, new Vector2(0.16, y), new Vector2(ratio, 0.07, "%y", "%"));
        seedsTabIcon.displayObject.interactive = false;
        seedsTabIcon.setAnchor(0.5, 0.5);
        seedsTabBg.setAnchor(1, 0.5);

        tabIcons.push(seedsTabIcon);
        tabButtons.push(seedsTabBg);
    }

    private function createTabInterface(i:Int){
        switch(tabsNames[i]){
            case "seeds" :   createSeedsInventory();
            default: createBlankInventory();
        }
    }

    private function selectTab(index:Int){
        activeTabIndex = index;
        tabIcons[activeTabIndex].changeTexture(tabsNames[activeTabIndex] + "Light");
        tabButtons[activeTabIndex].changeTexture("tabLight");
        inventories[index].show();
    }

    private function unselectActiveTab(){
        tabIcons[activeTabIndex].changeTexture(tabsNames[activeTabIndex] + "Dark");
        tabButtons[activeTabIndex].changeTexture("tabDark");
        inventories[activeTabIndex].hide();
    }

    private function pick (seed) {
        Selection.setNew("plant", "seed", seed);
        tweenHide();
    }

    private function createSeedsInventory () {
        var seedsContainer = addContainer(new Vector2(1, 1));
        var seedsInventory = seedsContainer.setInventory(new Vector2(0.23, 0.2), new Vector2(0.55, 0.63), new Vector2(0.25, 0.35, "%", "%x"), 4, -1);
        seedsInventory.clear();
        for (i in 0...Seed.list.length) {
            var cell:Cell = seedsInventory.addCell();
            var bloc = cell.addBloc("objectBackground", new Vector2 (0.1, 0.1), new Vector2 (0.8, .8));
            var name = Seed.list[i].appearanceName;
            var cont = cell.addContainer(new Vector2(1, 1));
            cell.addButton(new Vector2(0.8, 0), new Vector2(0.2, 1, "%", "%x"), Vector2.zero, "miniClose", tweenHide);
            cont.addButton(new Vector2 (0.1, 0.1), new Vector2 (0.8, .8), Vector2.zero, "objectBackground", function () {
                pick(Seed.list[i]);
            });

            cont.addBloc("G" + name.charAt(2), new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8)).displayObject.interactive = false;
            cont.addBloc("F" + name.charAt(0), new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8)).displayObject.interactive = false;
            cont.addBloc("O" + name.charAt(1), new Vector2 (0.1, 0.1), new Vector2 (0.8, 0.8)).displayObject.interactive = false;
        }
        seedsInventory.hide();
        inventories.push(seedsInventory);

    }

    private function createBlankInventory(){
        var blankContainer = addContainer(new Vector2(1, 1));
        var blankInventory = blankContainer.setInventory(new Vector2(0.23, 0.2), new Vector2(0.55, 0.63), new Vector2(0.25, 0.35, "%", "%x"), 4, -1);
        inventories.push(blankInventory);
        blankInventory.hide();
    }

    public function setInventorysThenTween () {
        Selection.setNull();
        tweenShow();
    }
}

