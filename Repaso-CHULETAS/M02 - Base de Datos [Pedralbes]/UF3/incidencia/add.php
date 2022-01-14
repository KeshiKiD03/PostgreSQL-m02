<html>
<head>
    <title>Add Data</title>
</head>
 
<body>
<?php
//including the database connection file
include_once("config.php");
 
if(isset($_POST['Submit'])) {    
    $dpt = $_POST['departament'];
    $desc = $_POST['descripcio'];
        
    // checking empty fields
    if(empty($dpt) || empty($desc)) {                
        if(empty($dpt)) {
            echo "<font color='red'>No has posat el num de departament</font><br/>";
        }
        
        if(empty($desc)) {
            echo "<font color='red'>No has posat la descripcio </font><br/>";
        }
    
        //link to the previous page
        echo "<br/><a href='javascript:self.history.back();'>Go Back</a>";
    } else { 
        // if all the fields are filled (not empty)             
        //insert data to database
        $result = mysqli_query($mysqli, "INSERT INTO INCIDENCIA(Codi_incidencia,descrpcio) VALUES('$dpt','$desc')");
        
        //display success message
        echo "<font color='green'>Incidencia afegida amb exit.";
        echo "<br/><a href='index.php'>Veure llista</a>";
    }
}
?>
</body>
</html>