package engine.isoEngine.managers;

import engine.isoEngine.components.Tile;


class Maping
{

    public var tiles:Array<Array<Tile>>;

    public function new () {
        tiles = new Array<Array<Tile>>();
    }

    public function getTile (x:Int , y:Int):Tile {
        if (tiles[x] != null) {
            return tiles[x][y];
        }

        return null;
    }

    public function addTile (tile:Tile) {
        if (tiles[tile.coord.x] == null) {
            tiles[tile.coord.x] = new Array<Tile>();
        }
        tiles[tile.coord.x][tile.coord.y] = tile;
    }
}