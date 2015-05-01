<?php
    $returnObject = array();
    $returnObject['buildings'] = $shop->getBuildings();
    $returnObject['serverTimeStamp'] = time() * 1000;
    $returnObject['accepted']  = true;
    echo json_encode($returnObject);
?>