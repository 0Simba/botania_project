package entities.popUps;

import engine.isoEngine.components.DragNDrop;
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
import entities.MergeAnimation;
import engine.isoEngine.components.Hud;
import engine.popUpEngine.Container;
import entities.genetic.Segment;
import engine.isoEngine.components.Hud;
import engine.isoEngine.components.Button;


class BreakerPopUp extends PopUpMain
{

    private var seed1:Hud;
    private var seed2:Hud;
    private var productButton:Dynamic; // ?? impossible to get correct type
    private var popUpName:String;
    private var productName:String;

    static private var popUpSize = new Vector2(0.8, 0.8);


    /*=============================================
    =            Seed inventory params            =
    =============================================*/
    private var seedInventoryPos       = new Vector2 (0.07, 0.15);
    private var seedInventorySize      = new Vector2 (0.38, 0.74);
    private var seedInventoryCells     = new Vector2 (0.33, 0.33);
    private var seedInventoryXElements = 3;
    private var seedInventoryYElements = -1;


	public function new (_popUpName = "breakerInterface") {
        popUpName = _popUpName;
        super(popUpName, new Vector2(0.5, 0.5), popUpSize);
        applyAnchor(0.5, 0.5);

        popUpEngine = PopUpEngineMain.getInstance();

        setDefaultsElements();
        createTween();
        setSeedsInventory();
        initGenetic();
	}


    private function setDefaultsElements () {
        var assets = IsoEngine.getInstance().assets;
        addBloc("fond_en", new Vector2(0, 0), new Vector2(1, 1));
        var b = addButtonPattern("close");
        b.onClick(tweenHide);

        addBloc("plus_ltl", new Vector2(0.66, 0.74), assets.getSize("plus_ltl"));

        seed1 = addBloc("fond_fleur_graine", new Vector2(0.58, 0.72), assets.getSize("fond_fleur_graine"));
        seed2 = addBloc("fond_fleur_graine", new Vector2(0.705, 0.72), assets.getSize("fond_fleur_graine"));
        seed1.setDroppable();
        seed2.setDroppable();

        productButton = addButton(new Vector2(0.83, 0.72), assets.getSize("fond_fleur_graine"), new Vector2(0, 0), "bouton_produit", addProduct);


        addButton(new Vector2(0.66, 0.835), assets.getSize("concasser_button_en_ltl"), new Vector2(0, 0), "concasser_button_en_ltl", mergeSeeds);
        onShow = updateAndShow;
    }


    private function updateAndShow () {
        tweenShow();
        updateSeedsInventory();
    }


    private function setSeedsInventory () {
        setInventory(seedInventoryPos, seedInventorySize, seedInventoryCells, seedInventoryXElements, seedInventoryYElements);
        updateSeedsInventory();
    }


    private function updateSeedsInventory () {
        inventory.clear();
        for (i in 0...Seed.list.length) {
            var cell:Cell = inventory.addCell();
            var name = Seed.list[i].appearanceName;

            cell.addBloc("objectBackground", new Vector2 (0.02, 0.02), new Vector2 (0.96, 0.96));
            var cont = cell.addContainer(new Vector2(1, 1));

            var bloc  = cont.addBloc("colo"  + name.charAt(0) + name.charAt(2), new Vector2 (0, 0, "%", "%"), new Vector2 (1, 1, "%", "%"));
            var motif = cont.addBloc("motif" + name.charAt(0) + name.charAt(1), new Vector2 (0, 0, "%", "%"), new Vector2 (1, 1, "%", "%"));
            // motif.bindEvent();
            cont.onMouseoverH(cast function () {
                if (!DragNDrop.isItDragging()) {
                    updateGenetic(Seed.list[i]);
                }
            });
            cont.setDraggable(Seed.list[i]);
        }
    }





    /*========================================
    =            Actions callback            =
    ========================================*/

    private function mergeSeeds () {
        if (seed1.dropMeta != null && seed2.dropMeta != null) {
            var newSeed     = seed1.dropMeta.merge(seed2.dropMeta, productName);
            var appearance1 = seed1.dropMeta.appearanceName;
            var appearance2 = seed2.dropMeta.appearanceName;

            MergeAnimation.anim(appearance1, appearance2, newSeed.appearanceName);

            seed1.clearDrop();
            seed2.clearDrop();

            updateSeedsInventory();
        }
    }


