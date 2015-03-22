package manager.circlesHud;

import engine.popUpEngine.PopUpEngineMain;

class EcosystemBuilding extends CirclesHudManager
{
    private var popUpEngine:PopUpEngineMain;
    private var prodLvl:Int = 1;
    private var rangeLvl:Int = 1;
    private var bonusLvl:Int = 1;
    public function new (name:String) {
        super(name);
        managedHud.addOnce("remove", "trashBasic", removeBuilding);
        managedHud.addOnce("rangePlus" , "ecoRangePlus" + rangeLvl, upgradeRange);
        managedHud.addOnce("bonusPlus" , "ecoBonusPlus" + bonusLvl, upgradeBonus);
    }
    
    public function upgradeRange(target:entities.Building){
        entities.popUps.HeaderPopUp.getInstance().setCurrencies({gold:1254, suns:"sfs"});
        if(rangeLvl == 3)return;
        rangeLvl++;
        managedHud.elements.get("rangePlus").hudButton.changeTexture("ecoRangePlus" + rangeLvl);
    }

    public function upgradeBonus(target:entities.Building){
        if(bonusLvl == 3)return;
        bonusLvl++;
        managedHud.elements.get("bonusPlus").hudButton.changeTexture("ecoBonusPlus" + bonusLvl);
    }
}
