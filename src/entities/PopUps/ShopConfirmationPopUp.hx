package entities.popUps;

import utils.Vector2;
import entities.popUps.PopUpMain;
import engine.popUpEngine.PopUpEngineMain;
import engine.isoEngine.components.Button;
import engine.popUpEngine.PopUp;
import manager.Selection;
import engine.popUpEngine.Bloc;
import engine.isoEngine.components.Hud;
import engine.popUpEngine.Container;
import pixi.text.Text.TextStyle;

class ShopConfirmationPopUp extends PopUpMain
{
	private var background:Hud;
	private var buildingImage:Hud;
	private var description:engine.isoEngine.components.Text;
	private var title:engine.isoEngine.components.Text;
	private var buy:engine.isoEngine.components.Text;
	public static var instance:entities.popUps.ShopConfirmationPopUp;
	private var style:TextStyle;
	private var selectedElem:Dynamic;
	public function new(){
        super("shopConfirmationInterface", new Vector2(0, 0), new Vector2(1, 1, "%", "%"));
		background = addBloc("shopValidateBG", new Vector2(0.5, 0.5), new Vector2(0.5, 0.5, "%", "%x"));
        background.setAnchor(0.5, .5);
        buildingImage = addBloc("breaker", new Vector2 (0.27, 0.5, "%", "%"), new Vector2 (.86, .4, "%y", "%"));
        buildingImage.setAnchor(0, .5);
        var titleStyle:TextStyle = {
            fill : "white",
            font : "bold 30px arial",
            align: "center",
            wordWrap : false
        };
        title = addText(new Vector2(0.55, 0.35), new Vector2(0, 0), "BREAKER", titleStyle);
        var style:TextStyle = {
            fill : "white",
            font : "18px arial",
            align: "center",
            wordWrap : false
        };
        description = addText(new Vector2(0.55, 0.4), new Vector2(0, 0), "Description du bâtiment sélectionné.", style);

        var underline = addBloc("shopValidaeteUnderline", new Vector2(0.55, 0.45), new Vector2(0.15, 0.06, "%", "%x"));
        underline.setAnchor(0.5, .5);
        buy = addText(new Vector2(0.55, 0.5), new Vector2(0, 0), "Vous êtes sur le point d'acheter un(e)  pour  pièces.", style);
        //text.²text.setAnchor(.5, .²5);
        buy.text.anchor.x = buy.text.anchor.y = title.text.anchor.x = title.text.anchor.y = description.text.anchor.x = description.text.anchor.y = 0.5;
        instance = this;

        addButton (new Vector2(0.58, 0.6), new Vector2(0.05, 0.1), new Vector2(0.5, 0.5), "ShopBtnClose", instance.hide);
        addButton (new Vector2(0.52, 0.6), new Vector2(0.05, 0.1), new Vector2(0.5, 0.5), "shopValidateBtnOk", wantToBuy);
	}

	static public function open(elem:Dynamic, name:String){
		instance.selectedElem = elem;
		instance.buildingImage.setTexture(elem.texture);
		instance.title.setText(elem.Name);
		instance.buy.setText("Souhaitez vous l'acheter pour " + elem.price + " pièces ?");
		instance.show();
	}

	static public function wantToBuy(){

	}
}