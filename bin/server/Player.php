
<?php
    include "PlayerGeneric.php";
    include "playerComponents/Seeds.php";

    class Player extends PlayerGeneric {

        public $seeds;

        function __construct () {
            parent::__construct();
            $this->seeds = new Seeds($this);
        }


        function getDatas(){
            $id = $this->id;
            $response = $this->db->query("SELECT * FROM players WHERE ID = '$id'");

            if ($err = $this->noError() && $response->num_rows) {
                $datas = array();
                while ($data = $response->fetch_array(MYSQLI_ASSOC)) {
                    array_push($datas, $data);
                }
                return $datas;
            }
            return $err;
        }




        /*========================================
        =            Seeds And Fruits            =
        ========================================*/

            /*==========  Fruits  ==========*/

        function getFruits () {
            $id = $this->id;
            $response = $this->db->query("SELECT ID, Genome, Quality FROM playersfruits WHERE PlayerID = '$this->id'");

            echo ($this->db->error);

            if ($err = $this->noError() && $response->num_rows) {
                $fruits = array();
                while ($data = $response->fetch_array(MYSQLI_ASSOC)) {
                    array_push($fruits, $data);
                }
                return $fruits;
            }
            return $err;

        }


        function addFruit ($genome, $quality) {
            $this->db->query("INSERT INTO playersfruits VALUES (NULL, '$this->id', '$genome', '$quality')");
            return $this->noError();
        }


        function removeFruit ($id) {
            $this->db->query("DELETE FROM playersfruits WHERE ID='$id'");
        }


        /*===============================
        =            Flowers            =
        ===============================*/

        function getFlowers () {
            $id = $this->id;
            $response = $this->db->query("SELECT ID, X, Y, Genome, LastTimeStamp, StateIndex, Attribute1, Attribute2, Attribute3, Attribute4, Bonus1, Bonus2, Bonus3 FROM playersflowers WHERE PlayerID = '$this->id'");

            echo ($this->db->error);

            if ($err = $this->noError() && $response->num_rows) {
                $flowers = array();
                while ($data = $response->fetch_array(MYSQLI_ASSOC)) {
                    array_push($flowers, $data);
                }
                return $flowers;
            }
            return $err;

        }


        function addFlower ($position, $genome) {
            $this->escapePosition($position);
            $ts = time() * 1000;

            $this->db->query("INSERT INTO playersflowers VALUES (NULL, '$this->id', '$position->x', '$position->y', '$genome', '$ts', 0, 0, 0, 0, 0, false, false, false)");

            return $this->noError();
        }


        function lastFlowerId () {
            return $this->db->insert_id;
        }


        function destroyFlower ($position) {
            $response = $this->db->query("DELETE FROM playersflowers " . $this->getWhereForPosition($position));
            if ($err = $this->noError() != true) {
                return $this->noError();
            }
            return ($response == 1);
        }


        function isFlower ($position) {
            $response = $this->db->query("SELECT ID FROM playersflowers " . $this->getWhereForPosition($position));

            if (($err = $this->noError()) != true) return $err;

            return ($response->num_rows == 1);
        }


        function growFlower ($position, $index) {
            if ($index >= 5) return "Impossible state index";
            $timeStamp = time() * 1000;

            $this->db->query("UPDATE playersflowers SET StateIndex = '$index', LastTimeStamp = '$timeStamp'" . $this->getWhereForPosition($position));

            return $this->noError();
        }




        /*=================================
        =            Buildings            =
        =================================*/

        function getBuildingPrice($name){
            $id = $this->id;
            $response = $this->db->query("SELECT price FROM typebuildings WHERE texture = '$name'");
            if ($err = $this->noError() && $response->num_rows) {
                //$data = $response->fetch_array(MYSQL_ASSOC)[0]["price"];
                $datas = $response->fetch_array(MYSQL_ASSOC);
                return $datas["price"];
            }
            return $err;
        }

        function addBuilding ($position, $type) {
            $this->escapePosition($position);

            $this->db->query("INSERT INTO playersbuildings VALUES (NULL, '$this->id', '$type', '$position->x', '$position->y', '', '', '', '', '', '')");

            return $this->noError();
        }

        function destroyBuilding ($position) {
            $response = $this->db->query("DELETE FROM playersbuildings " . $this->getWhereForPosition($position));
            if ($err = $this->noError() != true) {
                return $this->noError();
            }
            return ($response == 1);
        }


        function getBuidings () {
            $id = $this->id;
            $response = $this->db->query("SELECT Type, X, Y, Attribute1, Attribute2, Attribute3, Attribute1Lvl, Attribute2Lvl, Attribute3Lvl FROM playersbuildings WHERE PlayerID = '$id'");

            echo ($this->db->error);
            if ($err = $this->noError() && $response->num_rows) {
                $buildings = array();
                while ($data = $response->fetch_array(MYSQLI_ASSOC)) {
                    array_push($buildings, $data);
                }
                return $buildings;
            }
            return $err;
        }



        /*=============================
        =            Money            =
        =============================*/

        function hasEnoughCoins($price){
            return $price <= $this->getDatas()[0]["Gold"];
        }




        /*=============================
        =            UTILS            =
        =============================*/

        function escapePosition ($position) {
            $position->x = $this->db->real_escape_string($position->x);
            $position->y = $this->db->real_escape_string($position->y);
        }


        function getWhereForPosition ($position) {
            $this->escapePosition($position);
            return "WHERE PlayerID = '$this->id' && X = '$position->x' && Y = '$position->y'";
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
    }
?>
