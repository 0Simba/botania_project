
<?php
    $returnObject = array();

    $player->removeSeed($datas->id);
    $returnObject["accepted"] = true;
    $returnObject["error"]    = false;

    echo json_encode($returnObject);
?>