
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

        $response = $mysql->query("SELECT * FROM playersBuildings WHERE PlayerID = '$id'");
        if ($err = noError()) {
            return $response->fetch_assoc();
        }
        return false;
    }


    function noError () {
        global $mysqli;

        if ($mysqli->error) {
            return ("erreur mysql : " . $mysqli->error);
        }

        return true;
    }
?>