package entities.popUps;


import engine.popUpEngine.PopUpEngineMain;
import utils.Vector2;



class LabotoryPopUp extends BreakerPopUp
{
    public function new () {
        super("labotory");
        applyAnchor(0.5, 0.5);

        seedInventorySize = new Vector2 (0.38, 0.54);
        popUpEngine       = PopUpEngineMain.getInstance();

        setDefaultsElements();
        createTween();
        // setSeedsInventory();
        initGenetic();
    }
}
