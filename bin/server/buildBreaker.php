
<?php
    $returnObject = array();

    if (tileFree($datas->position, $playerID)) {
        if ($returnObject["error"] = addBuilding($datas->position, 1, $playerID)){
            $returnObject["accepted"] = true;
            $returnObject["error"]    = false;
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
