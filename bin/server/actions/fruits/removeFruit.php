<?php
    $returnObject = array();

    $player->fruits->remove($datas->id);
    $returnObject["accepted"] = true;
    $returnObject["error"]    = false;

    echo json_encode($returnObject);
?>