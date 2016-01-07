<?php

class AdversarialArm {
    
    private $t;
    private $active_start;
    private $active_end;
    
    public function __construct($t, $active_start, $active_end) {
        $this->t = $t;
        $this->active_start = $active_start;
        $this->active_end = $active_endn;
    }

    public function __destruct() {}

    public function draw() {
        $this->t += 1;
        return ($this->active_start <= $this->t && $this->t <= $this->active_end) ? 1.0 : 0.0;
    }
}

?>
