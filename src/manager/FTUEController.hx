package manager;

import engine.events.Events; 
import engine.isoEngine.IsoEngine;
import engine.isoEngine.components.Button;
import engine.popUpEngine.PopUpEngineMain;


class FTUEController
{

    static private var instance:FTUEController;
    private var isoEvents:Events;
    private var gameState:Int = 0;
    private var popUpEvents:Events;
    private var product:Bool = false;
    
    
    private function new () {
        instance    = this;
        var a = IsoEngine.getInstance();
        isoEvents   = a.events;
        var b = PopUpEngineMain.getInstance();
        popUpEvents = b.events;

        popUpEvents.on("close", function (popUpName:String) {
            if (gameState == 0 && popUpName == "ftuePopUp") {
                entities.popUps.FtuePopUp.setTitleAndShow("Je vous propose de planter votre premiere fleure. Pour ce faire, ouvrez votre inventaire (Icone Coffre)");
                gameState ++;
            }
            if (gameState == 2 && popUpName == "inventoryInterface") {
                entities.popUps.FtuePopUp.setTitleAndShow("Bien maintenant, plantez la graine sur votre terrain.");
                gameState ++;
            }

        });
        popUpEvents.on("inventory", function (popUpName:String) {
            if (gameState == 1) {
                entities.popUps.FtuePopUp.setTitleAndShow("Bien selectionnez la graine que vous voulez plantez.");
                gameState ++;
            }

        });
        popUpEvents.on("open", function (popUpName:String) {
            if (gameState == 4 && popUpName == "breaker") {
                entities.popUps.FtuePopUp.setTitleAndShow("Tres bien, vous pouvez ici selectionnez deux graines afin de les mélanger et de trouver une graine unique pour une nouvelle plante.");
                gameState ++;
            }
            if (popUpName == "product" && !product) {
                entities.popUps.FtuePopUp.setTitleAndShow("Ici vous pouvez choisir un produit pour amméliorer un composant d'une graine, les composant sont représenter par la forme, la couleur ou le motif de la graine, les produits ont les memes codes.");
                product = true;
            }

        });
        isoEvents.on("plant", function (popUpName:String) {
            if (gameState == 3) {
                entities.popUps.FtuePopUp.setTitleAndShow("Votre fleure est plantée !
                    En attendant qu'elle pousse, nous allons concasser des graine pour en creer une nouvelle.
                    Ouvrez votre Concasseur en cliquant dessus, puis cliquez sur le bouton d'action.");
                gameState ++;
            }

        });
    }
    
    
    static public function getInstance () {
        if (instance != null) {
            return instance;
        }
        else {
            return new FTUEController(); 
        }
    }

     
    


    
}