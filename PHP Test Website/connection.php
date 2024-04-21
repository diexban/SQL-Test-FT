<?php
    $host = "sql301.infinityfree.com";
    $user = "if0_36403388";
    $password = 'JAfWwE1IqfK';
    $db_name = "if0_36403388_testft";

    $con = mysqli_connect($host, $user, $password, $db_name);
    if (mysqli_connect_errno()) {
        die("Failed to connect with MySQL: " . mysqli_connect_error());
}
?>