    private function addProduct () {
        tweenHide();
        entities.popUps.DisplayProducts.setAndShow(onDisplayProductsClosed);
    }


    private function onDisplayProductsClosed (_productName:String) {
        productName = _productName;
        popUpEngine.show(popUpName);

        var textureName = (productName == null) ? "bouton_produit" : productName;
        productButton.changeTexture(textureName);
    }





    /*========================================
    =            Display genetics            =
    ========================================*/

    static private var nbElementsInFlower = 3;
    static private var nbMaxGenome        = 3;

    static private var xPositions:Array<Float> = [0.56, 0.69, 0.82];
    static private var yPositions:Array<Float> = [0.15, 0.15, 0.15];
    static private var size      :Vector2      = new Vector2(0.12, 1, "%", "%x");
    static private var backgroundColors:Array<String> = ["yellow", "gray", "purple"];

    static private var barSize     = new Vector2(0.36, 0.05, "%", "%");
    static private var barPosition = new Vector2(0.57, 0.49, "%", "%");

    private var barContainer:Container;
    private var barBlocs:Array<Hud>;

    private var displayGeneticContainers:Array<Container>;
    private var displayGeneticBlocs:Array<Array<Hud>>;



    private function initGenetic () {
        displayGeneticContainers = new Array<Container>();
        displayGeneticBlocs      = new Array<Array<Hud>>();
        barBlocs                 = new Array<Hud>();
        barContainer             = addContainer(Vector2.full);

        for (i in 0...nbMaxGenome) {
            barBlocs[i] = barContainer.addBloc(backgroundColors[i], barPosition, barSize);
            var y:Float          = yPositions[i % nbMaxGenome];
            var x:Float          = xPositions[i % nbMaxGenome];
            var position:Vector2 = new Vector2(x, y, "%", "%");

            displayGeneticContainers[i] = addContainer(Vector2.full);
            var newBloc = displayGeneticContainers[i].addBloc(backgroundColors[i], position, size);
            newBloc.sprite.alpha = 0.3;

            displayGeneticBlocs.push(new Array<Hud>());
            for (j in 0...nbElementsInFlower) {
                displayGeneticBlocs[i][j] = displayGeneticContainers[i].addBloc("GA", position, size);
            }
        }
    }


    private function updateGenetic (seed:Seed) {
        updateBar(seed);
        var names:Array<String> = new Array<String>();

        names.push(seed.genome.principal.getAsName());
        if (seed.genome.secondary != null) names.push(seed.genome.secondary.getAsName());
        if (seed.genome.tertiaire != null) names.push(seed.genome.tertiaire.getAsName());

        for (i in 0...3) {
            if (names[i] != null) {
                displayGeneticContainers[i].displayObject.visible = true;
                displayGeneticBlocs[i][0].changeTexture("O" + names[i].charAt(1));
                displayGeneticBlocs[i][1].changeTexture("F" + names[i].charAt(0));
                displayGeneticBlocs[i][2].changeTexture("G" + names[i].charAt(2));

            }
            else {
                displayGeneticContainers[i].displayObject.visible = false;
            }
        }
    }


    private function updateBar (seed:Seed) {
        var segments:Array<Segment> = [seed.genome.principal, seed.genome.secondary, seed.genome.tertiaire];
        var sizeDo:Float            = 0;
        var parentSize:Vector2      = new Vector2(isoEngine.width * popUpSize.x, isoEngine.height * popUpSize.y);

        for (i in 0...nbMaxGenome) {
            var strength = (segments[i] != null) ? segments[i].strength : 0;
            var bloc     = barBlocs[i];
            var xSize    = barSize.x * strength;

            bloc.resize(new Vector2(xSize, barSize.y, "%", "%"), parentSize);
            bloc.replace(new Vector2(barPosition.x + sizeDo, barPosition.y), parentSize);

            sizeDo += xSize;
        }
    }
}

