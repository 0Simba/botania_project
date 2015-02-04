package entities.genetic;

import GameObject;
import init.Config;

class Taxonomy
{
	public var principal:Genome;
	public var secondary:Genome;
	public var tertiary:Genome;

	public function new (_principal, _secondary = null, _tertiary = null) {
        principal = _principal;
        secondary = _secondary;
        tertiary  = _tertiary;
	}
}

