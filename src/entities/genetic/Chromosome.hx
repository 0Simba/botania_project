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

    static public function getMapOfType ():Map<Type, Float> {
        var map = new Map<Type, Float>();
        map.set(Type.A, 0);
        map.set(Type.B, 0);
        map.set(Type.C, 0);
        map.set(Type.D, 0);
        map.set(Type.E, 0);

        return map;
    }
}

