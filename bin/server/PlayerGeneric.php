<?php
     class PlayerGeneric {
        public $id;
        public $db;

        function __construct () {
            global $mysqli;

            $this->id = $_SESSION["playerID"];
            $this->db = $mysqli;
        }


        function noError () {
            if ($this->db->error != false) {
                return ("erreur mysql : " . $this->db->error);
            }

            return true;
        }


         function tileFree ($position) {
            $whereCondtion = $this->getWhereForPosition($position);


            $response = $this->db->query("SELECT * FROM playersbuildings " . $whereCondtion);
            if (!$err = $this->noError()) return $err;

            $nbResult = $response->num_rows;


            $response = $this->db->query("SELECT * FROM playersflowers " . $whereCondtion);
            if (!$err = $this->noError()) return $err;

            $nbResult += $response->num_rows;

            return ($nbResult == 0);
        }


        function getWhereForPosition ($position) {
            $this->escapePosition($position);
            return "WHERE PlayerID = '$this->id' && X = '$position->x' && Y = '$position->y'";
        }


        function escapePosition ($position) {
            $position->x = $this->db->real_escape_string($position->x);
            $position->y = $this->db->real_escape_string($position->y);
        }


    }

?>