package entities.genetic;

import GameObject;
import init.Config;


enum Taxonomy
{
    family;
    order;
    genre;
}

enum Type
{
    A;
    B;
    C;
    D;
    E;
    F;
    O;
}

class TypeUtils {
    static public function fromString (value:String):Type {
        return (value == "A") ? Type.A :
               (value == "B") ? Type.B :
               (value == "C") ? Type.C :
               (value == "D") ? Type.D :
               (value == "E") ? Type.E :
                                Type.O ;
    }
}

class Chromosome
{
	public var name:Taxonomy;
	public var value:Type;

	public function new (_name:Taxonomy, _value:Type) {
        name  = _name;
        value = _value;
	}

    public function stringValue ():String {
      return (value == Type.A) ? "A" :
             (value == Type.B) ? "B" :
             (value == Type.C) ? "C" :
             (value == Type.D) ? "D" :
             (value == Type.E) ? "E" :
                                 "null" ;
    }

    static public function getMapOfType ():Map<Type, Int> {
      var map = new Map<Type, Int>();
      map.set(Type.A, 0);
      map.set(Type.B, 1);
      map.set(Type.C, 2);
      map.set(Type.D, 3);
      map.set(Type.E, 4);

      return map;
    }


    static public function getMapOfLetter ():Map<String, Int> {
        var map = new Map<String, Int>();
        map.set("A", 0);
        map.set("B", 1);
        map.set("C", 2);
        map.set("D", 3);
        map.set("E", 4);

        return map;
    }
}

