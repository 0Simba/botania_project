<?php
     class PlayerGeneric {
        public $id;
        public $db;

        function __construct () {
            global $mysqli;

            $this->id = $_SESSION["playerID"];
            $this->db = $mysqli;
        }

    }

?>