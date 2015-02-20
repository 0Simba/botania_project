
<?php
    function tileFree ($position, $id) {
        global $mysqli;

        $request = $mysqli->query("SELECT COUNT(*) FROM playersBuilding WHERE ID = '$id' AND x = '$position.x' AND y = '$position.y'") or die ("err !");
        $data    = $request->fetch_row();

        return ($data[0] == 0);
    }
?>