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


            for (order in 0...allType.length) {
                var cOrder = allType[order];

                for (genre in 0...allType.length) {
                    var cGenre = allType[genre];

                    var genome = new Genome(
                        new Segment(1,
                            new Family(cFamily),
                            new Order(cOrder),
                            new Genre(cGenre)
                        )
                    );

                    new entities.Fruit(genome);
                }
            }
        }
    }
}
