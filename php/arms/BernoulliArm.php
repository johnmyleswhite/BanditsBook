<?php

require_once '/helpers/random.php';

class BernoulliArm {
    
    private $p;
    
    public function __construct($p) {
        $this->p = $p;
    }

    public function __destruct() {}

    public function draw() {
        return random() > $this->p ? 0.0 : 1.0;
    }
}

?>
