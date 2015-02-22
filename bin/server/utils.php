
<?php
    function tileFree ($position, $id) {
        global $mysqli;

        $x = $position->x;
        $y = $position->y;

        $response = $mysqli->query("SELECT * FROM playersBuildings WHERE PlayerID = '$id' && X = '$x' && Y = '$y'");
        if ($mysqli->error) {
            echo("erreur mysql : " . $mysqli->error);
            return false;
        }
        $nbResult = $response->num_rows;

        return ($nbResult == 0);
    }

    function addBuilding ($position, $type, $id) {
        global $mysqli;

        $x = $position->x;
        $y = $position->y;

        $mysqli->query("INSERT INTO playersBuildings VALUES (NULL, '$id', '$type', '$x', '$y', '', '', '', '', '', '')");

        if ($mysqli->error) {
            echo("erreur mysql : " . $mysqli->error);
            return false;
        }
        return true;
    }
?>