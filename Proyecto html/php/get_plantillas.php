<?php
$conn = new mysqli("localhost", "root", "", "smart_train");
if ($conn->connect_error) { die("Error de conexión: " . $conn->connect_error); }
$res = $conn->query("SELECT id_plantilla, nombre_plantilla FROM Rutinas_Plantillas");
echo json_encode($res->fetch_all(MYSQLI_ASSOC));
?>

