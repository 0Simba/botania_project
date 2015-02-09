package init;

import entities.Seed;
import entities.genetic.Adn;
import entities.genetic.Taxonomy;
import entities.genetic.Genome;

import utils.Vector2;

class ForTest
{
    static public function load () {

        var genomeA = new Genome("A", 1);

        var family = new Taxonomy(genomeA);
        var order  = new Taxonomy(genomeA);
        var genre  = new Taxonomy(genomeA);

        var Adn  = new Adn(family, order, genre);
        var Seed = new Seed(Adn, 1);



        var text = new engine.isoEngine.components.Text();
        text.set("SISI LA FAMIIIILLLE ont peux LE-CA tu >TEXTE<", new Vector2(0.1, 0.95), new Vector2(0.3, 0.2), null, "overlay");
    }
}
