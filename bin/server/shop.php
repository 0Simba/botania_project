
<?php
    class Shop {
        public $id;
        public $db;

        function __construct () {
            global $mysqli;

            $this->db = $mysqli;
        }

        function getBuildings () {
            $response = $this->db->query("SELECT * FROM typeBuildings");

            if ($err = $this->noError() && $response->num_rows) {
                $buildings = array();
                while ($data = $response->fetch_array(MYSQLI_ASSOC)) {
                    array_push($buildings, $data);
                }
                return $buildings;
            }
            return $err;
        }

        function noError () {
            if ($this->db->error != false) {
                return ("erreur mysql : " . $this->db->error);
            }
            return true;
        }
    }
?>