
<?php
    if (tileFree($datas->position, $playerID)) {
        echo addBuilding($datas->position, 1, $playerID) ? "accepted" : "refused";
    }
    else {
        echo "refused";
    }
?>
