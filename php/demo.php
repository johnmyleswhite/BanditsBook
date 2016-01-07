<?php

require_once '/core.php';

$arm1 = new BernoulliArm(0.7);
$arm2 = new NormalArm(10.0, 1.0);
$arm3 = new BernoulliArm(0.2);

$arms = [$arm1, $arm2, $arm3];

// $algo1 = new EpsilonGreedy(0.1, [], []); # not implemented yet
// $algo2 = new Softmax(1.0, [], []); # not implemented yet
$algo3 = new UCB1([], []);
// $algo4 = new Exp3(0.2, []); # not implemented yet
$algo5 = new UCB2(0.1, [], []);

$num_sims = 1000;
$horizon = 10;

$algos = [$algo3];

$rows = '';
foreach ($algos as $algo) {
    $results = test_algorithm($algo, $arms, $num_sims, $horizon);
    for ($i = 0; $i < $num_sims * $horizon; $i++) {
        $rows .=
            '<tr><td>' . $results[0][$i] .
            '</td><td>' . $results[1][$i] .
            '</td><td>' . $results[2][$i] .
            '</td><td>' . $results[3][$i] .
            '</td><td>' . $results[4][$i] .
        '</td></tr>';
    }
}

$table =<<< EOD
<pre>
<table style="width: 100%">
    <thead>
        <tr>
            <td>sim_nums</td>
            <td>times</td>
            <td>chosen_arms</td>
            <td>rewards</td>
            <td>cumulative_rewards</td>
        </tr>
    </thead>
    <tbody>$rows</tbody>
</table>
</pre>
EOD;

echo $table;

?>
