<?php
include ('connection.php');

$username = $_POST['user'];
$password = $_POST['pass'];

// To prevent SQL injection
$username = stripcslashes($username);
$password = stripcslashes($password);
$username = mysqli_real_escape_string($con, $username);
$password = mysqli_real_escape_string($con, $password);

$sql = "SELECT * FROM Users WHERE UserName = '$username' AND Password = '$password'";
$result = mysqli_query($con, $sql);
$count = mysqli_num_rows($result);

if ($count == 1) {
    echo "<h1><center> Login successful </center></h1>";
} else {
    echo "<h1> Login failed. Invalid username or password.</h1>";
}
?>
