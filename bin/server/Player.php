
<?php
    include "PlayerGeneric.php";
    include "playerComponents/Seeds.php";
    include "playerComponents/Fruits.php";
    include "playerComponents/Buildings.php";
    include "playerComponents/Flowers.php";
    include "playerComponents/Money.php";


    class Player extends PlayerGeneric {

        public $seeds;
        public $fruits;
        public $buildings;
        public $flowers;
        public $money;


        function __construct () {
            parent::__construct();

            $this->seeds     = new Seeds($this);
            $this->fruits    = new Fruits($this);
            $this->buildings = new Buildings($this);
            $this->flowers   = new Flowers($this);
            $this->money     = new Money($this);
        }
    }
?>
