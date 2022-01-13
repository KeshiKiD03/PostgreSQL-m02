<html>
<head>
    <title>Add Data</title>
</head>
 
<body>
<?php
//including the database connection file
include_once("config.php");
 
if(isset($_POST['Submit'])) {    
    $name = $_POST['name'];
    $age = $_POST['age'];
    $email = $_POST['email'];
        
    // checking empty fields
    if(empty($name) || empty($age) || empty($email)) {                
        if(empty($name)) {
            echo "<font color='red'>El campo nombre esta vacio.</font><br/>";
        }
        
        if(empty($age)) {
            echo "<font color='red'>El campo edad esta vacia.</font><br/>";
        }
        
        if(empty($email)) {
            echo "<font color='red'>El campo email esta vacio.</font><br/>";
        }
        
        //link to the previous page
        echo "<br/><a href='javascript:self.history.back();'>Retroceder</a>";
    } else { 
        // if all the fields are filled (not empty)             
        //insert data to database
        $result = mysqli_query($mysqli, "INSERT INTO users(name,age,email) VALUES('$name','$age','$email')");
        
        //display success message
        echo "<font color='green'>Se ha introducido con exito.";
        echo "<br/><a href='index.php'>Ver resultados</a>";
    }
}
?>
</body>
</html>