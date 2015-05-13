package entities.popUps;


import engine.popUpEngine.PopUpEngineMain;
import utils.Vector2;



class LabotoryPopUp extends BreakerPopUp
{

    override public function new () {
        super("labotory");
        applyAnchor(0.5, 0.5);

        popUpEngine = PopUpEngineMain.getInstance();

        setDefaultsElements();
        createTween();
        initGenetic();
    }


}
