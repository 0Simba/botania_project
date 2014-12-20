package init;

class Map
{

	private function new ()
	{

	}

    static public function load () {
        var map:manager.Map = manager.Map.getInstance();
        map.set(10, 10);

        map.fill("ground");
    }

}