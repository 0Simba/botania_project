
<?php

    function logMessage ($message) {
        $fp = fopen('phpLog.txt', 'a');
        fwrite($fp, date('y-m-d H:i:s') . " : " . $message . "\n");
    }
?>
