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

        var allType = new Array<Type>();allType.push(Type.A);allType.push(Type.B);allType.push(Type.C);allType.push(Type.D);allType.push(Type.E);

        for (family in 0...allType.length) {
            var cFamily = allType[family];

        /* temp ! */
            // new Seed(new Genome(
            //     new Segment(1,
            //         new Family(cFamily),
            //         new Order(Type.A),
            //         new Genre(Type.A)
            //     )
            // ));
        /* end temp */

            for (order in 0...allType.length) {
                var cOrder = allType[order];

                for (genre in 0...allType.length) {
                    var cGenre = allType[genre];

                    new Seed(new Genome(
                        new Segment(1,
                            new Family(cFamily),
                            new Order(cOrder),
                            new Genre(cGenre)
                        )
                    ));
                }
            }
        }


        // trace(Adn.getCode());
        // trace(Adn2.getCode());

        // var text = new engine.isoEngine.components.Text();
        // text.set("SISI LA FAMIIIILLLE ont peux LE-CA du >TEXTE<", new Vector2(0.1, 0.95), new Vector2(0.3, 0.2), null, "overlay");
    }
}
