<?php
/*
// mysql_connect("database-host", "username", "password")
$conn = mysql_connect("localhost","root","root") 
            or die("cannot connected");
 
// mysql_select_db("database-name", "connection-link-identifier")
@mysql_select_db("test",$conn);
*/
 
/**
 * mysql_connect is deprecated
 * using mysqli_connect instead
 */
 
$databaseHost = 'localhost';
$databaseName =  'a20mohwafche_gim';
$databaseUsername = 'a20mohwafche_gim';
$databasePassword = '123456789';
 
$mysqli = mysqli_connect($databaseHost, $databaseUsername, $databasePassword, $databaseName); 
?>