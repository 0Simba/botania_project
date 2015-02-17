package entities.genetic.chromosomes;

import GameObject;
import init.Config;
import entities.genetic.Chromosome;

class Family extends Chromosome
{

    public function new (value:Chromosome.Type) {
        super(Chromosome.Taxonomy.family, value);
    }
}

