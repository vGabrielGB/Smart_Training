<?php
$conn = new mysqli("localhost", "root", "", "smart_train");
if ($conn->connect_error) { die("Error de conexión: " . $conn->connect_error); }
$id = intval($_GET['id_plantilla']);
$res = $conn->query("SELECT dia, Ejercicios.nombre_ejercicio, Plantilla_Ejercicios.* 
    FROM Plantilla_Ejercicios 
    JOIN Ejercicios ON Plantilla_Ejercicios.id_ejercicio = Ejercicios.id_ejercicio
    WHERE id_plantilla = $id
    ORDER BY FIELD(dia, 'Lunes','Martes','Miércoles','Jueves','Viernes','Sábado','Domingo'), orden");
$datos = [];
while($row = $res->fetch_assoc()) {
    $datos[$row['dia']][] = $row;
}
echo json_encode($datos);
?>