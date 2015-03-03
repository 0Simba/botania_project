<?php
session_start();

            /* THIS IS THE DEAULT CONFIG, DON'T CHANGE IT !!! */
            /* TO CHANGE CONFIG, USE "server/config.php" WHO'S IGNORED BY GIT */
$config = array(
    "host"     => "localhost",
    "user"     => "botaniaproject",
    "password" => "botania2015",
    "database" => "botaniaproject"
);

if (file_exists("server/config.php")) include "server/config.php";

$mysqli = new mysqli($config["host"],
                     $config["user"],
                     $config["password"],
                     $config["database"]);

?>