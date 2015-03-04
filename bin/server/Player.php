
<?php
    class Player {
        public $id;
        public $db;

        function __construct ($_id) {
            global $mysqli;

            $this->id = $_id;
            $this->db = $mysqli;
        }

        function tileFree ($position) {
            $x = $position->x;
            $y = $position->y;

            $response = $this->db->query("SELECT * FROM playersbuildings WHERE PlayerID = '$this->id' && X = '$x' && Y = '$y'");
            if (!$err = $this->noError()) return $err;
            $nbResult = $response->num_rows;

            return ($nbResult == 0);
        }

        function addBuilding ($position, $type) {
            $x = $position->x;
            $y = $position->y;

            $this->db->query("INSERT INTO playersbuildings VALUES (NULL, '$this->id', '$type', '$x', '$y', '', '', '', '', '', '')");

            return $this->noError();
        }

        function addFlower ($position, $genome) {
            $x = $position->x;
            $y = $position->y;

            $this->db->query("INSERT INTO playersflowers VALUES (NULL, '$this->id', '$x', '$y', '$genome', NOW(), 0, 0, 0, 0, 0, false, false, false)");

            return $this->noError();
        }

        function destroyBuilding ($position) {
            $x = $position->x;
            $y = $position->y;

            $response = $this->db->query("DELETE FROM playersbuildings WHERE PlayerID = '$this->id' && X = '$x' && Y = '$y'");
            if ($err = $this->noError() != true) {
                return $this->noError();
            }
            return ($response == 1);
        }


        function getBuidings () {
            $id = $this->id;
            $response = $this->db->query("SELECT Type, X, Y, Attribute1, Attribute2, Attribute3, Attribute1Lvl, Attribute2Lvl, Attribute3Lvl FROM playersbuildings WHERE PlayerID = '$this->id'");

            echo ($this->db->error);

            if ($err = $this->noError() && $response->num_rows) {
                $buildings = array();
                while ($data = $response->fetch_array()) {
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