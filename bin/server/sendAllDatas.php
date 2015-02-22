<?php
    $returnObject = array();
    $returnObject['buildings'] = $player->getBuidings();
    $returnObject['accepted']  = true;
    echo json_encode($returnObject);
?>