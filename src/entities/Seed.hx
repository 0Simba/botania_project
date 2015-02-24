package entities;

//import engine.events.Events;
import GameObject;

import init.Config;
import entities.genetic.Genome;
import entities.genetic.Chromosome.Type;
import utils.MapManipulate;

class Seed extends GameObject
{
    static public var list:Array<Seed> = new Array<Seed>(); // TODO this simulate player's seeds data. Move it when player's data was create


	public var genome:Genome;
	public var level:Int;
    public var appearanceName:String;

	public function new (_genome:Genome, _level:Int = 0) {
        super();
        genome = _genome;
        level  = _level;

        appearanceName = genome.getAppearanceName();
        list.push(this);
	}

    public function merge (seed:Seed) {
        var list = createCodeListOfGenomes(this.genome, seed.genome);

        keepThreeBetterOf(list);
        normalizeTotalOf(list);

        new Seed(Genome.newFromCodeList(list));

        seed.destroy();
        destroy();
    }

    override public function destroy () {
        var index = list.indexOf(this);
        var seed  = list[index];
        list.splice(index, 1);
    }


    private function normalizeTotalOf (list) {
        var total = getTotal(list);
        return list;
    }

    private function getTotal (list:Map<String, Float>) {
        var total:Float = 0;
        for (value in list) {
            total += value;
        }
        return total;
    }

    private function keepThreeBetterOf (list) {
    }

    private function createCodeListOfGenomes (genome1:Genome, genome2:Genome):Map<String, Float> {
        var list = genome1.listSegmentCode();
        genome2.listSegmentCode(list);

        return list;
    }
}