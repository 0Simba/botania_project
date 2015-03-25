package entities;

import GameObject;
import init.Config;
import entities.genetic.Genome;
import entities.Seed;

class Fruit extends GameObject
{
	static public var list:Array<Fruit> =  new Array<Fruit>();

	public var genome:Genome;
	public var quality:Float;

    public var appearanceName:String;

	public function new (_genome:Genome, _quality:Float = 0, informServer:Bool = false) {
        super();
		genome  = _genome;
		quality = _quality;
        appearanceName = genome.getAppearanceName();

        list.push(this);

        if (informServer) {
            var a:Dynamic = getFruitDatas();
            callServer("addFruit", getFruitDatas(), cast function(){}, cast function(){});
        }
	}


	public function open (knifeLevel:Int) {
        for (i in 0...knifeLevel) {
            new Seed(genome);
        }

		list.splice(list.indexOf(this), 1);
	}

	private function getFruitDatas ():Dynamic {
        var data:Dynamic = {};
        data.genome = genome.getCode();
        data.quality  = quality;

        return data;
    }
}