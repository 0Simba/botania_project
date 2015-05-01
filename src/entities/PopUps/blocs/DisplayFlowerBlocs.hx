package entities.popUps.blocs;

import engine.popUpEngine.Container;
import engine.isoEngine.components.Hud;
import utils.Vector2;

class DisplayFlowerBlocs
{

    private var displayFlowerBlocs:Array<Hud>;
    private var container:Container;


    public function new (_container:Container, position:Vector2, size:Vector2) {
        displayFlowerBlocs = new Array<Hud>();
        container = _container;

        displayFlowerBlocs[0] = container.addBloc("GA", position, size);
        displayFlowerBlocs[1] = container.addBloc("OA", position, size);
        displayFlowerBlocs[2] = container.addBloc("FA", position, size);
    }


    public function update (genomeCode:String) {
        displayFlowerBlocs[0].changeTexture("O" + genomeCode.charAt(1));
        displayFlowerBlocs[1].changeTexture("F" + genomeCode.charAt(0));
        displayFlowerBlocs[2].changeTexture("G" + genomeCode.charAt(2));
    }


    public function show () {
        for (i in 0...displayFlowerBlocs.length) {
            displayFlowerBlocs[i].show();
        }
    }


    public function hide () {
        for (i in 0...displayFlowerBlocs.length) {
            displayFlowerBlocs[i].hide();
        }
    }
}
