<?php
$conn = new mysqli("localhost", "root", "", "smart_train");
if ($conn->connect_error) { die("Error de conexión: " . $conn->connect_error); }
$res = $conn->query("SELECT id_ejercicio, nombre_ejercicio, id_grupo_principal FROM Ejercicios");
echo json_encode($res->fetch_all(MYSQLI_ASSOC));
?>