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

        var Adn2 = new Adn(
            new Taxonomy(
                new Genome("A", 0.6),
                new Genome("Z", 0.3),
                new Genome("E", 0.1)
            ),
            new Taxonomy(
                new Genome("R", 0.6),
                new Genome("T", 0.3),
                new Genome("Y", 0.1)
            ),
            new Taxonomy(
                new Genome("Q", 0.6),
                new Genome("S", 0.3),
                new Genome("D", 0.1)
            )
        );

        // trace(Adn.getCode());
        // trace(Adn2.getCode());

        // var text = new engine.isoEngine.components.Text();
        // text.set("SISI LA FAMIIIILLLE ont peux LE-CA du >TEXTE<", new Vector2(0.1, 0.95), new Vector2(0.3, 0.2), null, "overlay");
    }
}
