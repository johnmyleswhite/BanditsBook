<?php

/**
 * Random Float between 0 and 1 in PHP
 * http://stackoverflow.com/questions/14141212/random-float-between-0-and-1-in-php
 */
function random() {
	return (float) mt_rand() / (float) mt_getrandmax();
}

/**
 * how can I choose a random number but with a normal probability distribution in PHP? [closed]
 * http://stackoverflow.com/questions/15951563/how-can-i-choose-a-random-number-but-with-a-normal-probability-distribution-in-p
 */
function random_gauss($mean = 0.0, $sd = 1.0) {
	$x = random();
	$y = random();
	return sqrt(-2.0 * log($x)) * cos(2.0 * pi() * $y) * $sd + $mean;
}

?>
