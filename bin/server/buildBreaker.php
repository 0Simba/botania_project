
<?php
    $returnObject = array();

    if (tileFree($datas->position, $playerID)) {
        if (addBuilding($datas->position, 1, $playerID)){
            $returnObject["accepted"] = true;
        }
        else {
            $returnObject["accepted"] = false;
        }
    }
    else {
        $returnObject["accepted"] = false;
    }

    echo json_encode($returnObject);
?>
