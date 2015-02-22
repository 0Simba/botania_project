<?php
    $returnObject = array();
    $returnObject['buildings'] = getBuidingsOf($playerID);
    $returnObject['accepted']  = true;
    echo json_encode($returnObject);
?>