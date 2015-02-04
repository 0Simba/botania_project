package init;

import entities.Seed;
import entities.genetic.Adn;
import entities.genetic.Taxonomy;
import entities.genetic.Genome;

class ForTest
{
    static public function load () {

        var genomeA = new Genome("A", 1);

        var family = new Taxonomy(genomeA);
        var order  = new Taxonomy(genomeA);
        var genre  = new Taxonomy(genomeA);

        var Adn  = new Adn(family, order, genre);
        var Seed = new Seed(Adn, 1);
    }
}
