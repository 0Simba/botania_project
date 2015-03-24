
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


            $response = $this->db->query("SELECT * FROM playersflowers WHERE PlayerID = '$this->id' && X = '$x' && Y = '$y'");
            if (!$err = $this->noError()) return $err;

            $nbResult += $response->num_rows;

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
            $ts = time() * 1000;

            $this->db->query("INSERT INTO playersflowers VALUES (NULL, '$this->id', '$x', '$y', '$genome', '$ts', 0, 0, 0, 0, 0, false, false, false)");

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

        function destroyFlower ($position) {
            $x = $position->x;
            $y = $position->y;

            $response = $this->db->query("DELETE FROM playersflowers WHERE PlayerID = '$this->id' && X = '$x' && Y = '$y'");
            if ($err = $this->noError() != true) {
                return $this->noError();
            }
            return ($response == 1);
        }

        function isFlower ($position) {
            $x = $position->x;
            $y = $position->y;

            $response = $this->db->query("SELECT ID FROM playersflowers WHERE PlayerID = '$this->id' && X = '$x' && Y = '$y'");

            if (($err = $this->noError()) != true) return $err;

            return ($response->num_rows == 1);
        }

        function growFlower ($position, $index) {
            $x = $position->x;
            $y = $position->y;
            $timeStamp = time() * 1000;

            $this->db->query("UPDATE playersflowers SET StateIndex = '$index', LastTimeStamp = '$timeStamp' WHERE PlayerID = '$this->id' && X = '$x' && Y = '$y'");

            return $this->noError();
        }


        function getBuidings () {
            $id = $this->id;
            $response = $this->db->query("SELECT Type, X, Y, Attribute1, Attribute2, Attribute3, Attribute1Lvl, Attribute2Lvl, Attribute3Lvl FROM playersbuildings WHERE PlayerID = '$this->id'");

            echo ($this->db->error);

            if ($err = $this->noError() && $response->num_rows) {
                $buildings = array();
                while ($data = $response->fetch_array(MYSQL_ASSOC)) {
                    array_push($buildings, $data);
                }
                return $buildings;
            }
            return $err;
        }

        function getFlowers () {
            $id = $this->id;
            $response = $this->db->query("SELECT X, Y, Genome, LastTimeStamp, StateIndex, Attribute1, Attribute2, Attribute3, Attribute4, Bonus1, Bonus2, Bonus3 FROM playersflowers WHERE PlayerID = '$this->id'");

            echo ($this->db->error);

            if ($err = $this->noError() && $response->num_rows) {
                $flowers = array();
                while ($data = $response->fetch_array(MYSQL_ASSOC)) {
                    array_push($flowers, $data);
                }
                return $flowers;
            }
            return $err;

        }

        function getSeeds () {
            $id = $this->id;
            $response = $this->db->query("SELECT Genome, Level FROM playersseeds WHERE PlayerID = '$this->id'");

            echo ($this->db->error);

            if ($err = $this->noError() && $response->num_rows) {
                $seeds = array();
                while ($data = $response->fetch_array(MYSQL_ASSOC)) {
                    array_push($seeds, $data);
                }
                return $seeds;
            }
            return $err;

        }

        function getDatas(){
            $id = $this->id;
            $response = $this->db->query("SELECT * FROM players WHERE ID = '$this->id'");

            echo ($this->db->error);

            if ($err = $this->noError() && $response->num_rows) {
                $datas = array();
                while ($data = $response->fetch_array(MYSQL_ASSOC)) {
                    array_push($datas, $data);
                }
                return $datas;
            }
            return $err;
        }


        function addSeed ($genome, $level) {
            $this->db->query("INSERT INTO playersseeds VALUES (NULL, '$this->id', '$genome', '$level')");
            return $this->noError();
        }


        function noError () {
            if ($this->db->error != false) {
                return ("erreur mysql : " . $this->db->error);
            }

            return true;
        }

    }


?>