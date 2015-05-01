
<?php
    $returnObject = array();

    $player->seeds->remove($datas->id);
    $returnObject["accepted"] = true;
    $returnObject["error"]    = false;

    echo json_encode($returnObject);
?>