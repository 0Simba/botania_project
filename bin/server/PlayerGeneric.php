<?php
     class PlayerGeneric {
        public $id;
        public $db;

        function __construct () {
            global $mysqli;

            $this->id = mysqli_real_escape_string($_SESSION["playerID"]);
            $this->db = $mysqli;
        }

    }

?>