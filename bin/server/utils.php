
<?php
    function tileFree ($position, $id) {
        global $mysqli;

        $x = $position->x;
        $y = $position->y;

        $response = $mysqli->query("SELECT * FROM playersBuildings WHERE PlayerID = '$id' && X = '$x' && Y = '$y'");
        if (!$err = noError()) return $err;
        $nbResult = $response->num_rows;

        return ($nbResult == 0);
    }

    function addBuilding ($position, $type, $id) {
        global $mysqli;

        $x = $position->x;
        $y = $position->y;

        $mysqli->query("INSERT INTO playersBuildings VALUES (NULL, '$id', '$type', '$x', '$y', '', '', '', '', '', '')");

        return noError();
    }

    function getBuidingsOf ($id) {
        global $mysqli;

        $response = $mysqli->query("SELECT Type, X, Y, Attribute1, Attribute2, Attribute3, Attribute1Lvl, Attribute2Lvl, Attribute3Lvl FROM playersBuildings WHERE PlayerID = '$id'");
        if ($err = noError()) {
            $buildings = array();
            while ($data = $response->fetch_array()) {
                array_push($buildings, $data);
            }
            return $buildings;
        }
        return $err;
    }


    function noError () {
        global $mysqli;

        if ($mysqli->error) {
            return ("erreur mysql : " . $mysqli->error);
        }

        return true;
    }
?>