package init;

import entities.Seed;
import entities.genetic.Segment;
import entities.genetic.Genome;
import entities.genetic.Chromosome;
import entities.genetic.chromosomes.Family;
import entities.genetic.chromosomes.Order;
import entities.genetic.chromosomes.Genre;
import entities.genetic.Chromosome.Type;

import utils.Vector2;

class ForTest
{
    static public function load () {

        new Seed(new Genome(
            new Segment(1,
                new Family(Type.A),
                new Order(Type.A),
                new Genre(Type.A)
            )
        ));
        new Seed(new Genome(
            new Segment(1,
                new Family(Type.A),
                new Order(Type.A),
                new Genre(Type.B)
            )
        ));
        new Seed(new Genome(
            new Segment(1,
                new Family(Type.A),
                new Order(Type.A),
                new Genre(Type.C)
            )
        ));
        new Seed(new Genome(
            new Segment(1,
                new Family(Type.A),
                new Order(Type.A),
                new Genre(Type.D)
            )
        ));
        new Seed(new Genome(
            new Segment(1,
                new Family(Type.A),
                new Order(Type.A),
                new Genre(Type.E)
            )
        ));

        // trace(Adn.getCode());
        // trace(Adn2.getCode());

        // var text = new engine.isoEngine.components.Text();
        // text.set("SISI LA FAMIIIILLLE ont peux LE-CA du >TEXTE<", new Vector2(0.1, 0.95), new Vector2(0.3, 0.2), null, "overlay");
    }
}
