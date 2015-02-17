package entities.genetic.chromosomes;

import GameObject;
import init.Config;

class Order extends entities.genetic.Chromosome
{

    public function new (value:Chromosome.Type) {
        super(Chromosome.Taxonomy.order, value);
    }
}

