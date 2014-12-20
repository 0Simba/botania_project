package components;


class Components
{

	private static var instance: components;

    private static var GraphicTiles:engine.isoEngine.IsoEngine.Tile;








	private function new()
	{

	}

	public static function getInstance (): components {
		if (instance == null) instance = new components();
		return instance;
	}

	public function destroy (): Void {
		instance = null;
	}

}